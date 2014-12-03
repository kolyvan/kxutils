//
//  ImagesDetailViewController.m
//  kxutils
//
//  Created by Kolyvan on 01.12.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import "ImagesDetailViewController.h"
#import "KxUtils.h"

@interface ImagesDetailViewController ()

@end

@implementation ImagesDetailViewController {
    
    UIScrollView    *_scrollView;
    BOOL            _needReload;
}

- (void) setImages:(NSArray *)images
{
    if (![_images isEqualToArray:images]) {
        
        _images = images;
        _needReload = YES;
    }
}

- (id) init
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"Detail";
    }
    return self;
}

- (void) loadView
{
    const CGRect frame = [[UIScreen mainScreen] bounds];
    
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.opaque = YES;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];    
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_scrollView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_needReload) {
        _needReload = NO;
        [self setupImages];
    }
}

- (void) setupImages
{
    for (UIView *v in _scrollView.subviews) {
        [v removeFromSuperview];
    }
 
    CGFloat Y = 10.f;
    for (UIImage *image in _images) {
        
        UIImageView *v = [[UIImageView alloc] initWithImage:image];
        v.contentMode = UIViewContentModeCenter;
        //v.layer.borderColor = [UIColor grayColor].CGColor;
        //v.layer.borderWidth = 1.0f;
        v.frame = (CGRect){10.f, Y, image.size};
        
        [_scrollView addSubview:v];
        
        Y += image.size.height + 10.f;
    }
    
    _scrollView.contentSize = (CGSize){0, Y};
}

@end
