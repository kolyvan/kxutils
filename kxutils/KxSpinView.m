//
//  KxSpinView.m
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

#import "KxSpinView.h"
@import QuartzCore;

@implementation KxSpinView {
    
    UIImageView     *_spinView;
    UIImageView     *_backView;
    NSTimeInterval  _timestamp;
}

- (instancetype)initWithFrame:(CGRect)frame
                    spinImage:(UIImage *)spinImage
{
    self = [super initWithFrame:frame];
    if (self) {
        self.spinImage = spinImage;
        _speed = 0.8f;
    }
    return self;
}

- (void) willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        _timestamp = 0;
        [self _stopAnimating];
    }
}

- (void) setSpinImage:(UIImage *)spinImage
{
    if (_spinImage != spinImage) {
        
        _spinImage = spinImage;
        
        if (_spinView) {
            [_spinView removeFromSuperview];
            _spinView = nil;
        }
        
        if (_spinImage) {
            
            _spinView = [[UIImageView alloc] initWithImage:_spinImage];
            _spinView.contentMode = UIViewContentModeScaleAspectFit;
            _spinView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            _spinView.frame = self.bounds;
            _spinView.hidden = _hidesWhenStopped && !self.isAnimating;
            [self addSubview:_spinView];
        }
    }
}

- (void) setBackImage:(UIImage *)backImage
{
    if (_backImage != backImage) {
        
        _backImage = backImage;
        
        if (_backView) {
            [_backView removeFromSuperview];
            _backView = nil;
        }
        
        if (_backImage) {
            
            const CGSize mySize = self.bounds.size;
            
            _backView = [[UIImageView alloc] initWithImage:_backImage];
            _backView.contentMode = UIViewContentModeScaleAspectFit;
            _backView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|
            UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
            _backView.frame = (CGRect){6,6,mySize.width - 12, mySize.height - 12};
            _backView.hidden = _hidesWhenStopped && !self.isAnimating;
            [self insertSubview:_backView atIndex:0];
        }
    }
}

- (BOOL) isAnimating
{
    return _timestamp > 0;
}

- (void) startAnimating
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(_stopAnimating)
                                               object:nil];
    
    CALayer *layer = _spinView.layer;
    
    if (_timestamp > 0 &&
        [layer animationForKey:@"KxSpinView"])
    {
        // already animating
        return;
    }
    
    _spinView.hidden = NO;
    _backView.hidden = NO;
    
    CATransform3D startValue = CATransform3DIdentity;
    CATransform3D endValue = CATransform3DRotate(startValue, M_PI_2, 0, 0, 1);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = _speed * 0.5f;
    animation.repeatCount = HUGE_VALF;
    animation.cumulative = YES;
    
    //CAMediaTimingFunction* clunk = [CAMediaTimingFunction functionWithControlPoints:.9 :.1 :.7 :.9];
    //animation.timingFunction = clunk;
    
    animation.fromValue = [NSValue valueWithCATransform3D:startValue];
    animation.toValue = [NSValue valueWithCATransform3D:endValue];
    
    //[layer removeAnimationForKey:@"KxSpinView"];
    [layer addAnimation:animation forKey:@"KxSpinView"];
    
    _timestamp = [NSDate timeIntervalSinceReferenceDate];
}

- (void) stopAnimating
{
    if (!_timestamp) {
        return;
    }
    
    const CGFloat duration = _speed * 0.5f;
    
    NSTimeInterval seconds = [NSDate timeIntervalSinceReferenceDate] - _timestamp;
    seconds = fabs(remainder(seconds, duration));
    
    _timestamp = 0;
    
    if (seconds < duration) {
        
        // wait till end of animation
        
        [self performSelector:@selector(_stopAnimating)
                   withObject:nil
                   afterDelay:duration - seconds];
        
    } else {
        
        [self _stopAnimating];
    }
}

- (void) _stopAnimating
{
    CALayer *layer = _spinView.layer;
    [layer removeAnimationForKey:@"KxSpinView"];
    if (_hidesWhenStopped) {
        _spinView.hidden = YES;
        _backView.hidden = YES;
    } else {
        if (_backImage) {
            _spinView.hidden = YES;
        }
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (!size.width)  size.width = _spinImage.size.width;
    if (!size.height) size.height = _spinImage.size.height;
    
    return (CGSize) {
        MIN(_spinImage.size.width, size.width),
        MIN(_spinImage.size.height, size.height)
    };
}

@end
