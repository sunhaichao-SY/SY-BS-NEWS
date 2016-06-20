//
//  SYEssenceViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/16.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYEssenceViewController.h"
#import "SYEssenceBaseViewController.h"
#import "SYStarViewController.h"
#import "SYCrossViewController.h"

@interface SYEssenceViewController ()
@end

@implementation SYEssenceViewController

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
    //设置navigationItem.titleView的标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置左边按钮，调用UITabBarItem+SYCategory.h里面的类方法，可直接设置按钮样式
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_item_game_icon~iphone" hightImage:@"nav_item_game_iconN~iphone" target:self action:@selector(gameClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"RandomAcross~iphone" hightImage:@"RandomAcrossClick~iphone" target:self action:@selector(crossClick)];
    
}


//添加所有的子控制器
- (void)addAllChildViewController
{
    
    //推荐
    SYEssenceBaseViewController *allVc = [[SYEssenceBaseViewController alloc]init];
    allVc.title = @"推荐";
    allVc.URL = SYEssenceRecommendURL;
    [self addChildViewController:allVc];
    
    //视频
    SYEssenceBaseViewController *videoVc = [[SYEssenceBaseViewController alloc]init];
    videoVc.title = @"视频";
    videoVc.URL = SYEssenceVideoURL;
    [self addChildViewController:videoVc];
    
    //图片
    SYEssenceBaseViewController *pictureVc = [[SYEssenceBaseViewController alloc]init];
    pictureVc.title = @"图片";
    pictureVc.URL = SYEssencePictureURL;
    [self addChildViewController:pictureVc];
    
    //段子
    SYEssenceBaseViewController *textVc = [[SYEssenceBaseViewController alloc]init];
    textVc.title = @"段子";
    textVc.URL = SYEssenceTextURL;
    [self addChildViewController:textVc];
    
    //网红
    SYEssenceBaseViewController *starVc = [[SYEssenceBaseViewController alloc]init];
    starVc.title = @"网红";
    starVc.URL = SYEssenceStartURL;
    [self addChildViewController:starVc];
    
    //排行
    SYEssenceBaseViewController *rankingVc = [[SYEssenceBaseViewController alloc]init];
    rankingVc.title = @"排行";
    rankingVc.URL = SYEssenceListsURL;
    [self addChildViewController:rankingVc];
    
    //社会
    SYEssenceBaseViewController *societyVc = [[SYEssenceBaseViewController alloc]init];
    societyVc.title = @"社会";
    societyVc.URL = SYEssenceSocietyURL;
    [self addChildViewController:societyVc];
    
    //美女
    SYEssenceBaseViewController *girlVc = [[SYEssenceBaseViewController alloc]init];
    girlVc.title = @"美女";
    girlVc.URL = SYEssenceGirlURL;
    [self addChildViewController:girlVc];
    
    //游戏
    SYEssenceBaseViewController *gameVc = [[SYEssenceBaseViewController alloc]init];
    gameVc.title = @"游戏";
    gameVc.URL = SYEssenceGameURL;
    [self addChildViewController:gameVc];
    
    
}

//点击导航栏左边按钮进入红人榜界面
- (void)gameClick
{
    SYStarViewController *star = [[SYStarViewController alloc]init];
    [self.navigationController pushViewController:star animated:YES];
}

//点击导航栏右边按钮进入穿越界面
- (void)crossClick
{
    SYCrossViewController *cross = [[SYCrossViewController alloc]init];
    [self.navigationController pushViewController:cross animated:YES];
}

@end
