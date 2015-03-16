//
//  KxSerialization.m
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

#import "KxSerialization.h"
#import <objc/runtime.h>

static inline BOOL isPropertyListCompatibleClass(Class klass)
{
    return
    [klass isSubclassOfClass:[NSNumber class]] ||
    [klass isSubclassOfClass:[NSString class]] ||
    [klass isSubclassOfClass:[NSArray class]] ||
    [klass isSubclassOfClass:[NSDictionary class]] ||
    [klass isSubclassOfClass:[NSDate class]] ||
    [klass isSubclassOfClass:[NSData class]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////

/*
 FIXME: custom getters and setters are not supported
*/

@implementation NSObject (KxSerialization)

- (NSArray *) kx_seriazableProperties
{
    return [self.class kx_seriazableProperties];
}

static const char *kListOfPropertiesKey;

+ (NSArray *) kx_seriazableProperties
{
    NSArray *result = objc_getAssociatedObject(self, &kListOfPropertiesKey);
    if (!result) {
        
        NSSet *blacklist;
        if ([self conformsToProtocol:@protocol(KxSeriazable)] &&
            [self respondsToSelector:@selector(serializationBlacklistProperties)]) {
            
            blacklist = [self performSelector:@selector(serializationBlacklistProperties)];
        }
        
        NSMutableArray *ma = [NSMutableArray array];
        
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(self, &propertyCount);
        
        for (unsigned int i = 0; i < propertyCount; ++i) {
            
            objc_property_t property = properties[i];
            if ([self kx_validateProperty:property]) {
                
                const char *name = property_getName(property);
                if (name) {
                    
                    NSString *nsName = [NSString stringWithUTF8String:name];
                    if (nsName.length &&
                        (!blacklist || ![blacklist containsObject:nsName]))
                    {                        
                        [ma addObject:nsName];
                    }
                }
            }
        }
        
        free(properties);
        
        result = [ma copy];
        
        objc_setAssociatedObject(self,
                                 &kListOfPropertiesKey,
                                 result,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    
    return result;
}

- (void) kx_saveWithCoder:(NSCoder *)coder
{
    id<KxSerializationTransformer> transformer;
    if ([self conformsToProtocol:@protocol(KxSeriazable)] &&
        [self.class respondsToSelector:@selector(serializationTransformer)])
    {
        transformer = [(id<KxSeriazable>)self.class serializationTransformer];
    }
    
    for (NSString *key in [self kx_seriazableProperties]) {
        
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            
            id value = [self valueForKey:key];
            
            if (value) {
            
                if (transformer) {
                    value = [transformer transformSavingObject:self value:value key:key];
                }
                
                if ([value conformsToProtocol:@protocol(NSCoding)]) {
                    [coder encodeObject:value forKey:key];
                }
            }
        }
    }
}

- (void) kx_loadWithCoder:(NSCoder *)decoder
{
    id<KxSerializationTransformer> transformer;
    if ([self conformsToProtocol:@protocol(KxSeriazable)] &&
        [self.class respondsToSelector:@selector(serializationTransformer)])
    {
        transformer = [(id<KxSeriazable>)self.class serializationTransformer];
    }
    
    for (NSString *key in [self kx_seriazableProperties]) {
        
        if ([self.class kx_hasSetSelectorForKey:key]) {
            
            Class klass = [self.class kx_classOfValueForPropertyNamed:key];
            if (klass) {
                
                id value = [decoder decodeObjectForKey:key];
                
                if (value) {
                    
                    if (transformer) {
                        value = [transformer transformLoadingObject:self value:value key:key];
                    }
                    
                    if ([value isKindOfClass:klass]) {
                        
                        NSError *error;
                        if ([self validateValue:&value forKey:key error:&error]) {
                            @try {
                                [self setValue:value forKey:key];
                            } @catch (NSException *exception) {
#ifdef DEBUG
                                NSLog(@"catch KVC exception: %@", exception);
#endif
                            }
                        }
                    }
                }
            }
        }
    }
}

- (NSDictionary *) kx_saveAsDictionary
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    id<KxSerializationTransformer> transformer;
    if ([self conformsToProtocol:@protocol(KxSeriazable)] &&
        [self.class respondsToSelector:@selector(serializationTransformer)])
    {
        transformer = [(id<KxSeriazable>)self.class serializationTransformer];
    }
    
    for (NSString *key in [self kx_seriazableProperties]) {
        
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            
            id value = [self valueForKey:key];
            
            if (value) {
                
                if (transformer) {
                    value = [transformer transformSavingObject:self value:value key:key];
                }
                
                Class klass = ((NSObject *)value).class;
                
                if (!isPropertyListCompatibleClass(klass))
                {
                    value = [value kx_saveAsDictionary];
                    if (!value) {
                        continue;
                    }
                }
                
                result[key] = value;
            }
        }
    }
    
    return result.count ? [result copy] : nil;
}

- (void) kx_loadWithDictionary:(NSDictionary *)dict
{
    id<KxSerializationTransformer> transformer;
    if ([self conformsToProtocol:@protocol(KxSeriazable)] &&
        [self.class respondsToSelector:@selector(serializationTransformer)])
    {
        transformer = [(id<KxSeriazable>)self.class serializationTransformer];
    }
    
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
        
        if ([self.class kx_hasSetSelectorForKey:key]) {
            
            Class klass = [self.class kx_classOfValueForPropertyNamed:key];
            if (klass) {
            
                if (transformer) {
                    value = [transformer transformLoadingObject:self value:value key:key];
                }
                                
                if ([value isKindOfClass:[NSDictionary class]] &&
                    !isPropertyListCompatibleClass(klass))
                {
                    id obj = [[klass alloc] init];
                    [obj kx_loadWithDictionary:value];
                    value = obj;
                }
                
                if ([value isKindOfClass:klass]) {
                    
                    NSError *error;
                    if ([self validateValue:&value forKey:key error:&error]) {
                        @try {
                            [self setValue:value forKey:key];
                        } @catch (NSException *exception) {
#ifdef DEBUG
                            NSLog(@"catch KVC exception: %@", exception);
#endif
                        }
                    }
                }
            }
        }
    }];
}

