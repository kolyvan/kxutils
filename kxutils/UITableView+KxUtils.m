//
//  UITableView+KxUtils.m
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

#import "UITableView+KxUtils.h"

@implementation UITableView (KxUtils)

- (UITableViewCell *) mkCell:(NSString *) identifier
                   withStyle:(UITableViewCellStyle)style
                       block:(void(^)(UITableViewCell *cell))block
{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:style
                                      reuseIdentifier:identifier];
        
        if (block) {
            block(cell);
        }
    }
    return cell;
}

- (UILabel *) setTableHeaderText:(NSString *)text
{
    return [self setTableHeaderText:text font:nil textColor:[UIColor darkTextColor] backColor:nil];
}

- (UILabel *) setTableHeaderText:(NSString *)text
                       textColor:(UIColor *)textColor
                       backColor:(UIColor *)backColor
{
    return [self setTableHeaderText:text font:nil textColor:textColor backColor:backColor];
}

- (UILabel *) setTableHeaderText:(NSString *)text
                            font:(UIFont *)font
                       textColor:(UIColor *)textColor
                       backColor:(UIColor *)backColor
{
    if (text.length) {

        if (!font) {
            font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        }

        const CGSize size = self.bounds.size;
        const CGFloat yMargin = 10.f;
        const CGFloat xMargin = 20.f;
        const CGFloat W = size.width - xMargin * 2.f;

        const CGFloat H = [text boundingRectWithSize:(CGSize){W, 9999}
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{ NSFontAttributeName : font, }
                                             context:nil].size.height;

        const CGRect footerRect = (CGRect){0, 0, size.width, H + yMargin * 2.0f};
        const CGRect labelRect = (CGRect){xMargin, yMargin, W, H};

        UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
        label.text = text;
        label.font = font;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = textColor;
        label.numberOfLines = 0;

        self.tableHeaderView = [[UIView alloc] initWithFrame:footerRect];
        self.tableHeaderView.backgroundColor = backColor;
        [self.tableHeaderView addSubview:label];

        return label;

    } else {

        self.tableHeaderView = nil;
        return nil;
    }
}

- (UILabel *) setTableFooterText:(NSString *)text
{
    return [self setTableFooterText:text textColor:[UIColor darkTextColor] backColor:nil];
}

- (UILabel *) setTableFooterText:(NSString *)text
                       textColor:(UIColor *)textColor
                       backColor:(UIColor *)backColor
{
    if (text.length) {
        
        UIFontDescriptor *fd = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleFootnote];
        UIFont *font = [UIFont fontWithDescriptor:fd size:0];
        
        const CGSize size = self.bounds.size;
        const CGFloat yMargin = 10.f;
        const CGFloat xMargin = 20.f;
        const CGFloat W = size.width - xMargin * 2.f;
        
        const CGFloat H = [text boundingRectWithSize:(CGSize){W, 9999}
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{ NSFontAttributeName : font, }
                                             context:nil].size.height;
        
        const CGRect footerRect = (CGRect){0, 0, size.width, H + yMargin * 2.0f};
        const CGRect labelRect = (CGRect){xMargin, yMargin, W, H};
        
        UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
        label.text = text;
        label.font = font;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = textColor;
        label.numberOfLines = 0;
        
        self.tableFooterView = [[UIView alloc] initWithFrame:footerRect];
        self.tableFooterView.backgroundColor = backColor;
        [self.tableFooterView addSubview:label];

        return label;
        
    } else {
        
        self.tableFooterView = nil;
        return nil;
    }
}

- (NSIndexPath *) indexPathFromCellSubview:(UIView *)v
{
    while (v.superview) {
        if ([v.superview isKindOfClass:[UITableViewCell class]]) {
            return [self indexPathForCell:(UITableViewCell *)v.superview];
        }
        v = v.superview;
    }
    return nil;
}

+ (BOOL) isSupportedRowAction
{
    return floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1 &&
    nil != [UITableViewRowAction class];
}

@end
