//
//  SYSettingCell.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/4.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYSettingCell.h"
#import "SYArrowSettingItem.h"
#import "SYSwitchSettingItem.h"
#import "SYSegmentedSettingItem.h"

@interface SYSettingCell()
@property (nonatomic,strong) UIImageView *arrowView;
@property (nonatomic,strong) UISwitch *switchView;
@property (nonatomic,strong) UISegmentedControl *segmentedControl;

@end
@implementation SYSettingCell

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc]init];
    }
    return _segmentedControl;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style
{
    static NSString *ID = @"cell";
    SYSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SYSettingCell alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(SYSettingItem *)item
{
    _item = item;
    
    //设置控件上的内容
    [self setupData];

    //设置辅助视图
    [self setupAccessoyView];
}

- (void)setupData
{
    self.textLabel.text = _item.title;
}

- (void)setupAccessoyView{
    if ([_item isKindOfClass:[SYArrowSettingItem class]]) {
        //箭头
        self.accessoryView = self.arrowView;
        self.accessoryType = UITableViewCellSelectionStyleDefault;
    }else if([_item isKindOfClass:[SYSwitchSettingItem class]]){self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if ([_item isKindOfClass:[SYSettingItem class]]){
        self.accessoryView = self.segmentedControl;
        self.accessoryType = UITableViewCellSelectionStyleNone;
    }else
    {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryView = nil;
    }
}
@end
