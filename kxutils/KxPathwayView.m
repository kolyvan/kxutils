//
//  KxPathwayView.m
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

#import "KxPathwayView.h"
#import "KxColorPallete.h"

@implementation KxPathwayItem

+ (instancetype) pathwayItemWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title image:nil];
}

+ (instancetype) pathwayItemWithTitle:(NSString *)title image:(UIImage *)image
{
    return [[self alloc] initWithTitle:title image:image];
}

- (instancetype) initWithTitle:(NSString *)title
                         image:(UIImage *)image
{
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
    }
    return self;
}

@end

////////////////////////////////////////////////////////////////////////////////

@interface KxPathwayItemHelperView : UIView
@property (readonly, nonatomic, strong) UIImageView *divider;
@property (readonly, nonatomic, strong) UIButton *button;
@end

@implementation KxPathwayItemHelperView

- (id) initWithItem:(KxPathwayItem *)item
       dividerImage:(UIImage *)dividerImage
          titleFont:(UIFont *)titleFont
         titleColor:(UIColor *)titleColor
          tintColor:(UIColor *)tintColor
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.autoresizingMask = UIViewAutoresizingNone;
        
        if (item.title) {
            
            _button.titleLabel.font = titleFont;
            
            [_button setTitle:item.title
                     forState:UIControlStateNormal];
            
            [_button setTitleColor:titleColor
                          forState:UIControlStateNormal];
            
            [_button setTitleColor:tintColor
                          forState:UIControlStateHighlighted];
        }
        if (item.image) {
            [_button setImage:item.image forState:UIControlStateNormal];
            _button.showsTouchWhenHighlighted = YES;
        }
        
        [_button sizeToFit];
        [self addSubview:_button];
        
        if (dividerImage) {
            
            _divider = [[UIImageView alloc] initWithImage:dividerImage];
            _divider.contentMode = UIViewContentModeCenter;
            _divider.opaque = NO;
            _divider.backgroundColor = [UIColor clearColor];
            _divider.autoresizingMask = UIViewAutoresizingNone;
            [self addSubview:_divider];
        }
    }
    return self;
}

- (CGSize) sizeThatFits:(CGSize)size
{
    if (!size.width)  size.width = HUGE_VALF;
    if (!size.height) size.height = HUGE_VALF;
    
    if (_divider) {
        
        const CGFloat wImage = _divider.image.size.width;
        const CGFloat wButton = size.width - wImage - 8.0f;
        
        const CGSize sizeButton = [_button sizeThatFits:(CGSize){wButton, size.height}];
        
        return (CGSize){
            MIN(size.width, wImage + 8.0f + sizeButton.width),
            MIN(size.height, sizeButton.height)
        };
        
    } else {
        
        return [_button sizeThatFits:size];
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    const CGSize size = self.bounds.size;
    
    if (_divider) {
        
        const CGFloat wImage = _divider.image.size.width;
        const CGFloat wButton = size.width - wImage - 8.0f;
        
        _button.frame = (CGRect){0, 0, wButton, size.height};
        _divider.frame = (CGRect){wButton + 4.0f, 0, wImage, size.height};
        
    } else {
        
        _button.frame = (CGRect){0, 0, size};
    }
}

@end

////////////////////////////////////////////////////////////////////////////////

@implementation KxPathwayView {
    UIFont      *_titleFont;
    UIButton    *_upButton;
}

- (void) setItems:(NSArray *)items
{
    if (![_items isEqualToArray:items]) {
        _items = items;
        [self setupButtons];
        [self setNeedsLayout];
    }
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _edgeInsets = UIEdgeInsetsMake(0, 5.f, 0, 0);
    }
    return self;
}

- (UIImage *) dividerImage
{
    if (!_dividerImage) {
        
        const CGFloat W = 6.0f;
        const CGFloat H = self.titleFont.lineHeight;
        const CGSize size = { W, H };
        
        _dividerImage = [KxPathwayView dividerImageWithSize:size
                                                      color:[self.titleColor colorWithAlphaComponent:0.5]];
        
    }
    return _dividerImage;
}

- (UIFont *)titleFont
{
    if (!_titleFont) {
        
        if ([UIFontDescriptor class]) {
            
            UIFontDescriptor *fd;
            fd = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
            _titleFont = [UIFont fontWithDescriptor:fd size:0];
            
        } else {
            
            _titleFont = [UIFont systemFontOfSize:16];
        }
    }
    
    return _titleFont;
}

- (UIColor *) titleColor
{
    if (!_titleColor) {
        _titleColor = [UIColor darkTextColor];
    }
    return _titleColor;
}

- (UIButton *) upButton
{
    if (!_upButton) {
        
        _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _upButton.autoresizingMask = UIViewAutoresizingNone;
        _upButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_upButton setTitle:@"\u25B2" forState:UIControlStateNormal];
        [_upButton setTitleColor:[self.titleColor colorWithAlphaComponent:0.5]
                        forState:UIControlStateNormal];
        [_upButton setTitleColor:self.tintColor ? self.tintColor : [KxColorPalleteSystem infoBlueColor]
                        forState:UIControlStateHighlighted];
        [_upButton addTarget:self
                      action:@selector(actionUpButton:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_upButton];
    }
    return _upButton;
}

