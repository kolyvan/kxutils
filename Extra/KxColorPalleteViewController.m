//
//  KxColorPalleteViewController.m
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 28.11.14.

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

#import "KxColorPalleteViewController.h"
#import "UIColor+KxUtils.h"
#import "KxColorPallete.h"

@interface KxColorPalleteCell : UICollectionViewCell
@property (readwrite, nonatomic, strong) UIColor *color;
@property (readwrite, nonatomic, strong) NSString *name;
@end

@implementation KxColorPalleteCell {
    
    UILabel *_nameLabel;
}

- (id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame: rect];
    if (self) {
    }
    return self;
}

- (void) setColor:(UIColor *)color
{
    if (![_color isEqual:color]) {
    
        _color = color;
        
        if (!self.backgroundView) {
            
            const CGRect bounds = self.bounds;
            
            UIView *vc = [[UIView alloc] initWithFrame:bounds];
            
            vc.opaque = YES;
            
            const CGFloat cornerRadius = bounds.size.width * .5f;
            vc.layer.cornerRadius = cornerRadius;
            
            vc.layer.shadowOpacity = 0.5;
            vc.layer.shadowColor = [UIColor blackColor].CGColor;
            vc.layer.shadowOffset = (CGSize){1, 1};
            vc.layer.shadowRadius = 2.0f;
            
            vc.layer.shouldRasterize = YES;
            vc.layer.rasterizationScale = [UIScreen mainScreen].scale;
            
            self.backgroundView = vc;
        }
        
        self.backgroundView.backgroundColor = color;
        
        [self updateNameColor];
    }
}

- (UILabel *) nameLabel
{
    if (!_nameLabel) {
        
        UIFontDescriptor *fd = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleCaption2];
        
        _nameLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _nameLabel.font = [UIFont fontWithDescriptor:fd size:0];
        _nameLabel.opaque = NO;
        _nameLabel.numberOfLines = 1;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

- (void) setName:(NSString *)name
{
    if (![_name isEqualToString:name]) {
    
        if (name.length) {
            
            self.nameLabel.text = name;
            
        } else if (_nameLabel) {
            
            [_nameLabel removeFromSuperview];
            _nameLabel = nil;
        }
    }
}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateNameColor];
    
}

- (void) updateNameColor
{
    if (self.selected) {
        self.nameLabel.textColor = _color.contrastingColor;
    } else {
        self.nameLabel.textColor = [_color.contrastingColor colorWithAlphaComponent:0.7f];
    }
    
    //self.nameLabel.textColor = _color.reverseColor.monochromeColor;
    //self.nameLabel.textColor = [_color.contrastingColor colorWithAlphaComponent:0.8f];
}

@end


@interface KxColorPalleteViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (readonly, nonatomic, strong) UICollectionView *collView;
@end

@implementation KxColorPalleteViewController {
}

- (id) init
{
    return [self initWithNibName:nil bundle:nil];
}

- (void) loadView
{
    const CGRect frame = [[UIScreen mainScreen] bounds];
    
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = [KxColorPalleteSeven whiteColor];
    self.view.opaque = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collView = [[UICollectionView alloc] initWithFrame:frame
                                                    collectionViewLayout:flowLayout];
    _collView.delegate = self;
    _collView.dataSource = self;
    _collView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [_collView registerClass:[KxColorPalleteCell class]
 forCellWithReuseIdentifier:@"KxColorPalleteCell"];
    
    _collView.backgroundColor = [KxColorPalleteSeven whiteColor];
    
    [self.view addSubview:_collView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_collView reloadData];
    
    if (_selectedColor) {
        
        const NSUInteger index = [_colors indexOfObject:_selectedColor];
        if (index != NSNotFound) {
            
            [_collView selectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                    animated:NO
                              scrollPosition:UICollectionViewScrollPositionNone];
        }
    }
    
    if (self.presentingViewController) {
        
        UIBarButtonItem *bbiDone;
        bbiDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                target:self
                                                                action:@selector(actionDone:)];
        self.navigationItem.rightBarButtonItem = bbiDone;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            const CGFloat H = _colors.count / 4.f * 80.f;
            self.preferredContentSize = (CGSize){ 320, MAX(90.f, MIN(480, H)) };
        }
    }
}

#pragma mark - actions

- (void) actionDone:(id)sender
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    KxColorPalleteCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KxColorPalleteCell"
                                                     forIndexPath:indexPath];
    
    cell.color = _colors[indexPath.row];
    if (_colorNames && indexPath.row < _colorNames.count) {
        cell.name = _colorNames[indexPath.row];
    } else {
        cell.name = nil;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedColor = _colors[indexPath.row];
    if (_didSelectBlock) {
        _didSelectBlock(_selectedColor);
    }
    
    [self actionDone:nil];
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    
    const CGFloat W = collectionView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right;
    const NSUInteger count =  W / 70.f;
    const CGFloat size = W / (CGFloat)count - flowLayout.minimumInteritemSpacing;
    
    return (CGSize){size, size};
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

@end
