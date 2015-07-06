//
//  KxRoundProgressView.m
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

#import "KxRoundProgressView.h"
#import "UIColor+KxUtils.h"
#import "KxColorPallete.h"

@implementation KxRoundProgressView

- (void) setProgress:(CGFloat)progress
{
    if (progress < 0.) {
        progress = 0.;
    } else if (progress > 1.) {
        progress = 1.;
    }
    
    if (fabs(_progress - progress) > FLT_EPSILON) {
        
        _progress = progress;
        [self setNeedsDisplay];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
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

- (void) drawRect:(CGRect)rect
{
    const CGFloat W = self.bounds.size.width;
    const CGFloat H = self.bounds.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *tintColor = self.tintColor ? self.tintColor : [KxColorPalleteSystem infoBlueColor];
    
    if (_progress < 1.f) {
        
        // background
        const CGFloat kLine = 2.0f;
        const CGRect ellipseRect = CGRectInset(self.bounds, kLine, kLine);
        
        CGContextSetFillColorWithColor(context, [tintColor colorWithAlphaComponent:0.1f].CGColor);
        CGContextSetStrokeColorWithColor(context, tintColor.CGColor);
        
        CGContextSetLineWidth(context, kLine);
        CGContextFillEllipseInRect(context, ellipseRect);
        CGContextStrokeEllipseInRect(context, ellipseRect);
        
        // progress
        const CGPoint center = {
            roundf(W * 0.5f),
            roundf(H * 0.5f),
        };
        
        const CGFloat radius = roundf((W - kLine * 2.f) * 0.5f);
        
        const CGFloat startAngle = - M_PI_2; // 90 degrees
        const CGFloat endAngle = (_progress * 2.f * (CGFloat)M_PI) + startAngle;
        
        CGContextSetFillColorWithColor(context, tintColor.CGColor);
        
        CGContextMoveToPoint(context, center.x, center.y);
        CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, 0);
        CGContextClosePath(context);
        CGContextFillPath(context);
        
    } else {
        
        //CGContextSetFillColorWithColor(context, tintColor.CGColor);
        //CGContextFillEllipseInRect(context, self.bounds);
        
        // checkmark
        CGContextSetStrokeColorWithColor(context, tintColor.CGColor);
        CGContextSetLineWidth(context, MAX(1.f, 0.09f * W));
        
        CGContextMoveToPoint(context,    roundf(.25f * W), roundf(.500f * H));
        CGContextAddLineToPoint(context, roundf(.42f * W), roundf(.667f * H));
        CGContextAddLineToPoint(context, roundf(.75f * W), roundf(.330f * H));
        
        CGContextStrokePath(context);
    }
}

@end
