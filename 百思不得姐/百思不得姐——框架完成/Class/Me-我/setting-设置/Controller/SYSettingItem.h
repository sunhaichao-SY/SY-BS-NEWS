//
//  SYSettingItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/4.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYSettingItem : NSObject
//定义一个属性
@property (nonatomic,strong) NSString *title;

//提供一个接口，用来保存每一行cell的功能
@property (nonatomic,strong) void(^itemOpertion)(NSIndexPath *indexPath);

//提供一个类方法，方便调用
+ (instancetype)itemWithTitle:(NSString *)title;
@end
