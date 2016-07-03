//
//  SYRedStartCell.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/3.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYRedStartCell.h"
#import "UIImageView+WebCache.h"
#import "SYRedStartItems.h"
#import "SYHeaderItems.h"
@interface SYRedStartCell() 

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

@property (weak, nonatomic) IBOutlet UILabel *introView;


@property (weak, nonatomic) IBOutlet UIImageView *vipView;
@end

@implementation SYRedStartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.layer.cornerRadius = self.iconView.sy_width * 0.5;
    self.iconView.layer.masksToBounds = YES;
}

- (void)setRedStartItems:(SYRedStartItems *)redStartItems
{
    _redStartItems = redStartItems;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:redStartItems.header.big.firstObject] placeholderImage:[UIImage imageNamed:@"defaultTagIcon"]];
    
    self.nameView.text = redStartItems.name;
    self.introView.text = redStartItems.introduction;
    
    if (redStartItems.isVip) {
        self.vipView.hidden = NO;
    }else
    {
        self.vipView.hidden = YES;
    }

}

@end
