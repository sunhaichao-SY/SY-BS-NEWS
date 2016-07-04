//
//  SYSettingViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/5/16.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYSettingViewController.h"
#import <SDWebImage/SDImageCache.h>
#import "SYSettingItem.h"
#import "SYSettingGroupItem.h"
#import "SYSwitchSettingItem.h"
#import "SYSegmentedSettingItem.h"
#import "SYArrowSettingItem.h"
#import "SYSettingCell.h"

@interface SYSettingViewController ()
// 记录当前tableView的所有数组
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation SYSettingViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = SYCommonBgColor;
    
    //添加第一组
    [self setupGroup1];
    
    //添加第二组
    [self setupGroup2];
}

//添加第一组
- (void)setupGroup1
{
    SYSegmentedSettingItem *titleFond = [SYSegmentedSettingItem itemWithTitle:@"字体大小"];
    
    SYSwitchSettingItem *switchItem = [SYSwitchSettingItem itemWithTitle:@"摇一摇夜间模式"];
    
    SYSettingGroupItem *group = [SYSettingGroupItem groupWithItems:@[titleFond,switchItem]];
    group.headerTitle = @"功能设置";
    
    [self.groups addObject:group];
}

//第二组
- (void)setupGroup2{
    SYArrowSettingItem *clear = [SYArrowSettingItem itemWithTitle:@"清除缓存"];
    clear.itemOpertion = ^(NSIndexPath *indexPath){
        SYLogFunc
    };
    SYArrowSettingItem *recommend = [SYArrowSettingItem itemWithTitle:@"推荐给朋友"];
    SYArrowSettingItem *help = [SYArrowSettingItem itemWithTitle:@"帮助"];
    SYArrowSettingItem *versions = [SYArrowSettingItem itemWithTitle:@"当前版本：4.2"];
    SYArrowSettingItem *about = [SYArrowSettingItem itemWithTitle:@"关于我们"];
    SYArrowSettingItem *privacy = [SYArrowSettingItem itemWithTitle:@"隐私政策"];
    SYArrowSettingItem *sustain = [SYArrowSettingItem itemWithTitle:@"打分支持不得姐!"];
    
    SYSettingGroupItem *group1 = [SYSettingGroupItem groupWithItems:@[clear,recommend,help,versions,about,privacy,sustain]];
    group1.headerTitle = @"其他";
    
    [self.groups addObject:group1];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SYSettingGroupItem *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYSettingCell *cell = [SYSettingCell cellWithTableView:tableView style:UITableViewCellStyleValue1];
    
    //取出哪一组
    SYSettingGroupItem *group = self.groups[indexPath.section];
    
    //取出哪一行
    SYSettingItem *item = group.items[indexPath.row];
    
    //给cell传递模型
    cell.item = item;
    
    return cell;
}

//返回头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SYSettingGroupItem *group = self.groups[section];
    return group.headerTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //取出哪一组
    SYSettingGroupItem *group = self.groups[indexPath.section];
    
    //取出哪一行
    SYSettingItem *item = group.items[indexPath.row];
    
    //如果block有值则调用block方法
    if (item.itemOpertion) {
        item.itemOpertion(indexPath);
        return;
    }
}
@end
