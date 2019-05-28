//
//  HWTagCollectionViewCell.h
//  HWTagView
//
//  Created by lee on 2019/5/28.
//  Copyright © 2019 Personal Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWTagCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy) NSString *content;
@property (strong, nonatomic) UILabel *tagLabel;
@property (nonatomic, strong) UIButton * tagBtn;

+ (CGSize) getSizeWithContent:(NSString *) content maxWidth:(CGFloat)maxWidth customHeight:(CGFloat)cellHeight;


@end

NS_ASSUME_NONNULL_END
