//
//  SYAudioItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/25.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SYAudioItem : NSObject


//URL
@property (nonatomic,strong) NSArray *download_url;

//时间
@property (nonatomic,assign) NSInteger duration;

//高度
@property (nonatomic,assign) NSInteger height;

//播放次数
@property (nonatomic,assign) NSInteger playcount;

//专辑图片
@property (nonatomic,strong) NSArray *thumbnail;

//宽度
@property (nonatomic,assign) NSInteger width;
@end
