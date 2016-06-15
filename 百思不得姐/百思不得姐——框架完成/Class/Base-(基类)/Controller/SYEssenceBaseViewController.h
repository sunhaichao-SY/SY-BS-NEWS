//
//  SYEssenceBaseViewController.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/9.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//  精华内容公共基类

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SYEssenceBaseTypeAll = 1,
    SYEssenceBaseTypePicture = 10,
    SYEssenceBaseTypeWord = 29,
    SYEssenceBaseTypeVioce = 31,
    SYEssenceBaseTypeVideo = 41
} SYEssenceBaseType;

@interface SYEssenceBaseViewController : UITableViewController

@property (nonatomic,assign) SYEssenceBaseType type;
@end
