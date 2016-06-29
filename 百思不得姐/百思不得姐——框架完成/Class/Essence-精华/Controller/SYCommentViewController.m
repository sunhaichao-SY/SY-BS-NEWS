//
//  SYCommentViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/29.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYCommentViewController.h"
#import "SYWholeCell.h"
#import "SYTextItem.h"


static NSString *const ID = @"cell";

@interface SYCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
//底部搜索栏与View的下布局
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentConstraint;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBasic];
    
    [self setupHeader];
}
- (void)setBasic{
    
    self.tableView.backgroundColor = SYCommonBgColor;
    
    //设置导航条标题
    self.navigationItem.title = @"评论";
    
    //设置导航条左边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" selImage:@"comment_nav_item_share_icon_click" target:self action:nil];
    
    
    //通知，监听键盘的弹出控制输入框的位置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupHeader{
    
    UIView *header = [[UIView alloc] init];
    SYWholeCell *wholeCell = [SYWholeCell WholeCell];
    wholeCell.textItems = self.items;
    wholeCell.sy_size = CGSizeMake(SYScreenW, self.items.cellHeight);

    [header addSubview:wholeCell];

       header.sy_height = self.items.cellHeight + 10;
    self.tableView.tableHeaderView = wholeCell;
    
}
//键盘弹出调用的方法
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.commentConstraint.constant = SYScreenH - frame.origin.y;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

//必须移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//滚动TableView的时候键盘退下
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"123";
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"标题";
}







@end
