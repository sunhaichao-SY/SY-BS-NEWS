//
//  SYVideoView.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/25.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYVideoView.h"
#import "SYTextItem.h"
#import "UIImageView+WebCache.h"
#import "SYVideoItem.h"
@interface SYVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeCount;
@end
@implementation SYVideoView

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:kNilOptions] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTextItem:(SYTextItem *)textItem
{
    _textItem = textItem;
    
    //加载图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:textItem.video.thumbnail.firstObject]];

    //播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",textItem.video.playcount];
     //设置时间格式
    NSInteger min = textItem.video.duration / 60;
    NSInteger sec = textItem.video.duration % 60;
    self.timeCount.text = [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
    
    
}
@end

