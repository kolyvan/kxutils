//
//  KxAlert.m
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

#import "KxAlert.h"
#import "KxColorPallete.h"

////////////////////////////////////////////////////////////////////////////////

@interface KxAlertContentView : UIView
@property (readonly, nonatomic, strong) NSString *title;
@property (readonly, nonatomic, strong) NSString *message;
@property (readonly, nonatomic, strong) UIColor *titleColor;
@property (readonly, nonatomic, strong) UIColor *messageColor;
@end

@implementation KxAlertContentView {
    
    UIFont  *_titleFont;
    UIFont  *_messageFont;
    BOOL    _hasAction;
}

+ (UIFont *) titleFont
{
    UIFontDescriptor *fd = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline];
    return [UIFont fontWithDescriptor:fd size:0];
}

+ (UIFont *) messageFont
{
    UIFontDescriptor *fd = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleSubheadline];
    return [UIFont fontWithDescriptor:fd size:0];
}

- (instancetype) initWithFrame:(CGRect)frame
                         title:(NSString *)title
                       message:(NSString *)message
                    titleColor:(UIColor *)titleColor
                  messageColor:(UIColor *)messageColor
                     hasAction:(BOOL)hasAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _title = title;
        _message = message;
        _titleColor = titleColor;
        _messageColor = messageColor;
        _titleFont = [self.class titleFont];
        _messageFont = [self.class messageFont];
        _hasAction = hasAction;
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    const CGSize mySize = self.bounds.size;
    
    const BOOL isWide = mySize.width > 400.f;
    const CGFloat xMargin = isWide ? 20.f : 10.f;
    const CGFloat yMargin = 25.f;
    
    CGFloat X = xMargin;
    CGFloat Y = yMargin;
    const CGFloat W = mySize.width - xMargin * 2.0f;
    
    NSMutableParagraphStyle *para = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    para.alignment = NSTextAlignmentCenter;
    
    NSDictionary *titleAttr = @{
                                NSFontAttributeName : _titleFont,
                                NSForegroundColorAttributeName : _titleColor,
                                NSParagraphStyleAttributeName : para,
                                };
    
    NSDictionary *messageAttr = @{
                                  NSFontAttributeName : _messageFont,
                                  NSForegroundColorAttributeName : _messageColor,
                                  NSParagraphStyleAttributeName : para,
                                  };
    
    const CGFloat H = [_title boundingRectWithSize:(CGSize){W, mySize.height - Y}
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:titleAttr
                                           context:nil].size.height;
    
    [_title drawWithRect:(CGRect){X, Y, W, mySize.height - Y}
                 options:NSStringDrawingUsesLineFragmentOrigin
              attributes:titleAttr
                 context:nil];
    
    Y += H + 5.f;
    
    [_message drawWithRect:(CGRect){X, Y, W, mySize.height - Y}
                   options:NSStringDrawingUsesLineFragmentOrigin
                attributes:messageAttr
                   context:nil];
    
    if (_hasAction) {
        
        const CGFloat H = mySize.height;
        const CGFloat x0 = mySize.width - 8.0f;
        const CGFloat xM = mySize.width - 5.0f;
        const CGFloat yM = yMargin + roundf((H - yMargin) * 0.5f);
        const CGFloat dY = MIN(5.f, yM);
        const CGFloat y0 = roundf(yM - dY);
        const CGFloat y1 = roundf(yM + dY);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(context, x0, y0);
        CGContextAddLineToPoint(context, xM, yM);
        CGContextAddLineToPoint(context, x0, y1);
        
        UIColor *color = [_messageColor colorWithAlphaComponent:0.4f];
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextStrokePath(context);
        
        /*
        const CGFloat H = mySize.height;
        const CGFloat W = mySize.width;
        const CGFloat D = 10.0f;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(context, W, H - D);
        CGContextAddLineToPoint(context, W, H);
        CGContextAddLineToPoint(context, W - D, H);
        CGContextAddLineToPoint(context, W, H - D);

        UIColor *color = [_titleColor colorWithAlphaComponent:0.4f];
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillPath(context);
        */
    }
}

