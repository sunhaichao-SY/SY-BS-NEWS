//
//  SYTextItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/8.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//  段子 模型

#import <Foundation/Foundation.h>

@interface SYTextItem : NSObject

//时间
@property (nonatomic,strong) NSString *passtime;

//内容
@property (nonatomic,strong) NSString *text;

//赞
@property (nonatomic,assign) NSInteger up;

//损
@property (nonatomic,assign) NSInteger down;

//转发
@property (nonatomic,assign) NSInteger forward;

//评论
@property (nonatomic,assign) NSInteger comment;

//姓名和头像模型
@property (nonatomic,strong) NSDictionary *u;

@end





















