//
//  HWTagView.m
//  HWTagView
//
//  Created by lee on 2019/5/28.
//  Copyright © 2019 Personal Inc. All rights reserved.
//

#import "HWTagView.h"
#import <UICollectionViewLeftAlignedLayout.h>
#import "HWTagCollectionViewCell.h"

static CGFloat kDefaultCellHeight = 24;

@interface HWTagView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, assign) BOOL tempSelected;

@end

@implementation HWTagView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:self.collectionView];
        self.cellHeight = kDefaultCellHeight;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        self.cellHeight = kDefaultCellHeight;
    }
    return self;
}

#pragma mark - Layout
/** 适应布局变换 */
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    UICollectionViewLeftAlignedLayout *layout = (UICollectionViewLeftAlignedLayout *)_collectionView.collectionViewLayout;
    [layout invalidateLayout];
    
    _collectionView.frame = self.bounds;
    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])) {
        [self invalidateIntrinsicContentSize];
    }
    CGFloat height = _collectionView.collectionViewLayout.collectionViewContentSize.height;
    if (height != 0 && height != self.bounds.size.height) {
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
        _collectionView.frame = self.bounds;
        if ([self.delegate respondsToSelector:@selector(tagView:heightUpdated:)]) {
            [self.delegate tagView:self heightUpdated:height];
        }
    }
    
}

- (CGSize)intrinsicContentSize
{
    NSLog(@"height---%f",_collectionView.collectionViewLayout.collectionViewContentSize.height);
    return _collectionView.collectionViewLayout.collectionViewContentSize;
}

#pragma mark - Actions

- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numOfItems];
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HWTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.content = [self.dataSource tagView:self titleForItemAtIndex:indexPath.row];
    if (self.themeColor) {
        cell.tagLabel.textColor = self.themeColor;
    }
    CGFloat cornerRadius = self.tagCornerRadius;
    cell.backgroundView = [self drawConnerView:cornerRadius rect:cell.bounds backgroudColor:cell.backgroundColor borderColor:cell.tagLabel.textColor];
    return cell;
}

#pragma mark - UI_Style

/** 绘画圆角 解决卡顿*/
-(UIView *)drawConnerView:(CGFloat)cornerRadius rect:(CGRect)frame backgroudColor:(UIColor *)backgroud_color borderColor:(UIColor *)borderColor{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGRect bounds = CGRectInset(frame, 0, 0);
    CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMinY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMinX(bounds), CGRectGetMinY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMinX(bounds), CGRectGetMaxY(bounds), cornerRadius);
    layer.path = pathRef;
    CFRelease(pathRef);
    layer.strokeColor = [borderColor CGColor];
    layer.fillColor = backgroud_color.CGColor;
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    return roundView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tagView:didSelectedItemAtIndex:)]) {
        [self.delegate tagView:self didSelectedItemAtIndex:indexPath.row];
    }

}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [HWTagCollectionViewCell getSizeWithContent:[self.dataSource tagView:self titleForItemAtIndex:indexPath.row] maxWidth:_collectionView.frame.size.width customHeight:self.cellHeight];
}

#pragma mark - Lazy loading

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:[[UICollectionViewLeftAlignedLayout alloc] init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[HWTagCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    return _collectionView;
}


@end
