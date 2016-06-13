//
//  SYRecommendViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/1.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYRecommendViewController.h"
#import "SYLoginRegisterViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import "SYCategoryItem.h"
#import "SYCaregroyCell.h"
#import "SYUserCell.h"
#import "SYUserItem.h"
#import <MJRefresh/MJRefresh.h>

#define SYSelectedCategory self.caregroyItems[self.caregroyView.indexPathForSelectedRow.row]

static NSString *const caregroyID = @"caregroyCell";
static NSString *const userID = @"userID";

@interface SYRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
//左侧分栏
@property (weak, nonatomic) IBOutlet UITableView *caregroyView;
//左侧数据
@property (nonatomic,strong) NSArray *caregroyItems;
//右侧分栏
@property (weak, nonatomic) IBOutlet UITableView *userView;

@property (nonatomic,strong) NSMutableDictionary *parameters;

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation SYRecommendViewController

//懒加载请求数据方式
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件的初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //加载左侧的类别数据
    [self loadCategories];
    
    
}

//加载左侧的类别数据
- (void)loadCategories
{
    
    //自定义SVProgressHUD显示时背景颜色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];
    
    //发送请求
    AFHTTPSessionManager *Manager = [AFHTTPSessionManager manager];
    [Manager GET:@"http://api.budejie.com/api/api_open.php?a=category&appname=bs0315&asid=4D9488FE-E59B-41A2-9323-AC3934759456&c=subscribe&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=f1e1e75d11ec5e8a96503b30220f196e37759455&udid=&ver=4.2" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回的JSON解析
        _caregroyItems = [SYCategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [_caregroyView reloadData];
        
        //默认选中首行,只有先刷新表格之后才能设置默认行
        [_caregroyView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        //让用户表格进入下拉刷新状态，当选中默认的类别行时，右侧用户数据也应该及时显示出来，所以当已进入这个页面时左侧已有默认行，那么右侧的数据显示时要给用户一种加载中的效果
        [self.userView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        
    }];
  
}

//控件初始化
- (void)setupTableView
{
    //标题名字
    self.navigationItem.title = @"推荐关注";

    //导航栏右侧按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_search_icon~iphone" hightImage:@"nav_search_icon_click~iphone" target:self action:@selector(searchBtn)];
#pragma mark - tableView样式
    //取消左侧分隔栏样式
    _caregroyView.separatorStyle = UITableViewCellSeparatorStyleNone;
  //取消右侧分隔栏样式
      _userView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //用户表格的行高
    _userView.rowHeight = 60;
    
    //注册
    //左侧注册
    [_caregroyView registerNib:[UINib nibWithNibName:NSStringFromClass([SYCaregroyCell class]) bundle:nil] forCellReuseIdentifier:caregroyID];
    //右侧注册
    [_userView registerNib:[UINib nibWithNibName:NSStringFromClass([SYUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    
    _userView.backgroundColor = SYCommonBgColor;
    _caregroyView.backgroundColor = SYCommonBgColor;
    
    //取消系统默认的高度，自己设置距离导航栏的高度
    self.automaticallyAdjustsScrollViewInsets = NO;
    _caregroyView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _userView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
  

}

//添加刷新控件，
- (void)setupRefresh
{
    //下拉时刷新数据
    self.userView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUser)];
    
    //上拉时刷新数据
    self.userView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    //进入页面的时候下拉刷新样式应该隐藏
    self.userView.mj_footer.hidden = YES;
}

//当用户下拉时会加载新的数据即刷新控件
- (void)loadNewUser
{
    //左侧选中按钮对应的模型
    SYCategoryItem *categroyItem = SYSelectedCategory;
    
    //设置当前页面为第一页
    categroyItem.currentPage = 1;
    
    //加载数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //此参数记录的右侧按钮的数据属于左侧哪个按钮，点击左侧按钮之后右侧内容会发生变化
    parameters[@"category_id"] = @(categroyItem.ID);
    
    //页数的变化
    parameters[@"page"] = @(categroyItem.currentPage);
    self.parameters = parameters;
    
    //加载数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php?a=friend_recommend&appname=bs0315&asid=4D9488FE-E59B-41A2-9323-AC3934759456&c=user&client=iphone&device=ios%20device&from=ios&jbk=0&last_coord=&last_flag=list&mac=&market=&openudid=f1e1e75d11ec5e8a96503b30220f196e37759455&pre=50&udid=&ver=4.2" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        //保存一个数组
        NSArray *users = [SYUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"top_list"]];
        
        //当加载新的数据时应该先删除之前的旧数据
        [categroyItem.users removeAllObjects];
        
        //把新的数据添加到用户总数中
        [categroyItem.users addObjectsFromArray:users];
        
        //记录右侧出现的数量一共有多少用来和总数进行判断
        categroyItem.total = [responseObject[@"total"] integerValue];
        
        //判断是否是最后一次请求
        if (self.parameters != parameters) return;
        
        //刷新
        [self.userView reloadData];
    
        //结束下拉刷新
        [self.userView.mj_header endRefreshing];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //判断是否是最后一次请求
        if (self.parameters != parameters) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        // 结束刷新
        [self.userView.mj_header endRefreshing];
    }];

}

//加载更多
- (void)loadMoreUsers
{
   //左侧选中按钮对应的模型
    SYCategoryItem *categroyItem = SYSelectedCategory;
    
    //加载数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"category_id"] = @(categroyItem.ID);
    
    //页数加1 新的数据会出现
    parameters[@"page"] = @(++categroyItem.currentPage);
    self.parameters = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php?a=friend_recommend&appname=bs0315&asid=4D9488FE-E59B-41A2-9323-AC3934759456&c=user&client=iphone&device=ios%20device&from=ios&jbk=0&last_coord=&last_flag=list&mac=&market=&openudid=f1e1e75d11ec5e8a96503b30220f196e37759455&pre=50&udid=&ver=4.2" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSArray *users = [SYUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"top_list"]];
        
         // 添加到当前类别对应的用户数组中
        [categroyItem.users addObjectsFromArray:users];
        
        
        // 不是最后一次请求
        if (self.parameters != parameters) return;
        
        // 刷新右边的表格
        [self.userView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parameters != parameters) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        
        // 让底部控件结束刷新
        [self.userView.mj_footer endRefreshing];
    }];
}

