//
//  HWTagViewProtocol.h
//  HWTagView
//
//  Created by lee on 2019/5/28.
//  Copyright © 2019 Personal Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HWTagView;

NS_ASSUME_NONNULL_BEGIN

@protocol HWTagViewDataSource <NSObject>

@required

- (NSInteger)numOfItems;

- (NSString *)tagView:(HWTagView *)tagView titleForItemAtIndex:(NSInteger)index;

@end

@protocol HWTagViewDelegate <NSObject>

@optional

- (void)tagView:(HWTagView *)tagView didSelectedItemAtIndex:(NSInteger)index;

/**
 使用frame布局实现一下代理方法获得填充数据后的正确的高度(高度已内部调整)
 
 @param tagView tagView
 @param height 高度
 */
- (void)tagView:(HWTagView *)tagView heightUpdated:(CGFloat)height;


@end

NS_ASSUME_NONNULL_END
