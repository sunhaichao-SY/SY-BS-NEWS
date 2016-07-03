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
@property (nonatomic,strong) SYTopCommentItem *saved_top_cmt;

//请求管理者
@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation SYCommentViewController

//用到时使用
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setBasic];
    
    //设置头部控件
    [self setupHeader];
    
    //加载网络请求
    [self setupLoadRefresh];
}

//设置导航栏内容
- (void)setBasic{
    
    //设置背景色
    self.tableView.backgroundColor = SYCommonBgColor;
    
    //设置导航条标题
    self.navigationItem.title = @"评论";
    
    //设置导航条左边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" selImage:@"comment_nav_item_share_icon_click" target:self action:@selector(shareBtn)];
    
    //注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYCommentCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    //估算高度
    self.tableView.estimatedRowHeight = 44;
    
    //自动计算尺寸
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    //通知，监听键盘的弹出控制输入框的位置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //评论加载完之后，tableView的下端与输入框之间的距离
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
}

//设置头部控件
- (void)setupHeader{
    
    //对Cell进行一层包装，可以控制尺寸变形
    UIView *header = [[UIView alloc] init];
    
    //清空top_comment 点击Cell跳入下个页面之后，在cell中会取消最热评论
    if (self.items.top_comment) {
        self.saved_top_cmt = self.items.top_comment;
       self.items.top_comment = nil;
        [self.items setValue:@0 forKey:@"cellHeight"];
    }
    
    //添加Cell
    SYWholeCell *wholeCell = [SYWholeCell WholeCell];
    wholeCell.textItems = self.items;
    wholeCell.sy_size = CGSizeMake(SYScreenW, self.items.cellHeight);
    [header addSubview:wholeCell];
    //header的高度
    header.sy_height = self.items.cellHeight;

    //设置header
    self.tableView.tableHeaderView = header;
    
}

//加载网络数据信息
- (void)setupLoadRefresh
{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewsComment)];
    //设置这个可以一进入页面就刷新
    [self.tableView.mj_header beginRefreshing];
    
    //上啦刷新加载之前的数据
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    //设置这个可以上啦刷新加载完成之后把刷新控件进行隐藏
    self.tableView.mj_footer.hidden = YES;
}

//加载新的数据
- (void)loadNewsComment
{
    //设置这段代码的意义在于，当我们下拉或者上拉加载到一半时突然进行其他的操作可以撤销正在进行的操作
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //设置请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //这个参数的意思是可以确定需要查看哪个Cell的评论内容
    parameters[@"data_id"] = self.items.ID;
    
    //拼接URL
    NSRange range = [SYCommentURL rangeOfString:@"_id="];
    NSString *preUrl = [SYCommentURL substringToIndex:range.location + 4];
    NSString *lastUrl = @"&device=ios%20device&from=ios&hot=1&jbk=0&mac=&market=&openudid=f1e1e75d11ec5e8a96503b30220f196e37759455&page=1&per=50&udid=&ver=4.2";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",preUrl,self.items.ID,lastUrl];
    
    //请求数据
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //最热评论模型
        self.hotComment = [SYTopCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论模型
        self.latestComment = [SYTopCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //加载完数据之后需要刷新一下tableView
        [self.tableView reloadData];
        
        //加载完数据，刷新完tableView之后需要停止下拉刷新
        [self.tableView.mj_header endRefreshing];
        
        //从数据中查看total这个数值的数据，因为这个数值代表的评论数一共有多少
        NSInteger total = [responseObject[@"total"] integerValue];
        
        //当我们加载的评论的个数大于或者等于数据里一共存有的评论数时，隐藏底部加载完数据的文字
        if (self.latestComment.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //加载失败也要隐藏下拉刷新按钮
        [self.tableView.mj_header endRefreshing];
    }];
}

//加载更多以前的数据
- (void)loadMoreComments
{
    
    //设置这段代码的意义在于，当我们下拉或者上拉加载到一半时突然进行其他的操作可以撤销正在进行的操作
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //设置请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
     //这个参数的意思是可以确定需要查看哪个Cell的评论内容
    parameters[@"data_id"] = self.items.ID;
    
    //从加载进来的评论数据中取出最后一个值，根据最后一个值得ID进行判断是佛还有数据，如果有就继续加载
    SYTopCommentItem *cmt = [self.latestComment lastObject];
    parameters[@"lastcid"] = cmt.ID;
    
    //拼接URL
    NSRange range = [SYCommentURL rangeOfString:@"_id="];
    NSString *preUrl = [SYCommentURL substringToIndex:range.location + 4];
    NSString *lastUrl = @"&device=ios%20device&from=ios&hot=1&jbk=0&mac=&market=&openudid=f1e1e75d11ec5e8a96503b30220f196e37759455&page=1&per=50&udid=&ver=4.2";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",preUrl,self.items.ID,lastUrl];
    
    //发送请求
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //因为我们上拉的时候只是加载最新评论里的数据，所以没有最热评论的信息
        //最新评论，把加载出来的最新评论放在一个数组中，加入统一的latestComment数据中
        NSArray *newComment = [SYTopCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //加入latestComment数据中
        [self.latestComment addObjectsFromArray:newComment];
        
        //加载完数据进行刷新tableView
        [self.tableView reloadData];
        
        //当我们加载的评论的个数大于或者等于数据里一共存有的评论数时，隐藏底部加载完数据的文字，如果一进来就加载完所有的数据就直接隐藏加载完成的信息
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComment.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        }else
        {
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //失败也要隐藏上啦刷新
        [self.tableView.mj_footer endRefreshing];
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
    
    // 恢复帖子的top_cmt，在进入评论页面的时候先把主页面上的评论热点保存在一个模型中，然后在评论的页面里把热点的Cell高度变成0，当退出评论页面时再从模型中取出来赋值展示在一开始的页面
    if (self.saved_top_cmt) {
        self.items.top_comment = self.saved_top_cmt;
        [self.items setValue:@0 forKey:@"cellHeight"];
    }
    
    //当页面消失时，取消所有的请求
    [self.manager invalidateSessionCancelingTasks:YES];
    
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
    
    tableView.mj_footer.hidden = (latestCount == 0);
    
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


//设置头部内容
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
        label.font = [UIFont systemFontOfSize:14];
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.tag = 10;
        [header.contentView addSubview:label];
    }else
    {
        label = (UILabel *)[header viewWithTag:10];
    }
    
    
    NSInteger hotCount = self.hotComment.count;
    
    //如果最热评论有值就选择 @"最热评论"
    if (section == 0) {
        label.text = hotCount ? @"最热评论" : @"最新评论";
    }else
    {
        label.text = @"最新评论";
    }
    return header;
}

- (void)shareBtn{
    SYLogFunc
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
        //被点击的Cell
        SYCommentCell *cell = (SYCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        //第一响应者
        [cell becomeFirstResponder];
        
        //显示UIMenuController
        
        UIMenuItem *ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding,replay,report];
        CGRect rect = CGRectMake(0, cell.sy_height * 0.5, cell.sy_width, cell.sy_height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
        }
}

- (void)ding:(UIMenuController *)menu{
    SYLogFunc
}

- (void)replay:(UIMenuController *)replay
{
    SYLogFunc
}

-(void)report:(UIMenuController *)menu{
    SYLogFunc
}
@end
