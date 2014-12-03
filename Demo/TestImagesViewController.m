//
//  TestImagesViewController.m
//  kxutils
//
//  Created by Kolyvan on 01.12.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import "TestImagesViewController.h"
#import "ImagesDetailViewController.h"
#import "KxUtils.h"

enum {
    
    ImagesSectionNamed,
    ImagesSectionGenerated,
    ImagesSectionCIFilter,
    ImagesSectionCount,
};

enum {
    
    ImagesSectionCIFilterSharpen,
    ImagesSectionCIFilterMono,
    ImagesSectionCIFilterCount,
};

@interface TestImagesViewController () <UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>
@property (readonly, nonatomic, strong) UITableView *tableView;
@end

@implementation TestImagesViewController {
    
    NSArray                     *_images;
    ImagesDetailViewController  *_detailViewController;
    CIContext                   *_ciContext;
}

- (id) init
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"Images";
        
        NSString *folder = [KxFilePath pathForResource:@"images"];
        _images = [[NSFileManager defaultManager] filesAtPath:folder];
        
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

#if 0
    [_tableView setTableHeaderText:@"The header"
                         textColor:[KxColorPalleteSeven whiteColor]
                         backColor:[KxColorPalleteSeven grayColor]];
    
    [_tableView setTableFooterText:@"The footer\nAnd even more lines"
                         textColor:[KxColorPalleteSeven whiteColor]
                         backColor:[KxColorPalleteSeven grayColor]];
#endif    
    
}

#pragma mark - private

- (UIImage *) loadImage:(NSUInteger) index
{
    NSString *imageName = _images[index];
    NSString *folder = [KxFilePath pathForResource:@"images"];
    NSString *imagePath = [folder stringByAppendingPathComponent:imageName];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    return [[UIImage alloc] initWithData:data scale:[UIScreen mainScreen].realScale];
}

+ (NSArray *) setupImages:(UIImage *)image
{
    UIImage *dup = [image duplicate];
    
    UIImage *res1 = [image resizedWithFactor:0.5f];
    
    UIImage *res2 = [image resizedWithSize:(CGSize){128, 128}
                                aspectFill:NO
                                 backColor:[UIColor blackColor]
                                   quality:kCGInterpolationDefault
                                     scale:image.scale];
    
    UIImage *res3 = [image resizedWithSize:(CGSize){128, 128}
                                aspectFill:YES
                                 backColor:nil
                                   quality:kCGInterpolationDefault
                                     scale:image.scale];
    
    return @[ dup, res1, res2, res3,  ];
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ImagesSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == ImagesSectionNamed) {
        return _images.count;
    } else if (section == ImagesSectionGenerated) {
        return 1;
    } else if (section == ImagesSectionCIFilter) {
        return ImagesSectionCIFilterCount;
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView mkCell:@"Cell"
                                    withStyle:UITableViewCellStyleDefault
                                        block:nil];
    
    if (indexPath.section == ImagesSectionNamed) {
        cell.textLabel.text = _images[indexPath.row];
    } else if (indexPath.section == ImagesSectionGenerated) {
        cell.textLabel.text = @"Generated";
    } else if (indexPath.section == ImagesSectionCIFilter) {
        if (indexPath.row == ImagesSectionCIFilterSharpen) {
            cell.textLabel.text = @"Sharpen Filter";
        } else if (indexPath.row == ImagesSectionCIFilterMono) {
            cell.textLabel.text = @"Mono Filter";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *images;
    
    if (indexPath.section == ImagesSectionNamed) {
        
        images = [self.class setupImages:[self loadImage:indexPath.row] ];
        
    } else if (indexPath.section == ImagesSectionGenerated) {
        
        images = @[
                   
                   [UIImage imageRectFillColor:[KxColorPalleteSeven lightBlueColor]
                                   strokeColor:[KxColorPalleteSeven deepRedColor]
                                          size:(CGSize){128, 128}],
                   
                   [UIImage imageCircleFillColor:[KxColorPalleteSeven lightBlueColor]
                                     strokeColor:nil
                                            size:(CGSize){128, 128}],
                   
                   [UIImage imageGradientWithColors:@[
                                                      [KxColorPalleteSeven lightBlueColor],
                                                      [KxColorPalleteSeven deepRedColor],
                                                      ]
                                            size:(CGSize){128, 128}],
                   
                   [UIImage roundedImageFillColor:nil
                                      strokeColor:[KxColorPalleteSeven deepRedColor]
                                             size:(CGSize){128, 128}
                                           radius:12.f],
                   
                   
                   
                   ];
        
    } else if (indexPath.section == ImagesSectionCIFilter) {
        
        UIImage *image = [self loadImage:0];
        
        if (!_ciContext) {
             _ciContext = [CIContext contextWithOptions:nil];
        }
        
        CIFilter *filter;
        
        if (indexPath.row == ImagesSectionCIFilterSharpen) {
            filter = [CIFilter filterWithName:@"CISharpenLuminance"];
        } else if (indexPath.row == ImagesSectionCIFilterMono) {
            filter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
        }
        
        if (filter) {
        
            [filter setDefaults];
            UIImage *filtered = [image applyCIFilters:@[ filter, ] contex:_ciContext];
            images = @[ image, filtered ];
        }
    }
    
    
    if (!_detailViewController) {
        _detailViewController = [ImagesDetailViewController new];
    }
    
    _detailViewController.images = images;
    
    [self.navigationController pushViewController:_detailViewController animated:YES];
}


@end
