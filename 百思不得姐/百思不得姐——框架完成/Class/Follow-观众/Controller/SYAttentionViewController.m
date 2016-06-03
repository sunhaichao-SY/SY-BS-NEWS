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
- (IBAction)loginBtn:(id)sender {
    SYLoginRegisterViewController *login = [[SYLoginRegisterViewController alloc]init];
    [self.navigationController presentViewController:login animated:YES completion:nil];
}

- (IBAction)registerBtn:(id)sender {
   
    SYResigeringViewController *resiger = [[SYResigeringViewController alloc]init];
    [self.navigationController presentViewController:resiger animated:YES completion:NO];
    
}

@end
