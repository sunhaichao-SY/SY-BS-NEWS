//
//  SYUserCell.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/12.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYUserCell.h"
#import "SYUserItem.h"
#import "UIImageView+WebCache.h"
#import "SYLoginRegisterViewController.h"

@interface SYUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *countView;
@end

@implementation SYUserCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}
- (void)setUserItem:(SYUserItem *)userItem
{
    _userItem = userItem;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userItem.header] placeholderImage:[UIImage imageNamed:@"defaultTagIcon"]];
    self.nameView.text = userItem.screen_name;
    self.countView.text = [NSString stringWithFormat:@"%zd人关注",userItem.fans_count];
    
    if (userItem.is_vip) {
        self.nameView.textColor = [UIColor redColor];
        
    }else
    {
        self.nameView.textColor = [UIColor blackColor];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.layer.cornerRadius = self.iconView.sy_width * 0.5;
    self.iconView.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)recommendClick:(id)sender {
   SYLogFunc

}


@end
