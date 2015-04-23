//
//  ViewController.m
//  Demo
//
//  Created by Kolyvan on 27.11.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import "TestViewsController.h"
#import "KxUtils.h"

@interface TestViewsController () <KxPathwayViewDelegate>
@end

@implementation TestViewsController {
    
    KxRoundProgressView *_rpv1;
    KxRoundProgressView *_rpv2;
    KxPathwayView *_pathWay;
    KxSpinView *_spinView;
}

- (id) init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"Views";
    }
    return self;
}

- (void)loadView
{
    const CGRect frame = [[UIScreen mainScreen] bounds];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.opaque = YES;
    
    _pathWay = [[KxPathwayView alloc] initWithFrame:(CGRect){0, 64, frame.size.width, 44.f}];
    _pathWay.delegate = self;
    _pathWay.titleColor = [KxColorPalleteSeven whiteColor];
    _pathWay.backgroundColor = [KxColorPalleteSeven blackColor];
    _pathWay.items = @[
                       [KxPathwayItem pathwayItemWithTitle:@"Home"],
                       [KxPathwayItem pathwayItemWithTitle:@"Page 1"],
                       [KxPathwayItem pathwayItemWithTitle:@"Page 2"],
                       ];
    [self.view addSubview:_pathWay];
    
    UIButton *redButton = [UIButton buttonWithType:UIButtonTypeCustom];
    redButton.frame = (CGRect){ 20, 120, 80, 40};
    redButton.autoresizingMask = UIViewAutoresizingNone;
    //redButton.backgroundColor = [KxColorPalleteSeven deepRedColor];
    [redButton addGradientLayerWithColor:[KxColorPalleteSeven deepRedColor]];
    [redButton setTitle:@"Red" forState:UIControlStateNormal];
    [redButton setTitleColor:[KxColorPalleteSeven whiteColor] forState:UIControlStateNormal];
    [redButton addTarget:self action:@selector(actionRed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:redButton];
    
    UIButton *blueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blueButton.frame = (CGRect){ 110, 120, 80, 40};
    blueButton.autoresizingMask = UIViewAutoresizingNone;
    //blueButton.backgroundColor = [KxColorPalleteSeven lightBlueColor];
    [blueButton addGradientLayerWithColor:[KxColorPalleteSeven lightBlueColor]];
    [blueButton setTitle:@"Blue" forState:UIControlStateNormal];
    [blueButton setTitleColor:[KxColorPalleteSeven whiteColor] forState:UIControlStateNormal];
    [blueButton addTarget:self action:@selector(actionBlue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blueButton];
    
    UIButton *pageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pageButton.frame = (CGRect){ 200, 120, 80, 40};
    pageButton.autoresizingMask = UIViewAutoresizingNone;
    [pageButton addGradientLayerWithColor:[KxColorPalleteSeven yellowColor]];
    [pageButton setTitle:@"Add" forState:UIControlStateNormal];
    [pageButton setTitleColor:[KxColorPalleteSeven blackColor] forState:UIControlStateNormal];
    [pageButton addTarget:self action:@selector(actionAddPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pageButton];
    
    
    KxCheckmarkView *check1 = [[KxCheckmarkView alloc] initWithFrame:(CGRect){20, 200, 24, 24}];
    [self.view addSubview:check1];
    
    KxCheckmarkView *check2 = [[KxCheckmarkView alloc] initWithFrame:(CGRect){80, 200, 42, 42}];
    check2.foreColor = [KxColorPalleteSeven violetColor];
    check2.tintColor = [KxColorPalleteSeven lightPinkColor];
    [self.view addSubview:check2];
    
    
    _rpv1 = [[KxRoundProgressView alloc] initWithFrame:(CGRect){20, 250, 24, 24}];
    _rpv1.progress = 1.0f;
    [self.view addSubview:_rpv1];
    
    _rpv2 = [[KxRoundProgressView alloc] initWithFrame:(CGRect){80, 250, 42, 42}];
    _rpv2.progress = 0.25f;
    _rpv2.tintColor = [KxColorPalleteSeven lightGreenColor];
    [self.view addSubview:_rpv2];
    
    KxRatingView *ratingView = [[KxRatingView alloc] initWithFrame:(CGRect){20, 300, 0, 0}];
    ratingView.value = 3.5f;
    ratingView.title = @"Rating";
    [ratingView sizeToFit];
    ratingView.userInteractionEnabled = YES;
    [ratingView addTarget:self
                   action:@selector(ratingViewDidChange:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:ratingView];
    
    
    UIBezierPath *bPath = [UIBezierPath bezierPathWithLetter:0x2600
                                                    fontName:nil
                                                    fontSize:32];
    
    UIImage *spinImage = [UIImage imageWithBezierPath:bPath
                                            fillColor:[KxColorPalleteSeven deepRedColor]
                                          strokeColor:[KxColorPalleteSeven orangeColor]];
    
    _spinView = [[KxSpinView alloc] initWithFrame:(CGRect){200, 300, spinImage.size}
                                        spinImage:spinImage];
    
    //_spinView.hidesWhenStopped = YES;
    [self.view addSubview:_spinView];
    
    [_spinView startAnimating];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapSpin:)];
    [_spinView addGestureRecognizer:tap];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    BOOL found = NO;
    
    for (CALayer *layer in self.view.layer.sublayers) {
        if (KIND_OF(layer, CAGradientLayer)) {
            
            layer.frame = self.view.bounds;
            found = YES;
            break;
        }
    }
    
    if (!found) {
        UIColor *color = [KxColorPalleteSeven lightGreenColor];
        NSArray *colors = [color monochromaticColors];
        [self.view addGradientLayerWithColors:colors];
    }
}

- (void) actionRed:(id)sender
{
    NSError *error = mkError(42,
                             @"com.kolyvan.demo",
                             @"Unexpected Failure",
                             @"Something is rotten in the state of Denmark");
    
    [sharedAlertManager() showAlert:error];
}

- (void) actionBlue:(id)sender
{
    __weak typeof(self) weakSelf = self;
    
    [sharedAlertManager() showAlert:@"Operation completed"
                            message:@"Tap for see the results of operation"
                              block:^
    {
        [weakSelf startProgress];
    }];
}

- (void) actionAddPage:(id)sender
{
    const NSUInteger index = _pathWay.items.count;
    NSString *title = [NSString stringWithFormat:@"Page %u", (unsigned)index];
    [_pathWay addItem:[KxPathwayItem pathwayItemWithTitle:title]];
}

- (void) startProgress
{
    _rpv1.progress = 0;
    _rpv2.progress = 0;
    
    [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self
                                   selector:@selector(tickTimer:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) tickTimer:(NSTimer *)timer
{
    _rpv1.progress += 0.05f;
    _rpv2.progress += 0.05f;
    
    if (_rpv1.progress >= 1.f) {
        [timer invalidate];
    }
}

- (void) tapSpin:(UIGestureRecognizer *)gr
{
    if (_spinView.isAnimating) {
        [_spinView stopAnimating];
    } else {
        [_spinView startAnimating];
    }
}

#pragma mark - KxPathwayViewDelegate

- (void) pathwayView:(KxPathwayView *)view didSelectIndex:(NSUInteger)index
{
    if (index < view.items.count - 1) {
        view.items = [view.items subarrayWithRange:NSMakeRange(0, index + 1)];
    }
}

#pragma mark - rating view

- (void) ratingViewDidChange:(KxRatingView *)sender
{
    NSLog(@"rating did change: %.1f", sender.value);
}

@end

