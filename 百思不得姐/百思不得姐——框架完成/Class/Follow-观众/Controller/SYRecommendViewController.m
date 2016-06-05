//
//  SYRecommendViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/1.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYRecommendViewController.h"
#import "SYLoginRegisterViewController.h"


@interface SYRecommendViewController ()


@end

@implementation SYRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_search_icon~iphone" selImage:@"nav_search_icon_click~iphone" target:self action:@selector(searchBtn)];
    
}

- (void)searchBtn
{
    SYLoginRegisterViewController *login = [[SYLoginRegisterViewController alloc]init];
    [self.navigationController presentViewController:login animated:YES completion:nil];
}
@end