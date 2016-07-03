//
//  SYFansCountViewCell.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/3.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYFansCountViewCell.h"
#import "UIImageView+WebCache.h"
#import "SYFansCountItem.h"
#import "SYHeaderItems.h"
@interface SYFansCountViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

@property (weak, nonatomic) IBOutlet UIImageView *vipView;
@property (weak, nonatomic) IBOutlet UILabel *fanCountsView;

@end

@implementation SYFansCountViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.layer.cornerRadius = self.iconView.sy_width * 0.5;
    self.iconView.layer.masksToBounds = YES;
}

- (void)setFansCount:(SYFansCountItem *)fansCount
{
    _fansCount = fansCount;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:fansCount.header.big.firstObject] placeholderImage:[UIImage imageNamed:@"defaultTagIcon"]];
    
    self.nameView.text = fansCount.name;
    self.fanCountsView.text = fansCount.fans_count;
    
    if (fansCount.isVip) {
        self.vipView.hidden = NO;
    }else
    {
        self.vipView.hidden = YES;
    }

}

@end
