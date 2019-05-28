//
//  ViewController.m
//  HWTagView
//
//  Created by lee on 2019/5/28.
//  Copyright © 2019 Personal Inc. All rights reserved.
//

#import "ViewController.h"
#import "HWTagView.h"

@interface ViewController ()<HWTagViewDataSource, HWTagViewDelegate>

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     self.titleArray = @[@"小龙虾，日本皮皮虾", @"日本皮皮虾", @"蓝莓", @"美国进口蓝莓", @"意大利拉面", @"西瓜", @"苹果", @"牛肉", @"🐂", @"🍎", @"🍌",@"Object_C",@"C++",@"Java",@"Object_C",@"C++",@"Java",@"Object_C",@"C++",@"Java"];
    HWTagView * tagView = [[HWTagView alloc]initWithFrame:CGRectMake(20, 64, self.view.frame.size.width-40, 20)];
    tagView.dataSource = self;
    tagView.delegate = self;
    tagView.themeColor = [UIColor redColor];
    tagView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tagView.selectedColor = [UIColor brownColor];
    tagView.tagCornerRadius = 2;
    [self.view addSubview:tagView];
    
    [tagView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:64];
    [tagView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20];
    [tagView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20];
    // Do any additional setup after loading the view.
}

- (NSInteger)numOfItems{
    return self.titleArray.count;
}

- (NSString *)tagView:(HWTagView *)tagView titleForItemAtIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (void)tagView:(HWTagView *)tagView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"点击%@", self.titleArray[index]);
}


@end
