//
//  SYCrossViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/6.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYCrossViewController.h"
#import "SYCrossAllViewController.h"
#import "SYCrossTextViewController.h"
#import "SYCrossVideoViewController.h"
#import "SYCrossPictureViewController.h"
#import "SYCrossSoundViewController.h"


@interface SYCrossViewController ()

@end

@implementation SYCrossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏样式
    [self setupNavigationItem];
 
    [self addCrossViewController];
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
    SYCrossAllViewController *all = [[SYCrossAllViewController alloc]init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    //视频
    SYCrossVideoViewController *video = [[SYCrossVideoViewController alloc]init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    //图片
    SYCrossPictureViewController *picture = [[SYCrossPictureViewController alloc]init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    //段子
    SYCrossTextViewController *text = [[SYCrossTextViewController alloc]init];
    text.title = @"段子";
    [self addChildViewController:text];
    
    //声音
    SYCrossSoundViewController *sound = [[SYCrossSoundViewController alloc]init];
    sound.title = @"声音";
    [self addChildViewController:sound];
}

- (void)crossClick
{
    SYLogFunc
}


@end