//
//  KxError.m
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 02.12.14.

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

#import "KxError.h"

NSError * mkError(NSUInteger code,
                  NSString *domain,
                  NSString *description,
                  NSString *reason, ...)
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    if (description.length) {
        userInfo[NSLocalizedDescriptionKey] = description;
    }
    
    if (reason) {
        
        va_list args;
        va_start(args, reason);
        NSString *stringReason = [[NSString alloc] initWithFormat:reason arguments:args];
        va_end(args);
        
        userInfo[NSLocalizedFailureReasonErrorKey] = stringReason;
    }
    
    return [NSError errorWithDomain:domain
                               code:code
                           userInfo:[userInfo copy]];
}

NSError * mkErrorWithError(NSError *underlying,
                           NSUInteger code,
                           NSString *domain,
                           NSString *description,
                           NSString *reason, ...)
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    if (underlying) {
        userInfo[NSUnderlyingErrorKey] = underlying;
    }
    
    if (description.length) {
        userInfo[NSLocalizedDescriptionKey] = description;
    }
    
    if (reason) {
        
        va_list args;
        va_start(args, reason);
        NSString *stringReason = [[NSString alloc] initWithFormat:reason arguments:args];
        va_end(args);
        
        userInfo[NSLocalizedFailureReasonErrorKey] = stringReason;
    }
    
    return [NSError errorWithDomain:domain
                               code:code
                           userInfo:[userInfo copy]];
}

NSString *messageWithPosixErrorNum(int errnum)
{
    NSString *message;
    char buffer[1024] = {0};
    if (!strerror_r(errnum, buffer, sizeof(buffer))) {
        message = [NSString stringWithUTF8String:buffer];
    }
    if (!message.length) {
        message = [NSString stringWithFormat:@"ERR: %d", errnum];
    }
    return message;
}