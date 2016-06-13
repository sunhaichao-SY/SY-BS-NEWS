//
//  SYCategoryItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/12.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCategoryItem : NSObject
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger count;

//这个类对应的用户总数据
@property (nonatomic,strong) NSMutableArray *users;
//总数
@property (nonatomic,assign) NSInteger total;
//当前页码
@property (nonatomic,assign) NSInteger currentPage;
@end
