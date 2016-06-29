//
//  SYTextItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/8.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//  段子 模型

#import <UIKit/UIKit.h>

@class SYUItem,SYGIFItem,SYVideoItem,SYAudioItem,SYTopCommentItem;

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

//类型
@property (nonatomic,strong) NSString *type;

//姓名和头像模型
@property (nonatomic,strong) SYUItem *u;

//gif图片
@property (nonatomic,strong) SYGIFItem *gif;

//image图片
@property (nonatomic,strong) SYUItem *image;

//video
@property (nonatomic,strong) SYVideoItem *video;

//audio
@property (nonatomic,strong) SYAudioItem *audio;

//评论模型
@property (nonatomic,strong) SYTopCommentItem *top_comment;
/*********** 额外的辅助属性 ***********/

//cell的高度
@property (nonatomic,assign,readonly) CGFloat cellHeight;

//图片控件的frame
@property (nonatomic,assign,readonly) CGRect pictureF;

//声音控件的frame
@property (nonatomic, assign, readonly) CGRect soundF;

//视频空间的frame
@property (nonatomic,assign,readonly) CGRect videoF;

//图片是否太大
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;

//图片的下载进度
@property (nonatomic,assign) CGFloat pictureProgress;
@end





