//根据footer的状态作出相应的变化
- (void)checkFooterState
{
    SYCategoryItem *categoryItem = SYSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userView.mj_footer.hidden = (categoryItem.users.count == 0);
    
    // 让底部控件结束刷新
    if (categoryItem.users.count == categoryItem.total) {
        
        //全部数据已经加载完毕
        [self.userView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        
        //还没有加载完毕
        [self.userView.mj_footer endRefreshing];
    }

}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _caregroyView) return self.caregroyItems.count;
    
    [self checkFooterState];
    
    return [SYSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _caregroyView) {
        SYCaregroyCell *cell = [tableView dequeueReusableCellWithIdentifier:caregroyID];
        cell.categroy = self.caregroyItems[indexPath.row];
        return cell;
    }else
    {
        SYUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userItem = [SYSelectedCategory users][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.userView.mj_header endRefreshing];
    [self.userView.mj_footer endRefreshing];
    
    SYCategoryItem *categoryItem = self.caregroyItems[indexPath.row];
    
    if (categoryItem.users.count) {
        [_userView reloadData];
    } else {
        
        [_userView reloadData];
        
        [self.userView.mj_header beginRefreshing];
        }
}

//导航栏右上角搜索按钮
- (void)searchBtn
{
    SYLoginRegisterViewController *login = [[SYLoginRegisterViewController alloc]init];
    [self.navigationController presentViewController:login animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _userView) {
        return 60;
    }
    return 44;
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}
@end