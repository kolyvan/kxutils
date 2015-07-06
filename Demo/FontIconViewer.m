//
//  FontIconViewer.m
//  lab
//
//  Created by Kolyvan on 08.04.15.
//  Copyright (c) 2015 Kolyvan. All rights reserved.
//

#import "FontIconViewer.h"
#import "KxUtils.h"
#import "KxFontIcon.h"
#import "FontAwesomeGlyphs.h"

@interface FontIconViewerCell : UICollectionViewCell
@property (readwrite, nonatomic, strong) UILabel *titleLabel;
@property (readwrite, nonatomic, strong) UIImageView *imageView;
@end

@implementation FontIconViewerCell {
    
}

- (id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame: rect];
    if (self) {
        
        const CGFloat W = rect.size.width;
        const CGFloat H = rect.size.height;
        const CGFloat hLabel = 20.f;
        
        _imageView = [[UIImageView alloc] initWithFrame:(CGRect){0, 0, W, H - hLabel}];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeCenter;
        
        _titleLabel = [[UILabel alloc] initWithFrame:(CGRect){0, H - hLabel, W, hLabel}];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.opaque = NO;
        _titleLabel.numberOfLines = 1;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}
@end

@interface FontIconViewer() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (readonly, nonatomic, strong) UICollectionView *collView;
@end

@implementation FontIconViewer {

    NSArray         *_names;
    KxFontIconCache *_fontCache;
}

- (id) init
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
    }
    return self;
}

- (void) loadView
{
    const CGRect frame = [[UIScreen mainScreen] bounds];
    self.view = ({
        UIView *v = [[UIView alloc] initWithFrame:frame];
        v.backgroundColor = [UIColor whiteColor];
        v.opaque = YES;
        v;
    });
    
    _collView = ({

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView *v = [[UICollectionView alloc] initWithFrame:frame
                                                 collectionViewLayout:flowLayout];
        v.delegate = self;
        v.dataSource = self;
        v.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        v.backgroundColor = [UIColor whiteColor];
        
        [v registerClass:[FontIconViewerCell class]
      forCellWithReuseIdentifier:@"FontIconViewerCell"];
        
        v;
        
    });
    
    [self.view addSubview:_collView];

}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    const CGFloat top = [[self topLayoutGuide] length];
    const CGFloat bottom = [[self bottomLayoutGuide] length];
    _collView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_names) {
        
        _names = [_glyphs.allKeys sortedArrayUsingComparator:^(NSString *obj1,
                                                               NSString * obj2) {
            return [obj1 compare:obj2];
        }];
        [self.collView reloadData];
    }
    
    if (!_fontCache) {
        _fontCache = [KxFontIconCache fontIconCacheWithPath:_fontPath];
    }
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _names.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *name = _names[indexPath.row];
    NSString *glyph = _glyphs[name];
    UIImage *image = [_fontCache imageWithGlyph:glyph
                                       fontSize:36
                                      imageSize:(CGSize){40, 40}
                                      foreColor:[UIColor darkTextColor]
                                    strokeColor:nil
                                    strokeWidth:0
                                      backColor:nil];
    
    FontIconViewerCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FontIconViewerCell"
                                                     forIndexPath:indexPath];

    cell.titleLabel.text = name;
    cell.imageView.image = image;
    
    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    
    const CGFloat W = collectionView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right;
    const NSUInteger count =  W / 70.f;
    const CGFloat size = roundf(W / (CGFloat)count - flowLayout.minimumInteritemSpacing);
    
    return (CGSize){size, size};
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}


@end
