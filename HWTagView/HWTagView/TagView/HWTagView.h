//
//  HWTagView.h
//  HWTagView
//
//  Created by lee on 2019/5/28.
//  Copyright © 2019 Personal Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWTagViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWTagView : UIView

@property (nonatomic, weak) id<HWTagViewDelegate>delegate;

@property (nonatomic, weak) id<HWTagViewDataSource>dataSource;

/** 外观配置项 */

@property (nonatomic, strong) UIColor *themeColor;

@property (nonatomic, assign) NSInteger tagCornerRadius;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) UIColor * selectedColor;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
