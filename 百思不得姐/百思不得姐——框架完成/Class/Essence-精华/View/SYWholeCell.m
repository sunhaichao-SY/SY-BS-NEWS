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
#import "SYAllPictureView.h"
#import "SYUItem.h"

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

//vip
@property (weak, nonatomic) IBOutlet UIImageView *XLVip;

//帖子中间的内容
@property (nonatomic,weak) SYAllPictureView *pictureView;

@end
@implementation SYWholeCell

- (SYAllPictureView *)pictureView
{
    if (_pictureView == nil) {
        SYAllPictureView *pictureView = [SYAllPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    
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

- (void)setTextItems:(SYTextItem *)textItems
{
    _textItems = textItems;
    
   //设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:textItems.u.header.firstObject] placeholderImage:[UIImage imageNamed:@"defaultTagIcon~iphone"]];
    
    //设置名字
    self.nameView.text = textItems.u.name;
    
    //设置帖子的创建
    self.timeView.text = textItems.passtime;
    
    // 设置帖子的文字内容
    self.textContent.text = textItems.text;
    
    //vip
    if (textItems.u.is_v) {
        self.XLVip.hidden = NO;
    }else{
        self.XLVip.hidden = YES;
    }
    
    //根据模型类型（帖子类型）添加对应的内容到cell的中间
    
    if (textItems.type == SYEssenceBaseTypePicture) {
        //图片帖子
        self.pictureView.textItems = textItems;
        self.pictureView.frame = textItems.pictureF;
    }else if (textItems.type == SYEssenceBaseTypeVioce){
        //声音帖子
    }
    
    
      //设置按钮文字
    [self setupButtonTitle:self.zanView count:textItems.up placeholder:@"顶"];
    [self setupButtonTitle:self.caiView count:textItems.down placeholder:@"踩"];
    [self setupButtonTitle:self.shareView count:textItems.forward placeholder:@"分享"];
    [self setupButtonTitle:self.commentView count:textItems.comment placeholder:@"评论"];
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
    
    /**********用来设置段落的间距**********/
  
    //创建NSMutableAttributedString实例，并将text传入
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:_textContent.text];
    //创建NSMutableParagraphStyle实例
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    //设置行距
    [style setLineSpacing:12.0f];
    
    //根据给定长度与style设置attStr式样
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, _textContent.text.length)];
    //Label获取attStr式样
    _textContent.attributedText = attStr;

    
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
