//
//  SYCaregroyCell.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/12.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYCaregroyCell.h"
#import "SYCategoryItem.h"

@interface SYCaregroyCell()
@property (weak, nonatomic) IBOutlet UIView *redView;

@end
@implementation SYCaregroyCell

- (void)setCategroy:(SYCategoryItem *)categroy
{
    _categroy = categroy;
    
    self.textLabel.text = categroy.name;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = SYCommonBgColor;
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
   
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.sy_height = self.contentView.sy_height - 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.redView.hidden = !selected;
    
    self.textLabel.textColor = selected ? [UIColor redColor] : [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    
    UIView *whiteColor = [[UIView alloc]init];
    whiteColor.backgroundColor = [UIColor whiteColor];
    
    UIView *grayColor = [[UIView alloc]init];
    grayColor.backgroundColor = SYCommonBgColor;

    self.selectedBackgroundView = selected ? whiteColor : grayColor;
   
}

@end
