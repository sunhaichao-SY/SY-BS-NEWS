//
//  SYPublishViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/31.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYPublishViewController.h"
#import "SYQuickLoginButton.h"
@interface SYPublishViewController ()

@end

@implementation SYPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.sy_y = SYScreenH * 0.15;
    sloganView.sy_centerX = SYScreenW * 0.5;
    [self.view addSubview:sloganView];
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
//
    //中间六个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (SYScreenH - 2 * buttonH) * 0.5;
//    CGFloat buttonStartY = SYScreenH * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (SYScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);

    for (int i = 0; i < images.count; i++) {
        SYQuickLoginButton *button = [[SYQuickLoginButton alloc] init];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];

        
        //设置frame
        button.sy_width = buttonW;
        button.sy_height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        button.sy_x = buttonStartX + col * (xMargin + buttonW);
        button.sy_y  = buttonStartY + row * buttonH;
        [self.view addSubview:button];

    }
    
    
    

}


- (IBAction)black {
    [self dismissViewControllerAnimated:YES completion:nil];
}


////改变状态栏颜色
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
@end