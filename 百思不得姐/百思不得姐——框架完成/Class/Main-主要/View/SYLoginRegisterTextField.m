//
//  SYLoginRegisterTextFiled.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/22.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
// 因为登录和注册界面中TextField的出现次数较多，而且样式和颜色是统一的，所以我们新建一个继承TextField的类，把注册和登录界面中TextField的类型设置成该类名即可

//关于修改TextField中Placeholder文字的颜色除了运用KVC这个办法之外还可以运用代理，首先设置自己为自己的代理，然后调用其代理方法中的 - (void)textFieldDidBeginEditing:(UITextField *)textField; 和 - (void)textFieldDidEndEditing:(UITextField *)textField;根据其开始编辑和结束编辑进行相应设置。

#import "SYLoginRegisterTextField.h"

static NSString *const SYPlaceholderColor = @"placeholderLabel.textColor";

@implementation SYLoginRegisterTextField

- (void)awakeFromNib
{
    //设置TextField中文字光标的颜色
    self.tintColor = [UIColor whiteColor];
    self.textColor = [UIColor whiteColor];
    //设置TextField中placeHolder的颜色
    //第一种方法
    /*
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor grayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:dic];
     */
    //第二种方法
    //运用KVC修改私有属性，因为PlaceholderLabel属于TextField的私有属性不能直接修改，所以要用KVC进行修改。如何判断PlaceholderLabel属于TextField，即打印TextField里面的内容即可。
    [self setValue:[UIColor lightGrayColor] forKeyPath:SYPlaceholderColor];
//    [self setValue:[UIFont systemFontOfSize:14] forKey:@"placeholderLabel.font"];
   
    
    //因为TextField继承UIControl，所以可以调用addTag这个方法来监听TextField的改变
    //开始编辑时调用EditingDidBegin这个方法设置placeholder的颜色
    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    //结束编辑时调用EditingDidEnd这个方法修改placeholder中的文字
    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    //运用这个方法可以打印TextField里的子控件
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",self.subviews);
    });
     */
    
}

- (void)editingDidBegin
{
    [self setValue:[UIColor whiteColor] forKeyPath:SYPlaceholderColor];
}

- (void)editingDidEnd
{
    [self setValue:[UIColor lightGrayColor] forKeyPath:SYPlaceholderColor];
}
@end
