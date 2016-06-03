//
//  SYResigeringViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/21.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//因为注册登录在整个项目中很多地方都需要，所以我把它放在主要控制器组中

//注册和登录按钮背景图片四个角是有倒圆角的，素材图片是长方形的没有倒圆角，所以我们需要设置图片有倒圆角的效果。在XIB中点击按钮图片右边User Defined Runtime Attributesz中根据KVC进行设置相应参数。
#import "SYResigeringViewController.h"

@interface SYResigeringViewController ()
//因为当点击右上角注册按钮之后注册界面会从侧滑进入，把登录界面推向左侧。所以我们可以设置登录界面左侧布局的Constranint的属性值。
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayout;

@end

@implementation SYResigeringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击左上角X，退出页面
- (IBAction)leaveBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击页面退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//点击注册界面右上角按钮进行事件处理

- (IBAction)loginOrRegister:(UIButton *)button {
    
    [self.view endEditing:YES];
    //假如登录界面左侧与背景的Constranint为0，则代表当前界面是登录界面
    //假如登录界面左侧与背景的Constranint为负的当前界面的宽度，则代表登录界面从左侧移出，注册界面从右侧滑进
    if (self.leftLayout.constant) {
        self.leftLayout.constant = 0;
        button.selected = NO;
        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
    }else
    {
        self.leftLayout.constant = -self.view.sy_width;
        button.selected = YES;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    //layoutIfNeeded强制布局
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}


@end
