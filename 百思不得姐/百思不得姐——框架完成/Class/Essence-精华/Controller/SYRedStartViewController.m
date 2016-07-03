//
//  SYRedStartViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/3.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYRedStartViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import "SYRedStartItems.h"
#import "SYRedStartCell.h"

static NSString *const ID = @"redStars";

@interface SYRedStartViewController ()
@property (nonatomic,strong) NSArray *redStarts;
@end

@implementation SYRedStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYRedStartCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.rowHeight = 80;
    
    //取消TableView的分隔栏
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置内容的TableView的尺寸在滚动栏下
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, self.tabBarController.tabBar.sy_height, 0);
    
    [self reloadRefreshing];
}

- (void)reloadRefreshing{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET: SYRedStartURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.redStarts = [SYRedStartItems mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.redStarts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYRedStartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.redStartItems = self.redStarts[indexPath.row];
    
    return cell;
}

@end
