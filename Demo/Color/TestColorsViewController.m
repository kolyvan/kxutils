//
//  TestColorsViewController.m
//  kxutils
//
//  Created by Kolyvan on 28.11.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import "TestColorsViewController.h"
#import "KxColorPalleteViewController.h"
#import "KxColorPalleteFlat.h"
#import "KxColorPalleteX11.h"
#import "KxColorPalleteHTML.h"
#import "KxColorPalleteCool.h"
#import "KxColorPalleteFlatAlt.h"
#import "KxColorPalleteMaterial.h"
#import "KxUtils.h"

enum {
    
    ColorsSectionColor,
    ColorsSectionPalletes,
    ColorsSectionSchemes,
    ColorsSectionCount,
};

enum {

    ColorsSectionSchemesAnalogous,
    ColorsSectionSchemesMonochromatic,
    ColorsSectionSchemesTriad,
    ColorsSectionSchemesTetrad,
    ColorsSectionSchemesComplementary,
    ColorsSectionSchemesCount,
};


@interface TestColorsViewController () <UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>
@property (readonly, nonatomic, strong) UITableView *tableView;
@end

@implementation TestColorsViewController {
    
    UIColor                         *_color;
    NSArray                         *_palletes;
    KxColorPalleteViewController    *_palleteViewController;
    UIPopoverController             *_popoverController;
}

- (id) init
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        
        _palletes = @[
                      [KxColorPalleteSystem new],
                      [KxColorPalleteSeven new],
                      [KxColorPalleteFlat new],
                      [KxColorPalleteX11 new],
                      [KxColorPalleteHTML new],
                      [KxColorPalleteCool new],
                      [KxColorPalleteFlatAlt new],
                      [KxColorPalleteMaterial new],
                      ];
        
        
        self.title = @"Colors";
        
        _color = [UIColor redColor];
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

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_popoverController) {
        _popoverController.delegate = nil;
        _popoverController = nil;
    }
}

- (void) didSelectColor:(UIColor *)color
{
    _color = color;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (_popoverController) {
        _popoverController.delegate = nil;
        _popoverController = nil;
    }
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ColorsSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == ColorsSectionColor) {
        return 1;
    } else if (section == ColorsSectionPalletes) {
        return _palletes.count;
    } else if (section == ColorsSectionSchemes) {
        return ColorsSectionSchemesCount;
    }
    
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.section == ColorsSectionColor) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"#%x", (unsigned)(0xffffff & _color.argbValue)];
        
        UIView *v = [[UIView alloc] initWithFrame:(CGRect){0,0,32,32}];
        v.backgroundColor = _color;
        cell.accessoryView = v;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else {
     
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryView = nil;
        
        if (indexPath.section == ColorsSectionPalletes) {
            
            KxColorPallete *pallete = _palletes[indexPath.row];
            cell.textLabel.text = [pallete.class palleteName];
            
        } else if (indexPath.section == ColorsSectionSchemes) {
            
            if (indexPath.row == ColorsSectionSchemesAnalogous) {
                cell.textLabel.text = @"Analogous";
            } else if (indexPath.row == ColorsSectionSchemesMonochromatic) {
                cell.textLabel.text = @"Monochromatic";
            } else if (indexPath.row == ColorsSectionSchemesTriad) {
                cell.textLabel.text = @"Triad";
            } else if (indexPath.row == ColorsSectionSchemesTetrad) {
                cell.textLabel.text = @"Tetrad";
            } else if (indexPath.row == ColorsSectionSchemesComplementary) {
                cell.textLabel.text = @"Complementary";
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == ColorsSectionColor) {
        return;
    }
    
    if (!_palleteViewController) {
        _palleteViewController = [KxColorPalleteViewController new];
        
        __weak __typeof(self) weakSelf = self;
        _palleteViewController.didSelectBlock = ^(UIColor *color) {
            [weakSelf didSelectColor:color];
        };
    }
    
    NSArray *colors, *colorNames;
    NSString *title;
        
    if (indexPath.section == ColorsSectionPalletes) {
        
        KxColorPallete *pallete = _palletes[indexPath.row];
        colors = pallete.colors;
        colorNames = pallete.colorNames;
        title = [pallete.class palleteName];
        
    } else if (indexPath.section == ColorsSectionSchemes) {
        
        if (indexPath.row == ColorsSectionSchemesAnalogous) {
            colors = [_color analogousColors];
            title = @"Analogous";
        } else if (indexPath.row == ColorsSectionSchemesMonochromatic) {
            colors = [_color monochromaticColors];
            title = @"Monochromatic";
        } else if (indexPath.row == ColorsSectionSchemesTriad) {
            colors = [_color triadColors];
            title = @"Triad";
        } else if (indexPath.row == ColorsSectionSchemesTetrad) {
            colors = [_color tetradColors];
            title = @"Tetrad";
        } else if (indexPath.row == ColorsSectionSchemesComplementary) {
            colors = [_color complementaryColors];
            title = @"Complementary";
        }
    }
    
    _palleteViewController.selectedColor = _color;
    _palleteViewController.colors = colors;
    _palleteViewController.colorNames = colorNames;
    _palleteViewController.title = title;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        [self.navigationController pushViewController:_palleteViewController animated:YES];
        
    } else {

        if (!_popoverController) {
            _popoverController = [[UIPopoverController alloc] initWithContentViewController:_palleteViewController];
            _popoverController.delegate = self;
        }
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        const CGRect rect = [self.view convertRect:cell.bounds fromView:cell];
        
        [_popoverController presentPopoverFromRect:rect
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:YES];
        
    }
    
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    _popoverController.delegate = nil;
    _popoverController = nil;
}

@end
