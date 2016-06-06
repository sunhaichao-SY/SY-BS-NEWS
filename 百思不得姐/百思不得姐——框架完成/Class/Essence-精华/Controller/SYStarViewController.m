//
//  SYStarViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/6.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
// 红人榜

#import "SYStarViewController.h"

@interface SYStarViewController ()

@end

@implementation SYStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SYRandomColor;
    self.navigationItem.title = @"红人榜";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" hightImage:@"comment_nav_item_share_icon_click" target:self action:@selector(share)];
}
- (void)share
{
    SYLogFunc
}
@end