//
//  SYFansFastestCell.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/3.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYFansFastestCell.h"
#import "UIImageView+WebCache.h"
#import "SYFansFastestItems.h"
#import "SYHeaderItems.h"
@interface SYFansFastestCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

@property (weak, nonatomic) IBOutlet UIImageView *vipView;
@property (weak, nonatomic) IBOutlet UILabel *fanCountsView;

@end

@implementation SYFansFastestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.layer.cornerRadius = self.iconView.sy_width * 0.5;
    self.iconView.layer.masksToBounds = YES;
}

- (void)setFansFastest:(SYFansFastestItems *)fansFastest
{
    _fansFastest = fansFastest;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:fansFastest.header.big.firstObject] placeholderImage:[UIImage imageNamed:@"defaultTagIcon"]];
    
    self.nameView.text = fansFastest.name;
    self.fanCountsView.text = fansFastest.fans_add_yesterday;
    
    if (fansFastest.isVip) {
        self.vipView.hidden = NO;
    }else
    {
        self.vipView.hidden = YES;
    }

}

@end
