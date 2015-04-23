//
//  KxRatingView.m
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

#import "KxRatingView.h"
#import "UIColor+KxUtils.h"
#import "KxColorPallete.h"
#import "UIBezierPath+KxUitls.h"

@implementation KxRatingView {
    
    UIBezierPath *_markPath;
}

- (void) setTitle:(NSString *)title
{
    if (![_title isEqualToString:title]) {
        _title = [title copy];
        [self setNeedsDisplay];
        [self invalidateIntrinsicContentSize];
    }
}

- (void) setTitleFont:(UIFont *)titleFont
{
    if (![_titleFont isEqual:titleFont]) {
        _titleFont = titleFont;
        [self setNeedsDisplay];
        [self invalidateIntrinsicContentSize];
    }
}

- (void) setMarkColor:(UIColor *)markColor
{
    if (![_markColor isEqual:markColor]) {
        _markColor = markColor;
        [self setNeedsDisplay];
    }
}

- (void) setGrayColor:(UIColor *)grayColor
{
    if (![_grayColor isEqual:grayColor]) {
        _grayColor = grayColor;
        [self setNeedsDisplay];
    }
}

- (void) setTitleColor:(UIColor *)titleColor
{
    if (![_titleColor isEqual:_titleColor]) {
        _titleColor = titleColor;
        [self setNeedsDisplay];
    }
}

- (void) setMarkFontName:(NSString *)markFontName
{
    if (![_markFontName isEqualToString:markFontName]) {
        _markFontName = markFontName;
        _markPath = nil;
        [self setNeedsDisplay];
        [self invalidateIntrinsicContentSize];
    }
}

- (void) setMarkFontSize:(CGFloat)markFontSize
{
    if (_markFontSize != markFontSize) {
        _markFontSize = markFontSize;
        _markPath = nil;
        [self setNeedsDisplay];
        [self invalidateIntrinsicContentSize];
    }
}

- (void) setMarkLetter:(unichar)markLetter
{
    if (_markLetter != markLetter) {
        _markLetter = markLetter;
        _markPath = nil;
        [self setNeedsDisplay];
        [self invalidateIntrinsicContentSize];
    }
}

- (void) setMaxValue:(NSUInteger)maxValue
{
    if (_maxValue != maxValue) {
        _maxValue = maxValue;
        [self setNeedsDisplay];
        [self invalidateIntrinsicContentSize];
    }
}

- (void) setValue:(CGFloat)value
{
    [self setValue:value fireEvent:NO];
}

- (void) setValue:(CGFloat)value
        fireEvent:(BOOL)fireEvent
{
    if (fabs(_value - value) > FLT_EPSILON) {
                
        _value = value;
        [self setNeedsDisplay];
        
        if (fireEvent) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIFontDescriptor *fd = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
        
        _titleFont = [UIFont fontWithDescriptor:fd size:0];
        _markColor = [KxColorPalleteSeven yellowColor];
        _grayColor = [KxColorPalleteSeven lightGrayColor];
        _titleColor = [UIColor darkTextColor];
        _maxValue = 5.0f;
        _markLetter = 0x2605;
        _markFontSize = fd.pointSize;
        
        self.contentMode = UIViewContentModeRedraw;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIBezierPath *)markPath
{    
    if (!_markPath) {
        
        _markPath = [UIBezierPath bezierPathWithLetter:_markLetter
                                              fontName:_markFontName
                                              fontSize:_markFontSize];
        
        if (!_markPath) {  // surrogate mark sybmol
            const CGRect oval = {0 ,0, _markFontSize, _markFontSize};
            _markPath = [UIBezierPath bezierPathWithOvalInRect:oval];
        }
    }
    
    return _markPath;
}

static const CGFloat kMargin = 4.0f;

- (CGFloat) widthOfMarks
{
    const CGSize markSize = self.markPath.bounds.size;
    return markSize.width * _maxValue + (_maxValue - 1) * kMargin;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (!size.width)  size.width = HUGE_VALF;
    if (!size.height) size.height = HUGE_VALF;
    
    const CGSize markSize = self.markPath.bounds.size;
    const CGFloat wMarks = [self widthOfMarks];
    
    CGSize titleSize = {0};
    
    if (_title.length) {
        
        titleSize = [_title boundingRectWithSize:(CGSize){ size.width - wMarks - kMargin }
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{ NSFontAttributeName : _titleFont }
                                         context:nil].size;        
        
        titleSize.width += kMargin;
    }
    
    const CGFloat W = roundf(wMarks + titleSize.width + kMargin);
    const CGFloat H = roundf(MAX(markSize.height, titleSize.height)) + kMargin;
    
    return (CGSize){ MIN(W, size.width), MIN(H, size.height) };
}

- (CGSize)intrinsicContentSize
{
    return [self sizeThatFits:CGSizeZero];
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInContext:context bounds:self.bounds];
}

