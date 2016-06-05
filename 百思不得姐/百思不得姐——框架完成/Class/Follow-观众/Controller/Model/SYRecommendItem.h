//
//  SYRecommendItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/1.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYRecommendItem : NSObject

//根据写出的Plish文件找出相应的数据进行定义

//头像的URL
@property (nonatomic,strong) NSString *image_list;

//关注的数量
@property (nonatomic,strong) NSString *sub_number;

//名字
@property (nonatomic,strong) NSString *theme_name;

//总帖数
@property (nonatomic,strong) NSString *post_num;
@end
