//
//  SYNewViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/16.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYNewViewController.h"
#import "SYLoginRegisterViewController.h"


@interface SYNewViewController ()

@end

@implementation SYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    self.view.backgroundColor = SYCommonBgColor;
    //设置navigationItem.titleView的标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左边按钮，调用UITabBarItem+SYCategory.h里面的类方法，可直接设置按钮样式
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"review_post_nav_icon~iphone" hightImage:@"review_post_nav_iconN~iphone@2x" target:self action:@selector(leftBtnClick)];
}

//左边按钮事件处理
- (void)leftBtnClick
{
    SYLoginRegisterViewController *recommend = [[SYLoginRegisterViewController alloc]init];
    [self.navigationController presentViewController:recommend animated:YES completion:nil];
}

@end
