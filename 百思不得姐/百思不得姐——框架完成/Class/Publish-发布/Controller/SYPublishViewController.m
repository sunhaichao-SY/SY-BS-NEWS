//
//  SYPublishViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/31.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYPublishViewController.h"
#import "SYQuickLoginButton.h"
#import <pop/pop.h>

static CGFloat const SYAnimationDelay = 0.1;
static CGFloat const SYSpringFactor = 10;

@interface SYPublishViewController ()

@end

@implementation SYPublishViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self cancelWithCompletionBlock:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //让控制器的View不能点击
//    self.view.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
//
    //中间六个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 50;
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
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置frame
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - SYScreenH;
        [self.view addSubview:button];
        
        //按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue =[NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness =SYSpringFactor;
        anim.springSpeed = SYSpringFactor;
        anim.beginTime = CACurrentMediaTime() + SYAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    //添加标语
    UIImageView *placardView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    placardView.center = CGPointMake(SYScreenW * 0.5, -(placardView.sy_size.width));
    [self.view addSubview:placardView];
    //标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = SYScreenW * 0.5;
    CGFloat centenEndY = SYScreenH * 0.2;
    CGFloat centerBeginY = centenEndY - SYScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centenEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * SYAnimationDelay;
    anim.springBounciness = SYSpringFactor;
    anim.springSpeed = SYSpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //标语动画执行完毕，回复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    
    
    [placardView pop_addAnimation:anim forKey:nil];
}

- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            SYLog(@"发视频");
        }else if (button.tag == 1){
            SYLog(@"发图片");
        }
    }];
}

- (IBAction)black {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self cancelWithCompletionBlock:nil];
}

/**
 *  先执行退出动画，动画完毕后执行completionBlock
 *
 *  @param completionBlock动画结束后调用Block里面的方法
 */

- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    //正在执行动画的时候后面的控制器的View是不能点击的
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex ; i < self.view.subviews.count; i++) {
        
        UIView *subView = self.view.subviews[i];
        
        //基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centenY = subView.sy_centerY + SYScreenH;
        /*
        //动画节奏(一开始很慢后面很快)
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        */
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.sy_centerX , centenY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * SYAnimationDelay;
        [subView pop_addAnimation:anim forKey:nil];
        
        //监听最后一个动画，当最后一个动画结束后退出控制器
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                //根据传进来的Block是否有值来调用前面或者后面的方法
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

////改变状态栏颜色
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
@end