+ (CGFloat)computeHeight:(NSString *)title
                 message:(NSString *)message
                   width:(CGFloat)width
{
    const BOOL isWide = width > 400.f;
    const CGFloat xMargin = isWide ? 20.f : 10.f;
    const CGFloat W = width - xMargin * 2.0f;
    
    CGFloat H = 40.f;
    
    H += [title boundingRectWithSize:(CGSize){W, 1999.f}
                             options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{ NSFontAttributeName : self.class.titleFont }
                             context:nil].size.height;
    
    H += [message boundingRectWithSize:(CGSize){W, 1999.f}
                               options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{ NSFontAttributeName : self.class.messageFont }
                               context:nil].size.height;
    
    H = MAX(44.f, MIN(H, 300.f));
    return H;
}

@end

////////////////////////////////////////////////////////////////////////////////

@interface KxAlertView : UIToolbar
@end

@implementation KxAlertView {
    
    BOOL                            _didObserve;
    NSTimer                         *_closeTimer;
    UITapGestureRecognizer          *_tapGesture;
    UILongPressGestureRecognizer    *_longPressGesture;
    UISwipeGestureRecognizer        *_swipeGesture;
    KxAlertBlock                    _block;
}

- (id) initWithFrame:(CGRect)frame
               title:(NSString *)title
             message:(NSString *)message
          titleColor:(UIColor *)titleColor
        messageColor:(UIColor *)messageColor
               block:(KxAlertBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _block = block;
        
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.barStyle = UIBarStyleBlack;
        
        KxAlertContentView *contentView = [[KxAlertContentView alloc] initWithFrame:self.bounds
                                                                              title:title
                                                                            message:message
                                                                         titleColor:titleColor
                                                                       messageColor:messageColor
                                                                          hasAction:block != nil];
        contentView.opaque = NO;
        contentView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:contentView];
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
            
            self.layer.shadowColor = [UIColor blackColor].CGColor;
            self.layer.shadowOffset = (CGSize){0.f, 2.f};
            self.layer.shadowOpacity = 0.5f;
            self.layer.masksToBounds = NO;
        }
    }
    
    return self;
}

- (void) dealloc
{
    if (_closeTimer) {
        [_closeTimer invalidate];
    }
    
    if (_didObserve) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void) didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if (self.superview) {
        
        [self updateObserver:YES];
        [self setupGestureRecognizers:YES];
        
    } else {
        
        [self updateObserver:NO];
        [self setupGestureRecognizers:NO];
    }
}

- (void) updateObserver:(BOOL)flag
{
    if (flag && !_didObserve) {
        
        _didObserve = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willChangeStatusBarOrientation:)
                                                     name:UIApplicationWillChangeStatusBarOrientationNotification
                                                   object:nil];
    } else if (!flag && _didObserve) {
        
        _didObserve = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void) willChangeStatusBarOrientation:(NSNotification *)n
{
    [self closeAnimated:NO];
}

- (void) didCloseTimer:(id)sender
{
    _closeTimer = nil;
    [self closeAnimated:YES];
}

- (void)closeAnimated:(BOOL)aninmated
{
    [self updateObserver:NO];
    [self setupGestureRecognizers:NO];
    
    if (_closeTimer) {
        [_closeTimer invalidate];
        _closeTimer = nil;
    }
    
    _block = nil;
    
    if (aninmated) {
        
        UIView *v = self;
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        
            const CGSize size = self.bounds.size;
            const CGRect destFrame = { 0, -size.height, size };
            
            [UIView animateWithDuration:0.2f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^
             {
                 v.frame = destFrame;
             }
                             completion:^(BOOL finished)
             {
                 if (finished) {
                     [v removeFromSuperview];
                 }
             }];
            
        } else {
            
            [UIView animateWithDuration:0.2f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^
             {
                 v.alpha = 0;
             }
                             completion:^(BOOL finished)
             {
                 if (finished) {
                     [v removeFromSuperview];
                 }
             }];
        }
        
    } else {
        
        [self removeFromSuperview];
    }
}

- (void) closeDelayed:(CGFloat) delay
{
    if (_closeTimer) {
        [_closeTimer invalidate];
    }
    
    _closeTimer = [NSTimer scheduledTimerWithTimeInterval:delay
                                                   target:self
                                                 selector:@selector(didCloseTimer:)
                                                 userInfo:nil
                                                  repeats:NO];
}

