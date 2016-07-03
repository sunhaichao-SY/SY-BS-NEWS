//
//  SYTabBar.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/16.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//自定义底部TabBar的Frame

#import "SYTabBar.h"
#import "SYPublishViewController.h"

NSString *const SYTabBarDidSelectNotification = @"SYTabBarDidSelectNotification";

@interface SYTabBar()
//中间发布按钮
@property (nonatomic,weak) UIButton *publishButton;
@end

@implementation SYTabBar
//因为用代码会调用initWithFrame这个方法，并进行初始化一次的设置，所以在里面设置按钮的属性
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置中间添加按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return self;
}
//重新布局TabBar
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    //标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    CGFloat width = self.sy_width;
    CGFloat height = self.sy_height;
    
    // 设置发布按钮的frame
    _publishButton.center = CGPointMake(width * 0.5, height * 0.5 + 2);
//
    _publishButton.sy_height = height;
    _publishButton.sy_width = width;
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    //因为在这里里面需要设置button的监听 如果是view *button 那么就不会提示addtag这个方法
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
        
        if (added == NO) {
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    added = YES;
}

- (void)buttonClick{
    
    //发出一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SYTabBarDidSelectNotification" object:nil userInfo:nil];
}
//点击中间按钮事件处理
- (void)publishButtonClick
{
    SYPublishViewController *publish = [[SYPublishViewController alloc]init];
    [self.window.rootViewController presentViewController:publish animated:YES completion:nil];
}
@end
