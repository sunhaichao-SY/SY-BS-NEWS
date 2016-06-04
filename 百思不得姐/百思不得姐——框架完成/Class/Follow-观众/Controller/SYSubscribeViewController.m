//
//  SYSubscribeViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/3.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYSubscribeViewController.h"
#import "SYRecommendCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "SYRecommendItem.h"
#import <SVProgressHUD/SVProgressHUD.h>

//定义标识
static NSString *const ID = @"cell";

@interface SYSubscribeViewController ()
//模型数组
@property (nonatomic,strong) NSArray *recommendItem;
//定义属性
@property (nonatomic,weak) AFHTTPSessionManager *mgr;

@end

@implementation SYSubscribeViewController


//懒加载
- (NSArray *)recommendItem
{
    if (_recommendItem == nil) {
        _recommendItem = [NSArray array];
    }
    return _recommendItem;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //取消TableView侧滑栏
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //设置蒙版 防止加载时其他控件可点击
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在加载数据。。。"];

//    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
    //加载数据
    [self loadWeb];
    
    //取消TableView分隔栏样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //在TableView的头部添加一个搜索框
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SYScreenW, 44)];
    search.placeholder = @"搜索标签";
    self.tableView.tableHeaderView = search;
   
}


//加载数据
- (void)loadWeb
{
    
    //    //自定义SVProgressHUD显示时背景颜色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];
    
    //创建请求者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    _mgr = mgr;
    
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    //发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"responseObject ==  %@",responseObject);
        //        [responseObject writeToFile:@"/Users/sunhaichao/Desktop/AD.plist" atomically:YES];
        
        //当请求完成后，隐藏指示器
        [SVProgressHUD dismiss];
        
        //将模型保存到数组中
        _recommendItem = [SYRecommendItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error == %@",error);
    }];
}

//设置控制器样式
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _recommendItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [SYRecommendCell SetupRecommendView];
    }
    
    cell.recommendItem = self.recommendItem[indexPath.row];
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

//当推荐关注页面即将消失是调用
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //隐藏指示器
    [SVProgressHUD dismiss];
    //取消所有的请求
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

//开始拖动的时候调用这个方法 取消键盘弹出
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

//设置每个组的头部标题的颜色和样式，但是设置完之后必须设置头部View的高度，否则显示不出来，但是这样设置之后滚动TableView的时候Section会停留，若想静止必须设置TableView的样式为Group
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SYScreenW, 30)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor= SYCommonBgColor;
    titleLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    
    titleLabel.text= @"四爷之推荐关注";
    [myView addSubview:titleLabel];
    return myView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}
@end
