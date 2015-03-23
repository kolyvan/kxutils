//
//  UIApplication+KxUtils.m
//  kxutils
//
//  Created by Kolyvan on 23.03.15.
//  Copyright (c) 2015 Kolyvan. All rights reserved.
//

#import "UIApplication+KxUtils.h"

@implementation UIApplication(KxUtils)

+ (BOOL) interfaceOrientationIsLandscape
{
    return UIInterfaceOrientationIsLandscape([self.sharedApplication statusBarOrientation]);
}

@end
