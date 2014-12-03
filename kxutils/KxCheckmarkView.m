//
//  KxCheckmarkView.m
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 03.12.14.

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

#import "KxCheckmarkView.h"
#import "UIColor+KxUtils.h"
#import "KxColorPallete.h"

@implementation KxCheckmarkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _foreColor = [UIColor whiteColor];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (!size.width)  size.width = 24.f;
    if (!size.height) size.height = 24.f;
    const CGFloat D = MIN(size.width, size.height);
    return (CGSize){D, D};
}

- (void)drawRect:(CGRect)rect
{
    const CGFloat W = self.bounds.size.width;
    const CGFloat H = self.bounds.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    UIColor *tintColor = self.tintColor ? self.tintColor : [KxColorPalleteSystem infoBlueColor];    
    UIColor *foreColor = _foreColor ? _foreColor : [tintColor contrastingColor];
    
    // border
    CGContextSetFillColorWithColor(context, foreColor.CGColor);
    CGContextFillEllipseInRect(context, self.bounds);
    
    // body
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectInset(self.bounds, 1.f, 1.f));
    
    // checkmark
    CGContextSetStrokeColorWithColor(context, foreColor.CGColor);
    CGContextSetLineWidth(context, MAX(1.f, 0.05f * W));
    
    CGContextMoveToPoint(context,    roundf(.25f * W), roundf(.500f * H));
    CGContextAddLineToPoint(context, roundf(.42f * W), roundf(.667f * H));
    CGContextAddLineToPoint(context, roundf(.75f * W), roundf(.330f * H));
    
    CGContextStrokePath(context);
}

@end
