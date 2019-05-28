//
//  HWTagCollectionViewCell.m
//  HWTagView
//
//  Created by lee on 2019/5/28.
//  Copyright © 2019 Personal Inc. All rights reserved.
//

#import "HWTagCollectionViewCell.h"

@implementation HWTagCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.tagLabel = [[UILabel alloc]init];
//        self.tagLabel.font = [UIFont systemFontOfSize:12];
//        self.tagLabel.frame = self.contentView.bounds;
//        self.tagLabel.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:self.tagLabel];
        
        self.tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tagBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        self.tagBtn.frame = self.contentView.bounds;
        [self.contentView addSubview:self.tagBtn];
        [self.tagBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.tagBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)setContent:(NSString *)content
{
    _content = content;
//    [_tagLabel setText:content];
    [self.tagBtn setTitle:content forState:UIControlStateNormal];
}

+ (CGSize) getSizeWithContent:(NSString *) content maxWidth:(CGFloat)maxWidth customHeight:(CGFloat)cellHeight
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize size = [content boundingRectWithSize:CGSizeMake(maxWidth-20, 24) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width+20, cellHeight);
}

- (void)btnClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected{
    [self btnClicked:self.tagBtn];
}

@end