+ (NSString *) kx_setSelectorNameForKey:(NSString *)key
{
    NSMutableString *ms = [NSMutableString stringWithString:@"set"];
    [ms appendString: [key substringToIndex:1].uppercaseString];
    if (key.length > 1) {
        [ms appendString: [key substringFromIndex:1]];
    }
    [ms appendString:@":"];
    return ms;
}

+ (BOOL) kx_hasSetSelectorForKey:(NSString *)key
{
    objc_property_t property = class_getProperty(self, key.UTF8String);
    if (!property) {
        return NO;
    }
    NSString *selName = [self kx_setSelectorNameForKey:key];
    SEL sel = NSSelectorFromString(selName);
    return [self instancesRespondToSelector:sel];
}

+ (SEL) kx_setSelectorForKey:(NSString *)key
{
    objc_property_t property = class_getProperty(self, key.UTF8String);
    if (!property) {
        return nil;
    }
    NSString *selName = [self kx_setSelectorNameForKey:key];
    SEL sel = NSSelectorFromString(selName);
    if ([self instancesRespondToSelector:sel]) {
        return sel;
    }
    return nil;
}

+ (Class) kx_classOfValueForPropertyNamed:(NSString *)name
{
    objc_property_t property = class_getProperty(self, name.UTF8String);
    if (property) {
        return [self kx_classOfValueForProperty:property];
    }
    return nil;
}

+ (Class) kx_classOfValueForProperty:(objc_property_t) property
{
    const char *attrs = property_getAttributes(property);
    if (!attrs) {
        return nil;
    }
    
    const char *readonly = strstr(attrs, ",R");
    if (readonly) {
        return nil;
    }
    
    const char *p0 = strchr(attrs, 'T');
    if (p0) {
        
        const char *p1 = strchr(p0, ',');
        if (p1 > p0) {
      
            const char type = *(p0 + 1);
            switch (type) {
                case 'c': case 'i': case 's': case 'l': case 'q':
                case 'C': case 'I': case 'S': case 'L': case 'Q':
                case 'f': case 'd': case 'B':
                    return [NSNumber class];
                    
                case '@':
                    if ( (p1 - p0) > 4 &&
                        *(p0 + 2) == '"' &&
                        *(p1 - 1) == '"')
                    {
                        NSString *clsName = [[NSString alloc] initWithBytes:p0 + 3
                                                                     length:p1 - p0 - 4
                                                                   encoding:NSASCIIStringEncoding];
                        return NSClassFromString(clsName);
                        
                    } else if ((p1 - p0) == 3 &&
                               *(p0 + 2) == '?') {
                        
                        return nil; // it's a block
                        
                    } else {
                    
                        return [NSObject class];
                    }
                    
                default: // unsupported type
                    break;
            }
            
        }
    }
    
    return nil;
}

