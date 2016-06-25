//
//  SYPublishViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/31.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//
/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */

#import "SYPublishViewController.h"
#import "SYQuickLoginButton.h"
#import <pop/pop.h>
#import "SYLoginRegisterViewController.h"

static CGFloat const SYAnimationDelay = 0.1;
static CGFloat const SYSpringFactor = 10;

@interface SYPublishViewController ()

@end

@implementation SYPublishViewController

//点击背景View控制器会退出，退出时会调用cancelWithCompletionBlock的方法,让里面的subView控件按照设置的动画模式一次退出
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    //调用cancelWithCompletionBlock的方法
    [self cancelWithCompletionBlock:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //让控制器的View不能点击
//    self.view.userInteractionEnabled = NO;
    
    // 数据，因为图片名字和文字不能用for循环一次赋值，所以把图片名字和图片分别放进一个组中，然后进行赋值
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-link"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"发链接"];
//
    //中间六个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 50;
    //在这里起start名字是因为当按钮退下时的X值正好是按钮一开始的值
    CGFloat buttonStartY = (SYScreenH - 2 * buttonH) * 0.6;
//    CGFloat buttonStartY = SYScreenH * 0.5;
    CGFloat buttonStartX = 20;
    //间距
    CGFloat xMargin = (SYScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);

    //利用for循环依次创建出六个按钮，因为按钮的样式和登录面板下面按个按钮的样式是一样的所以利用SYQuickLoginButton自定义按钮
    for (int i = 0; i < images.count; i++) {
        SYQuickLoginButton *button = [[SYQuickLoginButton alloc] init];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        //因为之前把图片名字和图片分别放进两个数组中所以这里我们可以利用titles[i]和images[i] 分别取出对应的名字和图片
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //因为我们要利用pop这个框架给按钮做动画，所以我们在调用框架的方法中对按钮的位置进行赋值，即一开始按钮的Y位置位于控制器View的最上面，当动画开始时从上方滑下来
        //设置frame
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - SYScreenH;
        [self.view addSubview:button];
        
        //按钮动画
        //利用POP里面的POPSpringAnimation方法，弹簧效果
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        //设置按钮从哪里开始
        anim.fromValue =[NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        //设置按钮到哪里结束
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        //弹簧的弹力
        anim.springBounciness =SYSpringFactor;
        //弹簧的速度
        anim.springSpeed = SYSpringFactor;
        //设置每个按钮的开始下滑的时间，每个按钮开始时间间距0.1秒
        anim.beginTime = CACurrentMediaTime() + SYAnimationDelay * i;
        //把动画效果添加给按钮
        [button pop_addAnimation:anim forKey:nil];
        
    }
    
    //添加标语
    UIImageView *placardView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    //设置一开始按钮的位置，如果不设置这个位置，那么当加载完控制器之后左上角后会默认出现在左上角
    placardView.center = CGPointMake(SYScreenW * 0.5, -(placardView.sy_size.width));
    [self.view addSubview:placardView];
    //标语动画(底下关于标语的动画方法注释同按钮注释一样)
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

    //把动画效果添加到标语
    [placardView pop_addAnimation:anim forKey:nil];
}

//点击按钮触动方法
- (void)buttonClick:(UIButton *)button
{
    //点击按钮之后，各个按钮分别退出之后调用相对应的方法
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            SYLog(@"发视频");
        }else if (button.tag == 1){
            SYLog(@"发图片");
        }else if (button.tag == 2){
            SYLog(@"发段子");
        }else if (button.tag == 3)
        {
            SYLog(@"发声音");
        }else if (button.tag == 4)
        {
            //点击审帖弹出登录页码
            SYLoginRegisterViewController *login = [[SYLoginRegisterViewController alloc]init];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
            
        }else if (button.tag == 5)
        {
            SYLog(@"发链接");
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
    //打印View里面的subView会发现按钮开始于下坐标第二个开始
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