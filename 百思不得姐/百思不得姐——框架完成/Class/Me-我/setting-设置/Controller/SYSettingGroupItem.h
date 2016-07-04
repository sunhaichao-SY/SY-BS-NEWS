//
//  SYSettingGroupItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/4.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYSettingGroupItem : NSObject

//数组模型，用来存放没组的Cell
@property (nonatomic,strong) NSArray *items;

//头部模型
@property (nonatomic,strong) NSString *headerTitle;

//类方法
+ (instancetype)groupWithItems:(NSArray *)items;

@end
