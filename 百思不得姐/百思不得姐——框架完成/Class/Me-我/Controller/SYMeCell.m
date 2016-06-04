//
//  SYMeCell.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/4.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYMeCell.h"
#import "SYMeItem.h"
#import "UIImageView+WebCache.h"

@interface SYMeCell() 
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation SYMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(SYMeItem *)item
{
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameView.text = item.name;
    
}
@end
