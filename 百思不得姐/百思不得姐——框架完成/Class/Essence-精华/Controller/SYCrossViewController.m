//
//  SYCrossViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/6.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYCrossViewController.h"
#import "SYEssenceBaseViewController.h"

@interface SYCrossViewController ()

@end

@implementation SYCrossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏样式
    [self setupNavigationItem];
 
    [self addCrossViewController];
    
    self.topTitleBtn = 5;
}

//设置导航栏样式
- (void)setupNavigationItem
{
    self.view.backgroundColor = SYRandomColor;
    self.navigationItem.title = @"穿越";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"RandomAcross~iphone" hightImage:@"RandomAcrossClick~iphone" target:self action:@selector(crossClick)];
}

//添加子控制器
- (void)addCrossViewController
{

    //全部
    SYEssenceBaseViewController *all = [[SYEssenceBaseViewController alloc]init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    //视频
    SYEssenceBaseViewController *video = [[SYEssenceBaseViewController alloc]init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    //图片
    SYEssenceBaseViewController *picture = [[SYEssenceBaseViewController alloc]init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    //段子
    SYEssenceBaseViewController *text = [[SYEssenceBaseViewController alloc]init];
    text.title = @"段子";
    [self addChildViewController:text];
    
    //声音
    SYEssenceBaseViewController *sound = [[SYEssenceBaseViewController alloc]init];
    sound.title = @"声音";
    [self addChildViewController:sound];
}

- (void)crossClick
{
    SYLogFunc
}


@end