//
//  KxLinguistic.m
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 27.11.14.

/*
 Copyright (c) 2014 Konstantin Bukreev All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "KxLinguistic.h"

static inline BOOL linguisticCharacterIsDashSymbol(unichar ch);
static inline BOOL linguisticCharacterIsQuoteSymbol(unichar ch);
static inline BOOL linguisticCharacterIsEndOfSentenceSymbol(unichar ch);

@implementation KxLinguistic

+ (NSLocale *) guessLocale:(NSString *)string
{
    NSLocale *locale;
    CFStringRef langRef = CFStringTokenizerCopyBestStringLanguage((__bridge CFStringRef)string,
                                                                  CFRangeMake(0, MIN(200, string.length)));
    if (langRef) {
        
        locale = [[NSLocale alloc] initWithLocaleIdentifier:(__bridge NSString*)langRef];
        CFRelease(langRef);
    }
    return locale;
}

+ (NSString *) guessLanguage:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
    
    if (!string.length) {
        return nil;
    }
    
    NSString *langCode;
    
    const NSLinguisticTaggerOptions options = NSLinguisticTaggerOmitPunctuation|NSLinguisticTaggerOmitWhitespace| NSLinguisticTaggerOmitOther;
    
    NSLinguisticTagger* ltagger = [[NSLinguisticTagger alloc] initWithTagSchemes:@[NSLinguisticTagSchemeLanguage]
                                                                         options:options];
    
    ltagger.string = string;
    
    langCode = [ltagger tagAtIndex:0
                            scheme:NSLinguisticTagSchemeLanguage
                        tokenRange:NULL
                     sentenceRange:NULL];
    
    if ([langCode isEqualToString:@"und"]) {
        langCode = nil;
    }
    
#define IS_ENG_CHAR(x) ((x > 96 && x < 123) || (x > 64 && x < 91))
#define IS_RUS_CHAR(x) ((x > 1039 && x < 1104) || (x == 1025) || (x == 1105))
    
    if (!langCode) {
        
        // maybe english?
        langCode = @"en";
        
        for (NSUInteger i = 0; i < string.length; ++i) {
            const unichar ch = [string characterAtIndex:i];
            if (!IS_ENG_CHAR(ch)) {
                langCode = nil;
                break;
            }
        }
    }
    
    if (!langCode) {
        
        // maybe russian?
        langCode = @"ru";
        
        for (NSUInteger i = 0; i < string.length; ++i) {
            const unichar ch = [string characterAtIndex:i];
            if (!IS_RUS_CHAR(ch)) {
                langCode = nil;
                break;
            }
        }
    }
    
    if (!langCode) {
        
        CFStringRef langRef = CFStringTokenizerCopyBestStringLanguage((__bridge CFStringRef)string,
                                                                      CFRangeMake(0, MIN(200, string.length)));
        if (langRef) {
            langCode = [(__bridge NSString*)langRef copy];
            CFRelease(langRef);
        }
    }
    
    if (!langCode) {
        
        NSOrthography *ortho = [ltagger orthographyAtIndex:0 effectiveRange:NULL];
        
        if (ortho) {
            
            langCode = ortho.dominantLanguage;
            if ([langCode isEqualToString:@"und"]) {
                langCode = nil;
            }
            
            if (!langCode) {
                
                NSString *dominantScript = ortho.dominantScript;
                
                if ([dominantScript isEqualToString:@"Latn"]) {
                    langCode = @"en";
                } else if ([dominantScript isEqualToString:@"Cyrl"]) {
                    langCode = @"ru";
                } else if ([dominantScript isEqualToString:@"Grek"]) {
                    langCode = @"el";
                } else if ([dominantScript isEqualToString:@"Jpan"]) {
                    langCode = @"ja";
                } else if ([dominantScript isEqualToString:@"Kore"]) {
                    langCode = @"ko";
                } else if ([dominantScript isEqualToString:@"Hans"]) {
                    langCode = @"zh-Hans";
                } else if ([dominantScript isEqualToString:@"Hant"]) {
                    langCode = @"zh-Hant";
                } else if ([dominantScript isEqualToString:@"Thai"]) {
                    langCode = @"th";
                } else if ([dominantScript isEqualToString:@"Arab"]) {
                    langCode = @"ar";
                } else if ([dominantScript isEqualToString:@"Deva"]) {
                    langCode = @"hi";
                } else if ([dominantScript isEqualToString:@"Hebr"]) {
                    langCode = @"he";
                }
            }
        }
    }
    
    if (langCode) {
        
        if ([langCode isEqualToString:@"uk"]) {
            langCode = @"ru";
        }
        
    } else {
        
        const unichar firstLetter = [string characterAtIndex:0];
        if (IS_ENG_CHAR(firstLetter)) {
            langCode = @"en";
        } else if (IS_RUS_CHAR(firstLetter)) {
            langCode = @"ru";
        }
    }
    
    return langCode;
}

+ (NSArray *) takeWords:(NSString *)text
{
    return [self takeWords:text locale:nil];
}

+ (NSArray *) takeSentences:(NSString *)text
{
    return [self takeSentences:text locale:nil];
}

+ (NSArray *) takeParagraphs:(NSString *)text
{
    return [self takeParagraphs:text locale:nil];
}

+ (NSArray *) takeWords:(NSString *)text
                 locale:(NSLocale *)locale
{
    return [self takeTokens:text
                    options:kCFStringTokenizerUnitWord
                     locale:locale];
}

+ (NSArray *) takeSentences:(NSString *)text
                     locale:(NSLocale *)locale
{
    return [self takeTokens:text
                    options:kCFStringTokenizerUnitSentence
                     locale:locale];
}

+ (NSArray *) takeParagraphs:(NSString *)text
                      locale:(NSLocale *)locale
{
    return [self takeTokens:text
                    options:kCFStringTokenizerUnitParagraph
                     locale:locale];
}

+ (NSArray *) takeTokens:(NSString *)text
                 options:(CFOptionFlags)options
                  locale:(NSLocale *)locale
{
    NSMutableArray *ma = [NSMutableArray array];
    
    CFLocaleRef localeRef = locale ? (__bridge CFLocaleRef)locale : CFLocaleCopyCurrent();
    
    CFStringTokenizerRef tokenizer = CFStringTokenizerCreate(NULL,
                                                             (__bridge CFStringRef)text,
                                                             CFRangeMake(0, text.length),
                                                             options,
                                                             localeRef);
    
    CFStringTokenizerTokenType tokenType = CFStringTokenizerGoToTokenAtIndex(tokenizer, 0);
    while (tokenType != kCFStringTokenizerTokenNone) {
        
        const CFRange cfRange = CFStringTokenizerGetCurrentTokenRange(tokenizer);
        
        if (cfRange.location != kCFNotFound &&
            (cfRange.location + cfRange.length) <= text.length)
        {
            NSString *s = [text substringWithRange:NSMakeRange(cfRange.location, cfRange.length)];
            [ma addObject:s];
        }
        
        tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer);
    }
    CFRelease(tokenizer);
    
    if (!locale && localeRef) {
        CFRelease(localeRef);
    }
    
    return ma.count ? [ma copy] : nil;
}

+ (NSArray *) enumerateTokens:(NSString *)text
                       locale:(NSLocale *)locale
                      options:(CFOptionFlags)options
                        block:(void(^)(NSRange tokenRange, CFStringTokenizerTokenType tokenType, BOOL *stop))block
{
    NSMutableArray *ma = [NSMutableArray array];
    
    CFLocaleRef localeRef = locale ? (__bridge CFLocaleRef)locale : CFLocaleCopyCurrent();
    
    CFStringTokenizerRef tokenizer = CFStringTokenizerCreate(NULL,
                                                             (__bridge CFStringRef)text,
                                                             CFRangeMake(0, text.length),
                                                             options,
                                                             localeRef);
    
    CFStringTokenizerTokenType tokenType = CFStringTokenizerGoToTokenAtIndex(tokenizer, 0);
    while (tokenType != kCFStringTokenizerTokenNone) {
        
        const CFRange cfRange = CFStringTokenizerGetCurrentTokenRange(tokenizer);
        
        if (cfRange.location != kCFNotFound &&
            (cfRange.location + cfRange.length) <= text.length)
        {
            BOOL stop = NO;
            block(NSMakeRange(cfRange.location, cfRange.length), tokenType, &stop);
            if (stop) {
                break;
            }
        }
        
        tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer);
    }
    CFRelease(tokenizer);
    
    if (!locale && localeRef) {
        CFRelease(localeRef);
    }
    
    return ma.count ? [ma copy] : nil;
}


+ (BOOL) characterIsDashSymbol:(unichar)ch
{
    return linguisticCharacterIsDashSymbol(ch);
}

+ (BOOL) characterIsQuoteSymbol:(unichar)ch
{
    return linguisticCharacterIsQuoteSymbol(ch);
}

+ (BOOL) characterIsEndOfSentenceSymbol:(unichar)ch
{
    return linguisticCharacterIsEndOfSentenceSymbol(ch);
}

@end

static inline BOOL linguisticCharacterIsDashSymbol(unichar ch)
{
    return (ch == 0x002D || // hyphen-minus
            ch == 0x007E || // tilde
            ch == 0x058A || // armenian hyphen
            ch == 0x05BE || // hebrew punctuation maqaf
            ch == 0x1400 || // canadian syllabics hyphen
            ch == 0x1806 || // mongolian todo soft hyphen
            ch == 0x2010 || // hyphen
            ch == 0x2011 || // non-breaking hyphen
            ch == 0x2012 || // figure dash
            ch == 0x2013 || // en dash
            ch == 0x2014 || // em dash
            ch == 0x2015 || // horizontal bar
            ch == 0x2053 || // swung dash
            ch == 0x207B || // superscript minus
            ch == 0x208B || // subscript minus
            ch == 0x2212 || // minus sign
            ch == 0x2E17 || // double oblique hyphen
            ch == 0x2E3A || // two-em dash
            ch == 0x2E3B || // hree-em dash
            ch == 0x301C || // wave dash
            ch == 0x3030 || // wavy dash
            ch == 0x30A0 );  // katakana-hiragana double hyphen
}

static inline BOOL linguisticCharacterIsQuoteSymbol(unichar ch)
{
    return (ch == 0x0022 || // quotation mark
            ch == 0x0027 || // apostrophe
            ch == 0x00AB || // left-pointing double angle quotation mark
            ch == 0x00BB || // right-pointing double angle quotation mark
            ch == 0x0060 || // grave accent
            ch == 0x00B4 || // acute accent
            ch == 0x2018 || // left single quotation mark
            ch == 0x2019 || // right single quotation mark
            ch == 0x201A || // single low-9 quotation mark
            ch == 0x201B || // ingle high-reversed-9 quotation mark
            ch == 0x201C || // left double quotation mark
            ch == 0x201D || // right double quotation mark
            ch == 0x201E || // double low-9 quotation mark
            ch == 0x201F || // double high-reversed-9 quotation mark
            ch == 0x201E || // double low-9 quotation mark
            ch == 0x201F || // double high-reversed-9 quotation mark
            ch == 0x2039 || // single left-pointing angle quotation mark
            ch == 0x203A || // single right-pointing angle quotation mark
            ch == 0x300C || // left corner bracket
            ch == 0x300D || // right corner bracket
            ch == 0x300E || // left white corner bracket
            ch == 0x300F || // right white corner bracket
            ch == 0x301D || // reversed double prime quotation mark
            ch == 0x301E || // double prime quotation mark
            ch == 0x301F ); // low double prime quotation mark
}

static inline BOOL linguisticCharacterIsEndOfSentenceSymbol(unichar ch)
{
    return (ch == '.' ||
            ch == '?' ||
            ch == '!' ||
            ch == 0x2026 // …
            );
}