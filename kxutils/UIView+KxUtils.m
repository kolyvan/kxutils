//
//  UIView+KxUtils.m
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

#import "UIView+KxUtils.h"
#import "UIColor+KxUtils.h"

@implementation UIView (KxUtils)

- (UIImage *) takeScreenshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    if (![self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO]) {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void) addGradientLayerWithColor:(UIColor *)color
{
    NSArray *colors = [color analogousColors];
    return [self addGradientLayerWithColors:colors];
}

- (void) addGradientLayerWithColors:(NSArray *)colors
{
    NSMutableArray *locations = [NSMutableArray arrayWithCapacity:colors.count];
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    
    NSUInteger i = 0;
    for (UIColor *color in colors) {
        
        [cgColors addObject:(id)color.CGColor];
        
        const CGFloat loc = (CGFloat)i / (CGFloat)(colors.count - 1);
        [locations addObject:@(loc)];
        ++i;
    }
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.masksToBounds = YES;
    gradient.colors = [cgColors copy];
    gradient.locations = [locations copy];
    
    [self.layer insertSublayer:gradient atIndex:0];
}

@end
