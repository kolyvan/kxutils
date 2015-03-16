//
//  KxSerialization.h
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

#import <Foundation/Foundation.h>

@interface KxSerialization : NSObject

+ (BOOL) saveObjectAsJson:(id)object
                   atPath:(NSString *)path
                    error:(NSError **)outError;

+ (id) loadObjectFromJson:(NSString *)path
                    error:(NSError **)outError;

+ (BOOL) saveObjectAsPlist:(id)object
                    atPath:(NSString *)path
                     error:(NSError **)outError;

+ (id) loadObjectFromPlist:(NSString *)path
                     error:(NSError **)outError;

+ (void) saveObject:(id)object
          withCoder:(NSCoder *)coder;

+ (void) loadObject:(id)object
          withCoder:(NSCoder *)decoder;

+ (NSDictionary *) saveObjectAsDictionary:(id)object;

+ (void) loadObject:(id)object
     withDictionary:(NSDictionary *)dict;

@end

@protocol KxSerializationTransformer<NSObject>
- (id) transformSavingObject:(id)object
                       value:(id)value
                         key:(NSString *)key;
- (id) transformLoadingObject:(id)object
                        value:(id)value
                          key:(NSString *)key;
@end

@protocol KxSeriazable <NSObject>
@optional
+ (NSSet *) serializationBlacklistProperties;
+ (id<KxSerializationTransformer>) serializationTransformer;
@end

// transforms NSDate <-> double (timeIntervalSinceReferenceDate)
@interface KxSerializationTransformerDate : NSObject<KxSerializationTransformer>
+ (instancetype) sharedTransformer __attribute__((const));
@end
