//
//  SYProgressView.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/18.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYProgressView.h"

@implementation SYProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    
    
    
}
@end
