//
//  FontIconViewer.h
//  lab
//
//  Created by Kolyvan on 08.04.15.
//  Copyright (c) 2015 Kolyvan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KxFontIcon;

@interface FontIconViewer : UIViewController
@property (readwrite, nonatomic, strong) NSDictionary *glyphs;
@property (readwrite, nonatomic, strong) NSString *fontPath;
@end
