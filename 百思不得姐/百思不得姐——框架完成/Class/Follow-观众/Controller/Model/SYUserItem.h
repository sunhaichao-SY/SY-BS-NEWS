//
//  SYUserItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/12.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYUserItem : NSObject
@property (nonatomic,strong) NSString *header;
@property (nonatomic,assign) NSInteger fans_count;
@property (nonatomic,strong) NSString *screen_name;
@property (nonatomic,assign,getter=isVip) BOOL is_vip;
@end
