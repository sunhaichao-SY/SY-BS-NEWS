//
//  SYTextItem.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/8.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYTextItem.h"
#import "NSDate+SYExtension.h"
#import <MJExtension/MJExtension.h>
#import "SYUItem.h"
@implementation SYTextItem
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}


- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * SYTopicCellMargin, MAXFLOAT);
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        //cell的高度
        //文字部分的高度
        _cellHeight = SYTopicCellTextY + textH + SYTopicCellMargin;
//        SYEssenceBaseTypePicture
        //根据段子的类型来计算cell的高度
        if (self.type == SYEssenceBaseTypePicture) {//图片帖子
            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat imageH =  self.image.height;
            CGFloat imageW = self.image.width;
            CGFloat pictureH = pictureW * imageH / imageW;
            
            if (pictureH >= SYTopicCellPictureMaxH) { //图片过长
                pictureH = SYTopicCellPictureBreakH;
                self.bigPicture = YES;//大图
            }
            
            //计算图片控件的frame
            CGFloat pictureX =SYTopicCellMargin;
            CGFloat pictureY = SYTopicCellTextY + textH + SYTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY , pictureW, pictureH);
            
            _cellHeight += pictureH +SYTopicCellMargin;
        }else if (self.type == SYEssenceBaseTypeVioce){
            //声音帖子
        }
        //底部工具条
        _cellHeight += SYTopicCellButtonBarH + SYTopicCellMargin;
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
