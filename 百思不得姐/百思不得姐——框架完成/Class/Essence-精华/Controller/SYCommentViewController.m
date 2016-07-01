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
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import "UIImageView+WebCache.h"
#import <AFNetworking/AFNetworking.h>
#import "SYTopCommentItem.h"
#import "SYCommentCell.h"

static NSString *const ID = @"cell";
static NSString *const HeaderID = @"header";
static NSString *const SYCommentURL = @"http://api.budejie.com/api/api_open.php?a=dataList&appname=bs0315&asid=4D9488FE-E59B-41A2-9323-AC3934759456&c=comment&client=iphone&data_id=19114235&device=ios%20device&from=ios&hot=1&jbk=0&mac=&market=&openudid=f1e1e75d11ec5e8a96503b30220f196e37759455&page=1&per=50&udid=&ver=4.2";

@interface SYCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
//底部搜索栏与View的下布局
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentConstraint;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//最热评论
@property (nonatomic,strong) NSArray *hotComment;

//最近评论
@property (nonatomic,strong) NSMutableArray *latestComment;

//保存帖子的top_cmt
@property (nonatomic,strong) NSArray *saved_top_cmt;
@end

@implementation SYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setBasic];
    
    //设置头部控件
    [self setupHeader];
    
    //加载网络请求
    [self setupLoadRefresh];
}
- (void)setBasic{
    
    self.tableView.backgroundColor = SYCommonBgColor;
    
    //设置导航条标题
    self.navigationItem.title = @"评论";
    
    //设置导航条左边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" selImage:@"comment_nav_item_share_icon_click" target:self action:nil];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYCommentCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    //通知，监听键盘的弹出控制输入框的位置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupHeader{
    
    UIView *header = [[UIView alloc] init];
    
    if (self.items.top_comment) {
        self.saved_top_cmt = self.items.top_comment;
        self.items.top_comment = nil;
        [self.items setValue:@0 forKey:@"cellHeight"];
    }
    
    
    SYWholeCell *wholeCell = [SYWholeCell WholeCell];
    wholeCell.textItems = self.items;
    wholeCell.sy_size = CGSizeMake(SYScreenW, self.items.cellHeight);
    [header addSubview:wholeCell];

    header.sy_height = self.items.cellHeight + 10;
    self.tableView.tableHeaderView = wholeCell;
    
}

- (void)setupLoadRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewsComment)];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewsComment
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [manager GET:SYCommentURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //最热评论模型
        self.hotComment = [SYTopCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.latestComment = [SYTopCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
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
    
    if (self.saved_top_cmt) {
        self.items.top_comment = self.saved_top_cmt;
//        self.items.top_comment = nil;
        [self.items setValue:@0 forKey:@"cellHeight"];
    }
    
}

//滚动TableView的时候键盘退下
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComment.count;
    NSInteger latestCount = self.latestComment.count;
    
    if (hotCount) {
        return 2;
    }else if (latestCount){
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComment.count;
    NSInteger latestCount = self.latestComment.count;
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    return latestCount;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    cell.topComment = [self commentsInIndexPath:indexPath];
    
    return cell;
}

- (NSArray *)commentsInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotComment.count ? self.hotComment : self.latestComment;
    }
    
    return self.latestComment;
}

- (SYTopCommentItem *)commentsInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
    UILabel *label = nil;
    
    if (header == nil) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HeaderID];
    
        header.contentView.backgroundColor = SYCommonBgColor;
    
        label = [[UILabel alloc] init];
        label.textColor = SYColor(67, 67, 67);
        label.sy_width = 200;
        label.sy_x = 10;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.tag = 10;
        [header.contentView addSubview:label];
    }else
    {
        label = (UILabel *)[header viewWithTag:10];
    }
    
    NSInteger hotCount = self.hotComment.count;
    if (section == 0) {
        label.text = hotCount ? @"最热评论" : @"最新评论";
    }else
    {
        label.text = @"最新评论";
    }
    return header;
}


@end
