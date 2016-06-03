//
//  SYADItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/31.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//  从返回的数据中挑选有用的属性

#import <Foundation/Foundation.h>

@interface SYADItem : NSObject

//当前广告图片URL
@property (nonatomic,strong) NSString *w_picurl;
//点击广告之后跳入的广告网址
@property (nonatomic,strong) NSString *ori_curl;
//广告图片的宽度
@property (nonatomic,assign) CGFloat w;
//广告图片的高度
@property (nonatomic,assign) CGFloat h;


@end
