//
//  SYWebViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/5.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYWebViewController.h"
#import <WebKit/WebKit.h>

@interface SYWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation SYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" hightImage:@"comment_nav_item_share_icon_click" target:self action:@selector(share)];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SYScreenW, SYScreenH)];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);

    [self.webView addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];
}

- (void)share{
    SYLogFunc
}

@end
