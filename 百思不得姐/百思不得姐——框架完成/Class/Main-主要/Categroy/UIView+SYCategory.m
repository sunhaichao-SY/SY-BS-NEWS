//
//  UIView+SYCategory.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/16.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "UIView+SYCategory.h"

@implementation UIView (SYCategory)

- (CGSize)sy_size
{
    return self.frame.size;
}

- (void)setSy_size:(CGSize)sy_size
{
    CGRect frame = self.frame;
    frame.size = sy_size;
    self.frame = frame;
}

- (CGFloat)sy_width
{
    return self.frame.size.width;
}

- (CGFloat)sy_height
{
    return self.frame.size.height;
}

- (void)setSy_width:(CGFloat)sy_width
{
    CGRect frame = self.frame;
    frame.size.width = sy_width;
    self.frame = frame;
}

- (void)setSy_height:(CGFloat)sy_height
{
    CGRect frame = self.frame;
    frame.size.height = sy_height;
    self.frame = frame;
}

- (CGFloat)sy_x
{
    return self.frame.origin.x;
}

- (void)setSy_x:(CGFloat)sy_x
{
    CGRect frame = self.frame;
    frame.origin.x = sy_x;
    self.frame = frame;
}

- (CGFloat)sy_y
{
    return self.frame.origin.y;
}

- (void)setSy_y:(CGFloat)sy_y
{
    CGRect frame = self.frame;
    frame.origin.y = sy_y;
    self.frame = frame;
}

- (CGFloat)sy_centerX
{
    return self.center.x;
}

- (void)setSy_centerX:(CGFloat)sy_centerX
{
    CGPoint center = self.center;
    center.x = sy_centerX;
    self.center = center;
}

- (CGFloat)sy_centerY
{
    return self.center.y;
}

- (void)setSy_centerY:(CGFloat)sy_centerY
{
    CGPoint center = self.center;
    center.y = sy_centerY;
    self.center = center;
}

- (CGFloat)sy_right
{
    //    return self.sy_x + self.sy_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)sy_bottom
{
    //    return self.sy_y + self.sy_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setSy_right:(CGFloat)sy_right
{
    self.sy_x = sy_right - self.sy_width;
}

- (void)setSy_bottom:(CGFloat)sy_bottom
{
    self.sy_y = sy_bottom - self.sy_height;
}

- (BOOL)isShowingOnKeyWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
   //以主窗口左上角为坐标点,计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame  fromView:self.superview];
     CGRect winBounds = keyWindow.bounds;
    
    //主窗口的bounds 和 self 的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window ==keyWindow && intersects;
}
@end
