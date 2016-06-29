//
//  SYEssenceBaseViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/6.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//  最基本的帖子内容

/****** 精华内容公共基类 ******/

#import "SYEssenceBaseViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"
#import "SYTextItem.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "SYWholeCell.h"
#import "SYCommentViewController.h"
static NSString *const ID = @"cell";


@interface SYEssenceBaseViewController ()
//帖子数据
@property (nonatomic,strong) NSMutableArray *textItems;
//当前页码
@property (nonatomic,assign) NSInteger page;
//当加载下一页数据是需要这个参数
@property (nonatomic,copy) NSNumber *np;
//上一次请求
@property (nonatomic,strong) NSDictionary *params;

@end

@implementation SYEssenceBaseViewController

//懒加载
- (NSMutableArray *)textItems
{
    if (_textItems == nil) {
        _textItems = [NSMutableArray array];
    }
    return _textItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化控件
    [self setupNavigationStyles];
    
    //添加刷新控件
    [self setupRefresh];
    
    
}
- (void)setupNavigationStyles
{
    //设置内容的TableView的尺寸在滚动栏下
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, self.tabBarController.tabBar.sy_height, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //取消TableView的分隔栏
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    self.tableView.showsVerticalScrollIndicator = NO;
    //背景颜色
    self.view.backgroundColor = SYCommonBgColor;
    
    //注册Xib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYWholeCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

//添加刷新控件
- (void)setupRefresh
{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //根据下拉的距离提示符自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //当已进入页面时自动下拉刷新
    [self.tableView.mj_header beginRefreshing];
    
    //上拉加载以前的数据
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}


//加载新的数据
- (void)loadNewData
{
    //开始刷新
    [self.tableView.mj_footer endRefreshing];
    
    //设置请求方式
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    self.params = params;

    [manager GET:_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (self.params != params) return;
        // 存储np
        self.np = responseObject[@"info"][@"np"];
       // 字典 -> 模型
        self.textItems = [SYTextItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        // 清空页码
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

- (void)loadMoreData
{
    
    [self.tableView.mj_header endRefreshing];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    NSInteger page = self.page + 1;
    paramas[@"page"] = @(page);
    paramas[@"np"] = self.np;
    self.params = paramas;
    
/*
 一直头痛的Bug总结
 因为这个项目的URL都是通过青花瓷抓取下来的，所以URL的格式有所不同，这个时候就需要仔细观察，看看URL之间有没有联系，或者有没有相同的地方。
 经过仔细对比和通过不同的抓取URL会发现在这个URL中改变数据的内容是通过-20之前那串数字，所以这个时候就可以运用字符串的拼接，首先截距变化前的内容然后在截取后面的内容，把中间改变的数值通过变量传进去，最后进行拼接即可。
 示例：
 
 http://d.api.budejie.com/topic/list/chuanyue/31/bs0315-iphone-4.2/0-20.json
 
 首先截取数字串到4.2/
 然后中间0属于变量，即通过 paramas[@"np"] 传入
 最后-20.json 属于共有的，所以最后拼接上即可
 
 */
    NSRange range = [_URL rangeOfString:@"4.2/"];
    NSString *preUrl = [_URL substringToIndex:range.location + 4];
    NSString *lastUrl = @"-20.json";
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",preUrl,self.np,lastUrl];
  
    
    [manager GET:url parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != paramas) return;
    
        self.np = responseObject[@"info"][@"np"];
        
        NSArray *newTopics = [SYTextItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       
        [self.textItems addObjectsFromArray:newTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
        self.page = page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != paramas) return;
        
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.textItems.count == 0);
    return self.textItems.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYWholeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textItems = self.textItems[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYTextItem *textItem = self.textItems[indexPath.row];
    
    return textItem.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYCommentViewController *commentView = [[SYCommentViewController alloc]init];
    commentView.items = self.textItems[indexPath.row];
    [self.navigationController pushViewController:commentView animated:YES];
}





@end