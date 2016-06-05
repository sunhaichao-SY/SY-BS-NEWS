//
//  SYAttentionViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/3.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYAttentionViewController.h"
#import "SYLoginRegisterViewController.h"
#import "SYResigeringViewController.h"
@interface SYAttentionViewController ()

@end

@implementation SYAttentionViewController


//弹出登录页面
- (IBAction)loginBtn:(id)sender {
    SYLoginRegisterViewController *login = [[SYLoginRegisterViewController alloc]init];
    [self.navigationController presentViewController:login animated:YES completion:nil];
}


//弹出注册页面
- (IBAction)registerBtn:(id)sender {
   
    SYResigeringViewController *resiger = [[SYResigeringViewController alloc]init];
    [self.navigationController presentViewController:resiger animated:YES completion:nil];
    
}

@end
