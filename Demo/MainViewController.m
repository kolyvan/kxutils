//
//  MainViewController.m
//  kxutils
//
//  Created by Kolyvan on 02.12.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import "MainViewController.h"
#import "TestColorsViewController.h"
#import "TestImagesViewController.h"
#import "TestViewsController.h"
#import "KxUtils.h"

enum {
    
    MainTestRowColors,
    MainTestRowImages,
    MainTestRowViews,
    MainTestRowCount,
};

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>
@property (readonly, nonatomic, strong) UITableView *tableView;
@end

@implementation MainViewController

- (id) init
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"Demo";
    }
    return self;
}

- (void) loadView
{
    const CGRect frame = [[UIScreen mainScreen] bounds];
    
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.opaque = YES;
    
    _tableView = [[UITableView alloc] initWithFrame:frame
                                              style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MainTestRowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView mkCell:@"Cell"
                                    withStyle:UITableViewCellStyleDefault
                                        block:nil];
    
    if (indexPath.row == MainTestRowColors) {
        cell.textLabel.text = @"Colors";
    } else if (indexPath.row == MainTestRowImages) {
        cell.textLabel.text = @"Images";
    } else if (indexPath.row == MainTestRowViews) {
        cell.textLabel.text = @"Views";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == MainTestRowColors) {

        TestColorsViewController *vc = [TestColorsViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == MainTestRowImages) {
        
        TestImagesViewController *vc = [TestImagesViewController new];
        [self.navigationController pushViewController:vc animated:YES];

    } else if (indexPath.row == MainTestRowViews) {
        
        TestViewsController *vc = [TestViewsController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