/*
- (UIImage *) contentImage
{
    const CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInContext:context bounds:self.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
*/

- (void) drawInContext:(CGContextRef)context
                bounds:(CGRect)bounds
{
    const CGSize markSize = self.markPath.bounds.size;
    const CGSize size = bounds.size;
    
    CGFloat X = bounds.origin.x;
    CGFloat Y = bounds.origin.y + roundf((size.height - markSize.height) * 0.5f) + 1.0f;
        
    for (NSUInteger i = 0; i < _maxValue; ++i) {
        
        UIBezierPath *path = [_markPath copy];
        CGAffineTransform t = CGAffineTransformMakeTranslation(roundf(X), Y);
        [path applyTransform:t];
        
        if (i < (NSUInteger)_value) {
            
            [_markColor set];
            [path fill];
            [path stroke];
            
        } else if (i < ceilf(_value)) {
            
            [_markColor set];
            
            CGContextSaveGState(context);
            
            const CGFloat fraction = _value - floorf(_value);
            CGRect clipRect = { 0, 0, X + markSize.width * fraction + 1.0f, size.height };
            CGContextClipToRect(context, clipRect);
            
            [path fill];
            
            CGContextRestoreGState(context);
            
            [path stroke];
            
        } else {
            
            [_grayColor set];
            [path stroke];
        }
        
        X += markSize.width + kMargin;
    }
    
    if (_title.length) {
        
        Y = roundf((size.height - _titleFont.lineHeight) * 0.5f);
        
        [_title drawWithRect:(CGRect){ roundf(X), Y, size.width - X, size.height - Y }
                     options:NSStringDrawingUsesLineFragmentOrigin
                  attributes:@{
                               NSFontAttributeName : _titleFont,
                               NSForegroundColorAttributeName : _titleColor,
                               }
                     context:nil];
    }
}

#pragma mark - touches

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return !self.isUserInteractionEnabled;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super beginTrackingWithTouch:touch withEvent:event];
    if (!self.isFirstResponder) {
        [self becomeFirstResponder];
    }
    [self checkTouch:touch isMoved:NO];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super continueTrackingWithTouch:touch withEvent:event];
    [self checkTouch:touch isMoved:YES];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    if ([self isFirstResponder]) {
        [self resignFirstResponder];
    }
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    [super cancelTrackingWithEvent:event];
    if (self.isFirstResponder) {
        [self resignFirstResponder];
    }
}

- (void) checkTouch:(UITouch *)touch isMoved:(BOOL)isMoved
{
    const CGPoint location = [touch locationInView:self];
    const CGFloat wMarks = [self widthOfMarks];
    
    if (location.x > 0 && location.x < wMarks)
    {
        if (isMoved) {
        
            const NSUInteger val = roundf(location.x / wMarks * _maxValue + 0.25f);
            [self setValue:val fireEvent:YES];
            
        } else {
            
            const NSUInteger val = ceilf(location.x / wMarks * _maxValue);
            const NSUInteger curVal = roundf(self.value);
            
            if (curVal >= val && val > 0) {
                [self setValue:val-1 fireEvent:YES];
            } else {
                [self setValue:val fireEvent:YES];
            }
        }
        
    } else if (location.x >= wMarks) {
        
        [self setValue:_maxValue fireEvent:YES];
        
    } else if (location.x <= 0 ) {
        
        [self setValue:0 fireEvent:YES];
    }
}

@end
