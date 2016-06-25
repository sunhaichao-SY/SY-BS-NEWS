//
//  SYSoundsView.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/25.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYTextItem;

@interface SYSoundsView : UIView
/**
 * 帖子数据
 */
@property (nonatomic,strong) SYTextItem *textItem;

/**
 *  定义一个接口
 */
+ (instancetype)audioView;
@end