+ (BOOL) kx_validateProperty:(objc_property_t) property
{
    const char *attrs = property_getAttributes(property);
    if (!attrs) {
        return NO;
    }

    const char *readonly = strstr(attrs, ",R");
    if (readonly) {
        return NO;
    }

    const char *p0 = strchr(attrs, 'T');
    if (p0) {
        
        const char *p1 = strchr(p0, ',');
        if (p1 > p0) {
            
            const char type = *(p0 + 1);
            switch (type) {
                case 'c': case 'i': case 's': case 'l': case 'q':
                case 'C': case 'I': case 'S': case 'L': case 'Q':
                case 'f': case 'd': case 'B':
                case '@':
                    return YES;
                    
                default: // unsupported
                    break;
            }
            
        }
    }
    
    return NO;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation KxSerialization

+ (BOOL) saveObjectAsJson:(id)object
                   atPath:(NSString *)path
                    error:(NSError **)outError
{
    NSCParameterAssert(path.length);
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                   options:0 //NSJSONWritingPrettyPrinted
                                                     error:outError];
    if (!data) {
        return NO;
    }
    
    return [data writeToFile:path options:0 error:outError];
}

+ (id) loadObjectFromJson:(NSString *)path
                    error:(NSError **)outError
{
    NSCParameterAssert(path.length);
    
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:outError];
    if (!data.length) {
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:outError];
}

+ (BOOL) saveObjectAsPlist:(id)object
                    atPath:(NSString *)path
                     error:(NSError **)outError
{
    NSCParameterAssert(path.length);
    
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:object
                                                              format:NSPropertyListBinaryFormat_v1_0
                                                             options:0
                                                               error:outError];
    if (!data) {
        return NO;
    }
    
    return [data writeToFile:path options:0 error:outError];
}

+ (id) loadObjectFromPlist:(NSString *)path
                     error:(NSError **)outError
{
    NSCParameterAssert(path.length);
    
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:outError];
    if (!data.length) {
        return nil;
    }
    
    return [NSPropertyListSerialization propertyListWithData:data
                                                     options:NSPropertyListImmutable
                                                      format:nil
                                                       error:outError];
}

+ (void) saveObject:(id)object withCoder:(NSCoder *)coder
{
    [object kx_saveWithCoder:coder];
}

+ (void) loadObject:(id)object withCoder:(NSCoder *)decoder
{
    [object kx_loadWithCoder:decoder];
}

+ (NSDictionary *) saveObjectAsDictionary:(id)object
{
    return [object kx_saveAsDictionary];
}

+ (void) loadObject:(id)object withDictionary:(NSDictionary *)dict
{
    [object kx_loadWithDictionary:dict];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation KxSerializationTransformerDate

+ (instancetype) sharedTransformer
{
    static KxSerializationTransformerDate *p;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        p = [KxSerializationTransformerDate new];
    });
    return p;
}

- (id) transformSavingObject:(id)object
                       value:(id)value
                         key:(NSString *)key
{
    if ([value isKindOfClass:[NSDate class]]) {
        return [NSNumber numberWithDouble:[(NSDate *)value timeIntervalSinceReferenceDate]];
    }
    return value;
}

- (id) transformLoadingObject:(id)object
                        value:(id)value
                          key:(NSString *)key
{
    if ([value isKindOfClass:[NSNumber class]] &&
        [[[object class] kx_classOfValueForPropertyNamed:key] isSubclassOfClass:[NSDate class]]) {
        return [NSDate dateWithTimeIntervalSinceReferenceDate:[value doubleValue]];
    }
    return value;
}

@end