#pragma mark - UIGestureRecognizer

- (void) setupGestureRecognizers:(BOOL)flag
{
    if (flag) {
        
        if (!_tapGesture) {
            
            _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [self addGestureRecognizer:_tapGesture];
        }
        
        if (!_longPressGesture) {
            
            _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
            [self addGestureRecognizer:_longPressGesture];
        }
        
        if (!_swipeGesture) {
            
            _swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
            _swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
            [self addGestureRecognizer:_swipeGesture];
        }
        
    } else {
        
        if (_swipeGesture) {
            [self removeGestureRecognizer:_swipeGesture];
            _swipeGesture = nil;
        }
        
        if (_longPressGesture) {
            [self removeGestureRecognizer:_longPressGesture];
            _longPressGesture = nil;
        }
        
        if (_tapGesture) {
            [self removeGestureRecognizer:_tapGesture];
            _tapGesture = nil;
        }
    }
    
}

- (void) handleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        if (_block) {
            
            _block();
            [self closeAnimated:NO];
            
        } else {
            
            [self closeAnimated:YES];
        }
    }
}

- (void) handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        if (_closeTimer) {
            [_closeTimer invalidate];
            _closeTimer = nil;
        }
        
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        [self closeAnimated:YES];
    }
}

- (void) handleSwipe:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        [self closeAnimated:YES];
    }
}

@end

////////////////////////////////////////////////////////////////////////////////

static KxAlertManager *gAlertManager;

@interface KxAlertManager()
@property (readwrite, nonatomic, weak) KxAlertView *weakAlertView;
@end

@implementation KxAlertManager

+ (instancetype) alertManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gAlertManager = [[KxAlertManager alloc] init];
    });
    return gAlertManager;
}

- (id) init
{
    NSAssert(!gAlertManager, @"singleton object");
    return [super init];
}

- (void)showAlert:(NSError *)error
{
    [self showAlert:nil
            message:nil
              error:error
              block:nil];
}

- (void)showAlert:(NSString *)title
            error:(NSError *)error
{
    [self showAlert:title
            message:nil
              error:error
              block:nil];
}

- (void)showAlert:(NSString *)title
          message:(NSString *)message
            error:(NSError *)error
{
    [self showAlert:title
            message:message
              error:error
              block:nil];
}

- (void)showAlert:(NSString *)title
          message:(NSString *)message
            error:(NSError *)error
            block:(KxAlertBlock)block
{
    NSMutableString *ms = [NSMutableString string];
    
    BOOL emptyTitle = NO;
    if (!title.length) {
        
        emptyTitle = YES;
        
        if (error.localizedDescription.length) {
            title = error.localizedDescription;
        } else {
            title = NSLocalizedString(@"Error", nil);
        }
    }
    
    if (message.length) {
        [ms appendString:message];
    }
    
    if (error) {
        
        if (!emptyTitle &&
            error.localizedDescription.length) {
            
            if (ms.length) {
                [ms appendString:@"\n"];
            }
            [ms appendString: error.localizedDescription];
        }
        
        if (error.localizedFailureReason.length) {
            if (ms.length) {
                [ms appendString:@"\n"];
            }
            [ms appendString: error.localizedFailureReason];
        }
        
        if (error.localizedRecoverySuggestion.length) {
            if (ms.length) {
                [ms appendString:@"\n"];
            }
            [ms appendString: error.localizedRecoverySuggestion];
        }
        
        if (ms.length) {
            [ms appendString:@"\n"];
        }
        
        [ms appendString:@"#"];
        [ms appendString:error.domain];
        [ms appendString:@"/"];
        [ms appendFormat:@"%u", (unsigned)error.code];
    }
    
    [self showAlert:title
            message:[ms copy]
         titleColor:[KxColorPalleteSeven redColor]
       messageColor:[KxColorPalleteSeven whiteColor]
              delay:12.f
              block:block];
}

- (void)showAlert:(NSString *)title
          message:(NSString *)message
{
    [self showAlert:title
            message:message
              delay:4.f
              block:nil];
}

