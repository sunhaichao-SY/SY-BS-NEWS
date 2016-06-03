//
//  SYMeViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/16.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYMeViewController.h"
#import "SYSettingViewController.h"
@interface SYMeViewController ()

@end

@implementation SYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置背景颜色
    self.view.backgroundColor = SYCommonBgColor;
    //设置navigationItem.title的标题
    self.navigationItem.title = @"我的";
    //设置右边两个按钮，调用UITabBarItem+SYCategory.h里面的类方法，可直接设置按钮样式
    //设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" target:self action:@selector(settingItemClick)];
    
    //设置月亮按钮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" selImage:@"mine-moon-icon-click" target:self action:@selector(moonItemClick:)];

    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];

}
//设置按钮事件处理
- (void)settingItemClick
{
    SYSettingViewController *setting = [[SYSettingViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}
//月亮按钮事件处理
- (void)moonItemClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    SYLogFunc
}
@end
