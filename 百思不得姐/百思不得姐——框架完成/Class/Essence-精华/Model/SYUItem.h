//
//  SYUItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/18.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYUItem : NSObject

/************ u ************/

//头像数组
@property (nonatomic,strong) NSArray *header;

//是否是会员
@property (nonatomic,assign,getter=isVip) BOOL is_v;

//名字
@property (nonatomic,strong) NSString *name;

//性别
@property (nonatomic,strong) NSString *sex;

/************ image ************/

//大图
@property (nonatomic,strong) NSArray *big;

//下载的URL
@property (nonatomic,strong) NSArray *download_url;

//高度
@property (nonatomic,assign) NSInteger height;

//中图
@property (nonatomic,strong) NSArray *medium;

//小图
@property (nonatomic,strong) NSArray *small;

//宽度
@property (nonatomic,assign) NSInteger width;



@end
