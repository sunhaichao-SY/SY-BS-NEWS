//
//  SYVideoView.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/25.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYTextItem;

@interface SYVideoView : UIView
@property (nonatomic,strong) SYTextItem *textItem;

+ (instancetype)videoView;
@end
