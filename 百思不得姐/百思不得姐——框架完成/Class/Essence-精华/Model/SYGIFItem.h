//
//  SYGIFItem.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/21.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYGIFItem : NSObject
/************ gif ************/

@property (nonatomic,strong) NSArray *download_url;

@property (nonatomic,strong) NSArray *gif_thumbnail;

@property (nonatomic,assign) NSInteger height;

@property (nonatomic,strong) NSArray *images;

@property (nonatomic,assign) NSInteger width;


@end