- (void)showAlert:(NSString *)title
          message:(NSString *)message
            block:(KxAlertBlock)block
{
    [self showAlert:title
            message:message
              delay:4.f
              block:block];
}

- (void)showAlert:(NSString *)title
          message:(NSString *)message
            delay:(CGFloat) delay
            block:(KxAlertBlock)block
{
    [self showAlert:title
            message:message
         titleColor:[KxColorPalleteSeven lightBlueColor]
       messageColor:[KxColorPalleteSeven whiteColor]
              delay:delay
              block:block];
}

- (void)showAlert:(NSString *)title
          message:(NSString *)message
       titleColor:(UIColor *)titleColor
     messageColor:(UIColor *)messageColor
            delay:(CGFloat) delay
            block:(KxAlertBlock)block
{
    NSParameterAssert(title);
    
    [self closeAnimated:NO];
    
    UIView *view = [[UIApplication sharedApplication].delegate window];
    const CGSize mainSize = view.bounds.size;
    
    UIInterfaceOrientation orientation;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        orientation = UIInterfaceOrientationPortrait;
    } else {
        orientation = [UIApplication sharedApplication].statusBarOrientation;;
    }
    
    CGRect frame;
    CGPoint dest = {0};
    CGAffineTransform viewTransform;
    
    if (orientation == UIInterfaceOrientationLandscapeRight) {
        
        viewTransform = CGAffineTransformMakeRotation(M_PI_2);
        
        const CGFloat H = [KxAlertContentView computeHeight:title
                                                    message:message
                                                      width:mainSize.height];
        
        frame.size.height = H;
        frame.size.width = mainSize.height;
        frame.origin.x = mainSize.width + H;
        frame.origin.y = 0;
        
        dest.x = (mainSize.width - H);
        
    } else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        
        viewTransform = CGAffineTransformMakeRotation(-M_PI_2);
        
        const CGFloat H = [KxAlertContentView computeHeight:title
                                                    message:message
                                                      width:mainSize.height];
        
        frame.size.height = H;
        frame.size.width = mainSize.height;
        frame.origin.x = -H;
        frame.origin.y = 0;
        
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        viewTransform = CGAffineTransformMakeRotation(M_PI);
        
        const CGFloat H = [KxAlertContentView computeHeight:title
                                                    message:message
                                                      width:mainSize.width];
        
        frame.size.height = H;
        frame.size.width = mainSize.width;
        frame.origin.x = 0;
        frame.origin.y = mainSize.height + H;
        
        dest.y = mainSize.height - H;
        
    } else {
        
        viewTransform = CGAffineTransformIdentity;
        
        const CGFloat H = [KxAlertContentView computeHeight:title
                                                    message:message
                                                      width:mainSize.width];
        
        frame.size.height = H;
        frame.size.width = mainSize.width;
        frame.origin.x = 0;
        frame.origin.y = -H;
    }
    
    KxAlertView *alertView;
    alertView = [[KxAlertView alloc] initWithFrame:(CGRect){0,0,frame.size}
                                             title:title
                                           message:message
                                        titleColor:titleColor
                                      messageColor:messageColor
                                             block:block];
    
    alertView.transform = viewTransform;
    
    CGRect xFrame = alertView.frame;
    xFrame.origin =  frame.origin;
    alertView.frame = xFrame;
    
    [view addSubview:alertView];
    
    self.weakAlertView = alertView;
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
         //usingSpringWithDamping:0.6
         //initialSpringVelocity:4.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         CGRect destFrame = alertView.frame;
         destFrame.origin = dest;
         alertView.frame = destFrame;
     }
                     completion:^ (BOOL finished)
     {
         if (finished) {
             if (delay > 0) {
                 [alertView closeDelayed:delay];
             }
         }
     }];
    
    return;
}

- (void)closeAnimated:(BOOL)animated
{
    KxAlertView *v = self.weakAlertView;
    if (v) {
        [v closeAnimated:animated];
        self.weakAlertView = nil;
    }
}

@end

KxAlertManager *sharedAlertManager()
{
    return [KxAlertManager alertManager];
}