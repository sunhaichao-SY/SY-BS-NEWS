//
//  SYTextItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/8.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//  段子 模型

#import <UIKit/UIKit.h>
@class SYUItem;

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
@property (nonatomic,strong) SYUItem *u;

//gif图片
@property (nonatomic,strong) SYUItem *gif;

//image图片
@property (nonatomic,strong) SYUItem *image;

//帖子的类型
@property (nonatomic,assign) SYEssenceBaseType type;


/*********** 额外的辅助属性 ***********/

//cell的高度
@property (nonatomic,assign,readonly) CGFloat cellHeight;
//图片空间的frame
@property (nonatomic,assign,readonly) CGRect pictureF;
//图片是否太大
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;

//图片的下载进度
@property (nonatomic,assign) CGFloat pictureProgress;
@end





















