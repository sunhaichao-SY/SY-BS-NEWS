//
//  SYAllPictureView.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/17.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYAllPictureView.h"
#import "SYProgressView.h"
#import "SYTextItem.h"
#import "UIImageView+WebCache.h"
#import "SYProgressView.h"
#import "SYShowPictureViewController.h"
@interface SYAllPictureView()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//gif标识
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
//查看大图按钮
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
//进度条控件
@property (weak, nonatomic) IBOutlet SYProgressView *progressView;


@end

@implementation SYAllPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass( self) owner:nil options:kNilOptions] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}


- (void)showPicture
{
    SYShowPictureViewController *showPicture = [[SYShowPictureViewController alloc]init];
    showPicture.textItem = self.textItem;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTextItem:(SYTextItem *)textItem
{
    _textItem = textItem;
    
    //立马显示最新的进度值(防止因为网速慢，导致显示的是其他图片的下载进度，说白了就是进度条的循环引用)
    [self.progressView setProgress:textItem.pictureProgress animated:NO];
#warning 图片URL未设置
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://dimg.spriteapp.cn/ugc/2016/06/16/576268e425f07_1.jpg" ]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        //进度值
        textItem.pictureProgress = 1.0 * receivedSize / expectedSize;
        //显示进度值
        [self.progressView setProgress:textItem.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        //如果是大图片，才要进行绘图处理
        if (textItem.isBigPicture == NO) return;
        
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(textItem.pictureF.size, YES, 0.0);
        
        //将下载完的image对象绘制到图形上下文中
        
        CGFloat wight = textItem.pictureF.size.width;
        CGFloat height = wight *image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, wight, height)];
        
        //获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
#warning 判断是否为gif
    
    
    //判断是否显示“点击查看全图”
    if (textItem.isBigPicture) {//大图
        self.seeBigButton.hidden = NO;
    }else{//非大图
        self.seeBigButton.hidden = YES;
        
    }
    
    
    
    
    
    
    
    
    
    
}






























@end
