//
//  SYEssenceViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/16.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYEssenceViewController.h"

@interface SYEssenceViewController ()

@end

@implementation SYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
     self.view.backgroundColor = SYCommonBgColor;
    //设置navigationItem.titleView的标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左边按钮，调用UITabBarItem+SYCategory.h里面的类方法，可直接设置按钮样式
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_item_game_icon~iphone" hightImage:@"nav_item_game_iconN~iphone" target:self action:@selector(gameClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"RandomAcross~iphone" hightImage:@"RandomAcrossClick~iphone" target:self action:@selector(randomClick)];
}

//左边按钮事件处理
- (void)gameClick
{
    SYLogFunc
}

- (void)randomClick
{
    SYLogFunc
}
@end
