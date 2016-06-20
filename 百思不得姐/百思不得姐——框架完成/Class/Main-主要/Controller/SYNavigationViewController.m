//
//  SYNavigationViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/16.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYNavigationViewController.h"

@interface SYNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation SYNavigationViewController

//修改整体导航栏上的文字大小
//load类加载进内存的时候调用，只会调用一次
+ (void)load
{
    UINavigationBar *nav = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    nav.titleTextAttributes =dic;
}
//initialize是在类或者其子类的第一个方法被调用前调用,所以在这里面进行初始化操作。设置NavigarionBar的背景图片
+ (void)initialize
{
    //设置NavigationBar的背景图片，必须使用UIBarMetricsDefault
    UINavigationBar *bar =[UINavigationBar appearanceWhenContainedIn:self, nil];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//让控制器作为NavigationBar的手势处理代理对象
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    
    //让边缘滑动手势失效
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer *)UIScreenEdgePanGestureRecognizer
{
    NSLog(@"123");
}
//拦截Push请求，修改里面属性
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        //统一设置NavigationBar顶部返回按钮样式和文字
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        //按钮大小匹配
        [backBtn sizeToFit];
        //设置按钮和边界的距离
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIView *view = [[UIView alloc]init];
        view.frame = backBtn.bounds;
        [view addSubview:backBtn];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //必须放在最后，否则之前的设置都会失效
    [super pushViewController:viewController animated:YES];
}
//返回上一个控制器
- (void)goBack
{
    [self popViewControllerAnimated:YES];
}
//UIGestureRecognizerDelegate 用来判断是否接受手势处理

/*Two*/
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //如果一个控制器没有子控制器，则该控制器手势返回失效
    //如果一个控制器里面包含一个或者一个以上的控制器，则其子控制器的手势返回功能可用
    return self.childViewControllers.count > 1;
}
@end
