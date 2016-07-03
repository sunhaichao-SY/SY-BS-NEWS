//
//  SYStarViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/6.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
// 红人榜

#import "SYStarViewController.h"
#import "SYRedStartViewController.h"
#import "SYFansCountViewController.h"
#import "SYFansFastestViewController.h"
#import "SYContributionViewController.h"
@interface SYStarViewController ()

@end

@implementation SYStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SYRandomColor;
    self.navigationItem.title = @"红人榜";
    self.topTitleBtn = 4;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" hightImage:@"comment_nav_item_share_icon_click" target:self action:@selector(share)];
    //添加所有的子控制器
    [self addAllChildViewController];
}

//添加所有的子控制器
- (void)addAllChildViewController
{
    
    //红人榜
    SYRedStartViewController *startView = [[SYRedStartViewController alloc]init];
    startView.title = @"红人榜";
    [self addChildViewController:startView];
    
    //涨粉最快
    SYFansFastestViewController *fansFastest = [[SYFansFastestViewController alloc]init];
    fansFastest.title = @"涨粉最快";
    [self addChildViewController:fansFastest];
    
    //贡献榜
    SYContributionViewController *contribution = [[SYContributionViewController alloc]init];
    contribution.title = @"贡献榜";
    [self addChildViewController:contribution];
    
    //粉丝总数
    SYFansCountViewController *fansCount = [[SYFansCountViewController alloc]init];
    fansCount.title = @"粉丝总数";
    [self addChildViewController:fansCount];

    
}





- (void)share
{
    SYLogFunc
}
@end