//
//  SYWholeCell.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/9.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYWholeCell.h"
#import "SYTextItem.h"
#import "UIImageView+WebCache.h"

static CGFloat const margin = 10;
@interface SYWholeCell()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

//名字
@property (weak, nonatomic) IBOutlet UILabel *nameView;

//时间
@property (weak, nonatomic) IBOutlet UILabel *timeView;

//点赞
@property (weak, nonatomic) IBOutlet UIButton *zanView;

//踩
@property (weak, nonatomic) IBOutlet UIButton *caiView;

//分享
@property (weak, nonatomic) IBOutlet UIButton *shareView;

//转发
@property (weak, nonatomic) IBOutlet UIButton *commentView;

//内容
@property (weak, nonatomic) IBOutlet UILabel *textContent;

@end
@implementation SYWholeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImage;
    
    /*
    //设置cell的样式
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
     */
    
    self.iconView.layer.cornerRadius = (self.iconView.sy_width * 0.5);
    self.iconView.layer.masksToBounds = YES;
    
    
}

- (void)setTextItem:(SYTextItem *)textItem
{
    _textItem = textItem;
    
   
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:textItem.u[@"header"][0]] placeholderImage:[UIImage imageNamed:@"defaultTagIcon~iphone"]];
    self.nameView.text = textItem.u[@"name"];
    self.timeView.text = textItem.passtime;
    self.textContent.text = textItem.text;
    
    [self setupButtonTitle:self.zanView count:textItem.up placeholder:@"顶"];
    [self setupButtonTitle:self.caiView count:textItem.down placeholder:@"踩"];
    [self setupButtonTitle:self.shareView count:textItem.forward placeholder:@"分享"];
    [self setupButtonTitle:self.commentView count:textItem.comment placeholder:@"评论"];
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0)
    {
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
    
}

- (void)setFrame:(CGRect)frame
{
 
//    frame.origin.x = margin;
//    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];

}

@end
