//
//  SYSettingCell.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/4.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYSettingItem;
@interface SYSettingCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@property (nonatomic,strong) SYSettingItem *item;
@end
