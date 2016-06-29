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
#import "SYVideoView.h"
#import "SYSoundsView.h"
#import "SYUItem.h"
#import "SYGIFItem.h"
#import "SYTopCommentItem.h"

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

//帖子中间图片内容
@property (nonatomic,weak) SYAllPictureView *pictureView;

//帖子中间音频的内容
@property (nonatomic,weak) SYSoundsView *soundsView;

//帖子中间视频的内容
@property (nonatomic,weak) SYVideoView *videoView;

//评论的内容
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;

//评论的背景
@property (weak, nonatomic) IBOutlet UIView *commentBJ;



@end
@implementation SYWholeCell

//图片Cell懒加载
- (SYAllPictureView *)pictureView
{
    if (_pictureView == nil) {
        SYAllPictureView *pictureView = [SYAllPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

//声音Cell懒加载
- (SYSoundsView *)soundsView
{
    if (_soundsView == nil) {
        SYSoundsView *soundsView = [SYSoundsView audioView];
        [self.contentView addSubview:soundsView];
        _soundsView = soundsView;
    }
    return _soundsView;
}

//视频Cell懒加载
- (SYVideoView *)videoView
{
    if (_videoView == nil) {
        SYVideoView *videoView = [SYVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}


- (void)awakeFromNib {
    
    //每个Cell的背景图片
    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImage;
    
    /*
    //设置cell的样式
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
     */
    
    //头像转变成圆形
    self.iconView.layer.cornerRadius = (self.iconView.sy_width * 0.5);
    self.iconView.layer.masksToBounds = YES;
    
    //自动调整子控件与父控件中间的位置，宽高.UIViewAutoresizingNone的意思是不自动调整。
    self.autoresizingMask = UIViewAutoresizingNone;
  
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
    
    //判断是否是Vip
    if (textItems.u.is_v) {
        self.XLVip.hidden = NO;
    }else{
        self.XLVip.hidden = YES;
    }
    
/******** 根据帖子类型添加对应的内容到cell的中间 ********/

    if ([textItems.type isEqualToString:@"image"]) {
        //image帖子
        //必须设置自己hidden为No，否则cell的循环利用可能会出现到自己的时候不显示的问题
        self.pictureView.hidden = NO;
        self.pictureView.textItems = textItems;
        self.pictureView.frame = textItems.pictureF;
        //当显示自己的时候要隐藏其他类型的数据
        self.videoView.hidden = YES;
        self.soundsView.hidden = YES;
    }else if ([textItems.type isEqualToString:@"gif"]){
        //gif帖子
        //必须设置自己hidden为No，否则cell的循环利用可能会出现到自己的时候不显示的问题
        self.pictureView.hidden = NO;
        self.pictureView.textItems = textItems;
        self.pictureView.frame = textItems.pictureF;
        //当显示自己的时候要隐藏其他类型的数据
        self.videoView.hidden = YES;
        self.soundsView.hidden = YES;
    }else if ([textItems.type isEqualToString:@"video"]){
        //video帖子
        //必须设置自己hidden为No，否则cell的循环利用可能会出现到自己的时候不显示的问题
        self.videoView.hidden = NO;
        self.videoView.textItem = textItems;
        self.videoView.frame = textItems.videoF;
        //当显示自己的时候要隐藏其他类型的数据
        self.pictureView.hidden =YES;
        self.soundsView.hidden =YES;
    }else if ([textItems.type isEqualToString:@"audio"]){
        //audio帖子
        //必须设置自己hidden为No，否则cell的循环利用可能会出现到自己的时候不显示的问题
        self.soundsView.hidden = NO;
        self.soundsView.textItem = textItems;
        self.soundsView.frame = textItems.soundF;
        //当显示自己的时候要隐藏其他类型的数据
        self.pictureView.hidden =YES;
        self.videoView.hidden = YES;
    }else{
        //text帖子
        self.pictureView.hidden = YES;
        self.soundsView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    //给评论内容赋值
    if (textItems.top_comment) {
        //如果有评论则评论不隐藏
        self.commentView.hidden = NO;
        //给评论赋值
        self.commentContentLabel.text = [NSString stringWithFormat:@"%@:%@",textItems.top_comment.u.name,textItems.top_comment.content];
    }
    
          //设置按钮文字
    [self setupButtonTitle:self.zanView count:textItems.up placeholder:@"顶"];
    [self setupButtonTitle:self.caiView count:textItems.down placeholder:@"踩"];
    [self setupButtonTitle:self.shareView count:textItems.forward placeholder:@"分享"];
    [self setupButtonTitle:self.commentView count:textItems.comment placeholder:@"评论"];
}

//抽取公共方法判断赞、评论等
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0)
    {
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
    
////    /**********用来设置段落的间距**********/
//  
//    //创建NSMutableAttributedString实例，并将text传入
//    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:_textContent.text];
//    //创建NSMutableParagraphStyle实例
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
//    //设置行距
//    [style setLineSpacing:12.0f];
//    
//    //根据给定长度与style设置attStr式样
//    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, _textContent.text.length)];
//    //Label获取attStr式样
//    _textContent.attributedText = attStr;
    
}

//设置Cell之间的距离
- (void)setFrame:(CGRect)frame
{
//    frame.origin.x = margin;
//    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    //必须下载后面否则无效
    [super setFrame:frame];
}



@end
