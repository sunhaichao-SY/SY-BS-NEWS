//
//  SYQuickLoginButton.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/21.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//此方法用于调整Button内部图片和字体的位置和尺寸。

#import "SYQuickLoginButton.h"

@implementation SYQuickLoginButton
- (void)awakeFromNib
{
    [self setup];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    //设置字体居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片位置和尺寸
    self.imageView.sy_y = 0;
    self.imageView.sy_centerX = self.sy_width * 0.5;
    
    //设置文字的尺寸
    self.titleLabel.sy_y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.sy_x = 0;
    self.titleLabel.sy_width = self.sy_width;
    self.titleLabel.sy_height = self.sy_height - self.imageView.sy_height;
}
@end