- (void) setupButtons
{
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[KxPathwayItemHelperView class]]) {
            [v removeFromSuperview];
        }
    }
    
    if (_items.count) {
        
        UIColor *tintColor = self.tintColor ? self.tintColor : [KxColorPalleteSystem infoBlueColor];
        
        NSUInteger index = 0;
        
        for (KxPathwayItem *item in _items) {
            
            KxPathwayItemHelperView *v;
            
            UIImage *dividerImage;
            if (index < _items.count - 1) {
                dividerImage = self.dividerImage;
            }
            
            v = [[KxPathwayItemHelperView alloc] initWithItem:item
                                                 dividerImage:dividerImage
                                                    titleFont:self.titleFont
                                                   titleColor:self.titleColor
                                                    tintColor:tintColor];
            
            v.autoresizingMask = UIViewAutoresizingNone;
            
            v.button.tag = index;
            
            [v.button addTarget:self
                         action:@selector(actionTouchButton:)
               forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:v];
            
            ++index;
        }
        
        if (_items.count > 1) {
            self.upButton.hidden = NO;
        } else if (_upButton) {
            _upButton.hidden = YES;
        }
    }
}

- (CGSize) sizeThatFits:(CGSize)size
{
    if (!size.width)  size.width = HUGE_VALF;
    if (!size.height) size.height = HUGE_VALF;
    
    CGFloat W = 0;
    CGFloat H = 0;
    
    for (UIView *v in self.subviews) {
        
        [v sizeToFit];
        const CGSize vSize = v.frame.size;
        W += vSize.width;
        H = MAX(H, vSize.height);
    }
    
    W += _edgeInsets.left + _edgeInsets.top;
    H += _edgeInsets.top + _edgeInsets.bottom;
    
    if (_upButton && !_upButton.hidden) {
        [_upButton sizeToFit];
        W += _upButton.frame.size.width;
    }
    
    return (CGSize){ MIN(size.width, W), MIN(size.height, H) };
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if (_upButton && !_upButton.hidden) {
        [_upButton sizeToFit];
    }
    
    const CGSize size = self.bounds.size;
    const CGFloat wUpButton = ((_upButton && !_upButton.hidden) ? _upButton.frame.size.width : 0);
    const CGFloat wSize = size.width - _edgeInsets.left - _edgeInsets.right - wUpButton;
    const CGFloat hSize = size.height - _edgeInsets.top - _edgeInsets.bottom;
    
    CGFloat W = 0;
    NSMutableArray *itemsViews = [NSMutableArray arrayWithCapacity:self.subviews.count];
    
    for (UIView *v in self.subviews) {
        
        if ([v isKindOfClass:[KxPathwayItemHelperView class]]) {
            
            [v sizeToFit];
            W += v.frame.size.width;
            v.hidden = NO;
            [itemsViews addObject:v];
        }
    }
    
    if (W > wSize &&
        itemsViews.count > 1) {
        
        // hide intermediate items
        
        UIView *first = itemsViews.firstObject;
        UIView *last = itemsViews.lastObject;
        
        const CGFloat wFirst = first.frame.size.width;
        const CGFloat wLast = last.frame.size.width;
        
        if (wFirst + wLast > wSize) {
            
            for (NSUInteger i = 1; i < itemsViews.count - 1; ++i ) {
                UIView *v = itemsViews[i];
                v.hidden = YES;
            }
            
            if (wFirst > wSize) {
                
                const CGFloat wAve = roundf(W / 2.0f);
                first.frame = (CGRect){ 0, 0, wAve, 0 };
                last.frame = (CGRect){ 0, 0, wAve, 0 };
                
            } else {
                
                last.frame = (CGRect){ 0, 0, wSize - wFirst, 0 };
            }
            
        } else if (itemsViews.count > 2) {
            
            W = wSize - wFirst - wLast;
            
            NSUInteger k = itemsViews.count - 2;
            
            for (; k >= 1; --k ) {
                
                UIView *v = itemsViews[k];
                const CGFloat w = v.frame.size.width;
                if (w > W) {
                    break;
                }
                W -= w;
            }
            
            for (NSUInteger i = 1; i <= k; ++i) {
                UIView *v = itemsViews[i];
                v.hidden = YES;
            }
        }
    }
    
    CGFloat X = _edgeInsets.left;
    
    for (UIView *v in itemsViews) {
        
        if (!v.hidden) {
                
            CGFloat W = roundf(v.frame.size.width);
            W = MIN(W, wSize - X);
            v.frame = (CGRect){X, _edgeInsets.top, W, hSize };
            X += W;
        }
    }
    
    if (_upButton && !_upButton.hidden) {
        
        _upButton.frame = (CGRect) {
            size.width - wUpButton - _edgeInsets.right,
            _edgeInsets.top,
            wUpButton,
            hSize,
        };
    }
}

- (void) actionTouchButton:(UIButton *)sender
{
    __strong id<KxPathwayViewDelegate> delegate = _delegate;
    if (delegate) {
        [delegate pathwayView:self didSelectIndex:sender.tag];
    }
}

- (void) actionUpButton:(UIButton *)sender
{
    __strong id<KxPathwayViewDelegate> delegate = _delegate;
    if (delegate) {
        [delegate pathwayView:self didSelectIndex:self.items.count - 2];
    }
}

- (void) addItem:(KxPathwayItem *)item
{
    self.items = self.items ? [self.items arrayByAddingObject:item] : @[item];
}

+ (UIImage *) dividerImageWithSize:(CGSize) size
                             color:(UIColor *)color
{
    const CGFloat W = size.width;
    const CGFloat H = size.height;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, (CGRect){0,0,size});
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, W - 1.f, roundf(H * 0.5f));
    CGContextAddLineToPoint(context, 0, H);
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextStrokePath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
