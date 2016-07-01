//
//  SYCommentCell.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/1.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYCommentCell.h"
#import "UIImageView+WebCache.h"
#import "SYTopCommentItem.h"
#import "SYUserItems.h"
@interface SYCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UIImageView *SexImage;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

@property (weak, nonatomic) IBOutlet UILabel *textView;

@property (weak, nonatomic) IBOutlet UILabel *likeCountView;

@end
@implementation SYCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.layer.cornerRadius = (self.iconView.sy_width * 0.5);
    self.iconView.layer.masksToBounds = YES;
//    self.iconView.layer.cornerRadius = (self.iconView.sy_width * 0.5);
//    self.iconView.layer.masksToBounds = YES;
}

-(void)setTopComment:(SYTopCommentItem *)topComment
{
    _topComment = topComment;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:topComment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultTagIcon"]];
    self.SexImage.image = [topComment.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.textView.text = topComment.content;
    self.nameView.text = topComment.user.username;
    self.likeCountView.text = topComment.like_count;
}
@end
