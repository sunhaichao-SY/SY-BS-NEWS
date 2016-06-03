//
//  SYPublishViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/31.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYPublishViewController.h"

@interface SYPublishViewController ()

@end

@implementation SYPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//改变状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end