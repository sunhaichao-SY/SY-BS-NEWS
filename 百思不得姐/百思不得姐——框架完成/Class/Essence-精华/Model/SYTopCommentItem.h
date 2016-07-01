//
//  SYTopCommentItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/29.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYUItem;
@interface SYTopCommentItem : NSObject

//评论内容
@property (nonatomic,strong) NSString *content;

//点赞数
@property (nonatomic,strong) NSString *like_count;


//声音时间
@property (nonatomic,assign) NSNumber *voicetime;

//U模型
@property (nonatomic,strong) SYUItem *u;

@end
