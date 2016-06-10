//
//  SYNewViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/16.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYNewViewController.h"
#import "SYLoginRegisterViewController.h"
#import "SYEssenceBaseViewController.h"


@interface SYNewViewController ()

@end

@implementation SYNewViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    //设置导航栏的内容
    [self setupNavigationBar];
    
    //添加所有的子控制器
    [self addAllChildViewController];
    
      self.topTitleBtn = 6;
    

}

//设置导航栏的内容
- (void)setupNavigationBar
{
    //设置背景颜色
    self.view.backgroundColor = SYCommonBgColor;
    //设置navigationItem.titleView的标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左边按钮，调用UITabBarItem+SYCategory.h里面的类方法，可直接设置按钮样式
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"review_post_nav_icon~iphone" hightImage:@"review_post_nav_iconN~iphone@2x" target:self action:@selector(leftBtnClick)];
    
}


//添加所有的子控制器
- (void)addAllChildViewController
{
    
    //全部
    SYEssenceBaseViewController *allVc = [[SYEssenceBaseViewController alloc]init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    //视频
    SYEssenceBaseViewController *videoVc = [[SYEssenceBaseViewController alloc]init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    //图片
    SYEssenceBaseViewController *pictureVc = [[SYEssenceBaseViewController alloc]init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    //段子
    SYEssenceBaseViewController *textVc = [[SYEssenceBaseViewController alloc]init];
    textVc.title = @"段子";
    [self addChildViewController:textVc];
    
    //网红
    SYEssenceBaseViewController *starVc = [[SYEssenceBaseViewController alloc]init];
    starVc.title = @"网红";
    [self addChildViewController:starVc];
    
    //美女
    SYEssenceBaseViewController *girlVc = [[SYEssenceBaseViewController alloc]init];
    girlVc.title = @"美女";
    [self addChildViewController:girlVc];
    
    //游戏
    SYEssenceBaseViewController *gameVc = [[SYEssenceBaseViewController alloc]init];
    gameVc.title = @"游戏";
    [self addChildViewController:gameVc];
    
    //声音
    SYEssenceBaseViewController *soundVc = [[SYEssenceBaseViewController alloc]init];
    soundVc.title = @"声音";
    [self addChildViewController:soundVc];
    
}

//左边按钮事件处理
- (void)leftBtnClick
{
    SYLoginRegisterViewController *recommend = [[SYLoginRegisterViewController alloc]init];
    [self.navigationController presentViewController:recommend animated:YES completion:nil];
}

@end
