//
//  SYMeViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/16.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYMeViewController.h"
#import "SYSettingViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "SYMeItem.h"
#import <MJExtension/MJExtension.h>
#import "SYMeCell.h"


static NSInteger const cols = 4;
static CGFloat const margin = 1;
static NSString *const ID = @"cell";
#define cellH ((SYScreenW - (cols - 1) * margin) / cols)

@interface SYMeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *squareItems;
@property (nonatomic,weak) UICollectionView *collectionView ;

@end

@implementation SYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Navigation的样式
    [self setupNavigation];

    //设置每个TableView的间距
    [self setupTableViewSpacing];
    
    //设置底部View
    [self setupFootView];
    //加载数据
    [self loadData];

}
//http://d.api.budejie.com/op/square/bs0315-iphone-4.2/0-100.json
- (void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    [manager GET:@"http://d.api.budejie.com/op/square/bs0315-iphone-4.2/0-100.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSLog(@"%@",responseObject);
#warning 打印不出来plist
        [responseObject writeToFile:@"/Users/sunhaichao/Desktop/AD.plist" atomically:YES];
        
        NSArray *dictArr = responseObject[@"square_list"];
        
        _squareItems = [SYMeItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        NSUInteger rows = (_squareItems.count - 1) / cols + 1;
        CGFloat h = (rows * cellH) + (rows - 1) * margin;
        self.collectionView.sy_height = h;
        
        self.tableView.tableFooterView = self.collectionView;
        
        [self resolveData];
        
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)resolveData
{
    NSInteger count = _squareItems.count;
    NSInteger extre = count % cols;
    
    if (extre) {
        extre = cols - extre;
        
        for (int i = 0; i < extre; i++) {
            SYMeItem *item = [[SYMeItem alloc] init];
            [_squareItems addObject:item];
        }
    }
}
//设置按钮事件处理
- (void)settingItemClick
{
    SYSettingViewController *setting = [[SYSettingViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}
//月亮按钮事件处理
- (void)moonItemClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    SYLogFunc
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//设置Navigation的样式
- (void)setupNavigation
{
    
    //设置背景颜色
    self.view.backgroundColor = SYCommonBgColor;
    //设置navigationItem.title的标题
    self.navigationItem.title = @"我的";
    //设置右边两个按钮，调用UITabBarItem+SYCategory.h里面的类方法，可直接设置按钮样式
    //设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" target:self action:@selector(settingItemClick)];
    
    //设置月亮按钮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" selImage:@"mine-moon-icon-click" target:self action:@selector(moonItemClick:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];

}

//设置每个TableView的间距。理论:默认tableView只要是分组样式,默认每一组都有间距
- (void)setupTableViewSpacing
{
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

//设置底部的View

- (void)setupFootView
{
    //利用流水布局创建底部九宫格
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    flow.itemSize = CGSizeMake(cellH, cellH);
    flow.minimumInteritemSpacing = margin;
    flow.minimumLineSpacing = margin;
    
    //创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flow];
    collectionView.backgroundColor = SYCommonBgColor;
    _collectionView = collectionView;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"SYMeCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    self.tableView.tableFooterView = collectionView;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SYMeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = _squareItems[indexPath.row];
    
    return cell;
}
@end



















