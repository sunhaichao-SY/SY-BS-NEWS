//
//  SYTextItem.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/8.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYTextItem.h"
#import "NSDate+SYExtension.h"
#import "SYUItem.h"
#import "SYGIFItem.h"
#import "SYVideoItem.h"
#import "SYAudioItem.h"

@implementation SYTextItem
{
    CGFloat _cellHeight;
}


- (CGFloat)cellHeight
{
    if (!_cellHeight) {

        /******** 段子的cell ********/
        //文字的最大尺寸
        //间距
        NSInteger margin = 10;

        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * margin, MAXFLOAT);
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil].size.height;

        //cell的高度
        //段子的高度
        _cellHeight = 40 + 2 * margin + textH;

       /******** 图片的cell ********/

        if ([self.type isEqualToString:@"image"]) {//图片帖子

            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat imageH =  self.image.height;
            CGFloat imageW = self.image.width;
            CGFloat pictureH = pictureW * imageH / imageW;

            if (pictureH >= 1000) { //图片过长
                pictureH = 250;
                self.bigPicture = YES;//大图
            }

            //计算图片控件的frame
            CGFloat pictureX =10;
            CGFloat pictureY = textH + 10 + 50;
            _pictureF = CGRectMake(pictureX, pictureY , pictureW, pictureH);

            _cellHeight += pictureH +10;
        } else if ([self.type isEqualToString:@"gif"]) {//图片帖子

            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat imageH =  self.gif.height;
            CGFloat imageW = self.gif.width;
            CGFloat pictureH = pictureW * imageH / imageW;


            //计算图片控件的frame
            CGFloat pictureX =10;
            CGFloat pictureY = textH + 50 + 10;
            _pictureF = CGRectMake(pictureX, pictureY , pictureW, pictureH);

            _cellHeight += pictureH +10;
            
        }else if ([self.type isEqualToString:@"video"]){
            CGFloat videoW = maxSize.width;
            
            CGFloat H = self.video.height;
            CGFloat W = self.video.width;
            
            CGFloat videoH = videoW * H / W;
            
            CGFloat videoX = 10;
            CGFloat videoY =textH + 50 + 10;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + 10;
        }else if ([self.type isEqualToString:@"audio"]){
            
            CGFloat audioW = maxSize.width;
            
            CGFloat H = self.audio.height;
            CGFloat W = self.audio.width;
            
            CGFloat audioH = audioW * H / W;
            
            CGFloat audioX = 10;
            CGFloat audioY = textH + 50 + 10;
            _soundF = CGRectMake(audioX, audioY, audioW, audioH);
            
            _cellHeight += audioH + 20;

        }
        
        //底部工具条
        _cellHeight += 44 + 10;
    }

    return _cellHeight;
}


/**************** 设置时间 ****************/
//-(NSString *)passtime
//{
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    
//    NSDate *create = [fmt dateFromString:_passtime];
//    
//    if (create.isThisYear) {
//        if (create.isToday) {
//            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
//            
//            if (cmps.hour >= 1) {
//                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
//            }else if (cmps.minute >= 1)
//            {
//                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
//            }else
//            {
//                return @"刚刚";
//            }
//        }else if (create.isYesterday){
//            fmt.dateFormat = @"昨天 HH:mm:ss";
//            return [fmt stringFromDate:create];
//        }else
//        {
//            fmt.dateFormat = @"MM-dd HH:mm:ss";
//            return [fmt stringFromDate:create];
//        }
//    }else
//    {
//        return _passtime;
//    }
//    
//    
//    
//    
//}
@end
