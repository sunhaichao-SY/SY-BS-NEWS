//
//  SYConst.h
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/17.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    SYEssenceBaseTypeAll = 1,
    SYEssenceBaseTypePicture = 10,
    SYEssenceBaseTypeWord = 29,
    SYEssenceBaseTypeVioce = 31,
    SYEssenceBaseTypeVideo = 41
} SYEssenceBaseType;

//精华——顶部标题的高度
CGFloat const SYTitlesViewH;
//精华——顶部标题的Y
CGFloat const SYTitlesViewY;

//精华—Cell-间距
CGFloat const SYTopicCellMargin;
//精华—Cell-文字内容的Y值
CGFloat const SYTopicCellTextY;
//精华—Cell—底部工具条的高度
CGFloat const SYTopicCellButtonBarH;

//精华-Cell-图片帖子的最大高度
CGFloat const SYTopicCellPictureMaxH;
//精华—Cell-图片帖子一旦超过最大高度，就默认这个高度
CGFloat const SYTopicCellPictureBreakH;