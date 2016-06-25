//
//  SYShowPictureViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/18.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYShowPictureViewController.h"
#import "SYTextItem.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "SYProgressView.h"
#import "UIImageView+WebCache.h"
#import "SYUItem.h"
#import "SYGIFItem.h"
#import "SYAudioItem.h"

@interface SYShowPictureViewController ()
@property (weak, nonatomic) IBOutlet SYProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) UIImageView *imageView;
@end

@implementation SYShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //添加图片
    UIImageView *imageView = [[UIImageView alloc]init];
    
    //设置图片能与用户交互
    imageView.userInteractionEnabled = YES;
    
    //给图片添加点击手势
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //图片尺寸
    CGFloat pictureW = SYScreenW;
    CGFloat pictureH;
    if ([_textItem.type isEqualToString:@"image"]) {
        pictureH = pictureW * self.textItem.image.height / self.textItem.image.width;
    }else if ([_textItem.type isEqualToString:@"gif"]){
        pictureH = pictureW * self.textItem.gif.height / self.textItem.gif.width;
    }else if ([_textItem.type isEqualToString:@"audio"]){
        pictureH = pictureW * self.textItem.audio.height / self.textItem.audio.width;
    }
    
    if (pictureH > SYScreenH) {//图片显示的高度超过一个屏幕，需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else
    {
        imageView.sy_size = CGSizeMake(pictureW, pictureH);
        imageView.sy_centerY = SYScreenH * 0.5;
    }
    
    //马上显示当前图片的下载进度
    [self.progressView setProgress:self.textItem.pictureProgress animated:YES];
    
    //下载图片
    NSString *url;
    if ([_textItem.type isEqualToString:@"image"]) {
        url = self.textItem.image.download_url.firstObject;
    }else if ([_textItem.type isEqualToString:@"gif"]){
        url = self.textItem.gif.images.firstObject;
    }else if ([_textItem.type isEqualToString:@"audio"]){
        url = self.textItem.audio.download_url.firstObject;
    }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并未下载完毕"];
        return;
    }
    
/**************** 将图片写入相册 ****************/
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}


@end
