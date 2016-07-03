//
//  SYTopClickView.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/2.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYTopClickView.h"

@implementation SYTopClickView

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SYScreenW, 30)];
    window_.rootViewController = [[UIViewController alloc] init];
    window_.backgroundColor = [UIColor redColor];
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
   

}

+ (void)show
{
    window_.hidden = NO;
}

+ (void)hidden
{
    window_.hidden = YES;
}


+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)supView
{
    for (UIScrollView *subView in supView.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]] && subView.isShowingOnKeyWindow) {
            CGPoint offset = subView.contentOffset;
            offset.y = -subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        
        [self searchScrollViewInView:subView];
    }
}


@end
