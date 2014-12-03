//
//  KxPathwayView.h
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

#import <UIKit/UIKit.h>

@protocol KxPathwayViewDelegate;

@interface KxPathwayItem : NSObject
@property (readonly, nonatomic, strong) NSString *title;
@property (readonly, nonatomic, strong) UIImage *image;
- (instancetype) initWithTitle:(NSString *)title image:(UIImage *)image;
+ (instancetype) pathwayItemWithTitle:(NSString *)title;
+ (instancetype) pathwayItemWithTitle:(NSString *)title image:(UIImage *)image;
@end

@interface KxPathwayView : UIView
@property (readwrite, nonatomic, weak) id<KxPathwayViewDelegate> delegate;
@property (readwrite, nonatomic, strong) NSArray *items;
@property (readwrite, nonatomic, strong) UIImage *dividerImage;
@property (readwrite, nonatomic, strong) UIColor *titleColor;
@property (readwrite, nonatomic, strong) UIFont *titleFont;
@property (readwrite, nonatomic, strong) UIButton *upButton;
@property (readwrite, nonatomic) UIEdgeInsets edgeInsets;

- (void) addItem:(KxPathwayItem *)item;

@end

@protocol KxPathwayViewDelegate <NSObject>
- (void) pathwayView:(KxPathwayView *)view didSelectIndex:(NSUInteger)index;
@end
