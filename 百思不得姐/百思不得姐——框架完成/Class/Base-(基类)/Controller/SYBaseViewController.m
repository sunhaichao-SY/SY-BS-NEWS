//
//  SYBaseViewController.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/6.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//  精华和最新控制器的基类，只要继承这个类就会有相同的效果

#import "SYBaseViewController.h"


//定义标识
static NSString *const ID = @"cell";

@interface SYBaseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
//定义一个顶部标题背景属性
@property (nonatomic,weak) UIScrollView *topView;
//用来存放顶部标题按钮
@property (nonatomic,strong) NSMutableArray *titleBtns;
//顶部标题下划线
@property (nonatomic,weak) UIView *underLine;
//选中按钮
@property (nonatomic,weak) UIButton *selectButton;
//底部内容
@property (nonatomic,weak) UICollectionView *collection;

@property (nonatomic,assign) BOOL isInitial;

@end

@implementation SYBaseViewController

//懒加载
- (NSMutableArray *)titleBtns
{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置底部内容View
    [self setupBottomContentView];
    
    //设置顶部文字标题
    [self setupTopTitleView];
    
    //取消系统默认的64间距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isInitial == NO) {
        //显示头部标题
        [self setupAllTitle];
        
        _isInitial = YES;
    }
    
}
//设置顶部文字标题
- (void)setupTopTitleView
{
    //创建顶部标题，因为标题可以滚动所以用UIScrollView创建
    UIScrollView *topView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SYScreenW, 35)];
    
    //给UIScrollView设置背景图片
    UIImage *image = [UIImage imageNamed:@"navigationbarBackgroundWhite"];
    [topView setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
    _topView = topView;
    
    //把ScrollView添加到当前View上
    [self.view addSubview:topView];
}

//设置底部内容View
- (void)setupBottomContentView
{
    //运用UICollectionView，因为UICollectionView默认具有循环引用的功能，在UICollectionView上添加UItableView
    
    //要想使用UICollectionView必须设置其模式为流水布局模式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //因为底部view可以穿透导航栏所以设置其尺寸跟屏幕一样大小
    flowLayout.itemSize = CGSizeMake(SYScreenW, SYScreenH);
    
    //设置UICollectionView在什么方向可以滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置UICollectionView每个Cell之间的间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    //创建UICollectionView
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:collection];
    
    _collection = collection;
    
    //分页
    collection.pagingEnabled = YES;
    //取消滑动提示栏
    collection.showsHorizontalScrollIndicator = NO;
    //取消弹簧效果
    collection.bounces = NO;
    
    //设置代理和数据源
    collection.dataSource = self;
    collection.delegate = self;
    
    //UICollectionView必须使用注册的方式设置ID
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

// 只要有新的cell出现的时候才会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 只要有新的cell出现,就把对应的子控制器的view添加到新的cell上
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 移除之前子控制器view
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 取出对应的子控制器添加到对应cell上
    UIViewController *vc = self.childViewControllers[indexPath.row];
    vc.view.frame = CGRectMake(0, 0, SYScreenW,SYScreenH);
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

// 滚动完成的时候就会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i = scrollView.contentOffset.x / SYScreenW;
    
    UIButton *selButton = self.titleBtns[i];
    
    [self selButton:selButton];
}

//设置所有标题
- (void)setupAllTitle
{
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = SYScreenW / _topTitleBtn;
    CGFloat btnX;
    CGFloat btnH = _topView.sy_height;
    
    for (int i = 0; i < count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.tag = i;
        
        UIViewController *vc = self.childViewControllers[i];
        [titleBtn setTitle:vc.title forState:UIControlStateNormal];
        
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
        btnX = i * btnW;
        titleBtn.frame = CGRectMake(btnX, 0, btnW, btnH);
        
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:titleBtn];
        
        //设置按钮底部小线条
        if (i == 0) {
            
            CGFloat h = 3;
            CGFloat y = titleBtn.sy_height - h;
            UIView *underLine = [[UIView alloc]init];
            underLine.sy_centerX = titleBtn.sy_centerX ;
            underLine.sy_x = 20;
            underLine.sy_height = h;
            [titleBtn.titleLabel sizeToFit];
            underLine.sy_width = titleBtn.titleLabel.sy_width * 1.3;
            underLine.sy_y = y;
            underLine.backgroundColor = [UIColor redColor];
            
            
            _underLine = underLine;
            [_topView addSubview:underLine];
            [self titleClick:titleBtn];
            
        }
        //默认选中第一个按钮
        [self.titleBtns addObject:titleBtn];
    }
    
    self.topView.contentSize = CGSizeMake(count * btnW, 0);
    self.topView.showsHorizontalScrollIndicator = NO;
}
//更改选中标题按钮
- (void)selButton:(UIButton *)titleBtn
{
    //按钮默认大小
    _selectButton.transform = CGAffineTransformIdentity;
    
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //按钮居中显示:本质修改titleScrollView的contentOffsetX
    CGFloat offsetX = titleBtn.center.x - SYScreenW * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    CGFloat MaxOffserX = self.topView.contentSize.width - SYScreenW;
    if (offsetX > MaxOffserX) {
        offsetX = MaxOffserX;
    }
    
    
    [self.topView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    // 设置标题缩放，如果不写这句代码，再次点计算中按钮之后，该按钮会恢复成原来的样子
    titleBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    _selectButton = titleBtn;
    
    [UIView animateWithDuration:0.25 animations:^{
        _underLine.sy_centerX = titleBtn.sy_centerX;
    }];
    
}

//点击标题
- (void)titleClick:(UIButton *)titleBtn
{
    
    NSInteger i = titleBtn.tag;
    [self selButton:titleBtn];
    CGFloat offsetX = i * SYScreenW;
    _collection.contentOffset = CGPointMake(offsetX, 0);
    
   
}

//正在滚动的时候调用用来改变文字颜色和大小
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //因为我们滚动的时候需要变换前一个按钮和后一按钮的样式，所以我们先确定索引
    //设置前一个按钮的索引
    NSInteger leftI = scrollView.contentOffset.x / SYScreenW;
    //设置后一个按钮的索引
    NSInteger rightI =leftI + 1;
    
    //根据索引取出对应的按钮
    UIButton *leftBTn = self.titleBtns[leftI];
    //以下方法是为了防止后一个按钮的索引越界而无法取出对应的按钮
    
    UIButton *rightBtn = nil;
    NSInteger count = self.titleBtns.count;
    if (rightI < count) {
        rightBtn = self.titleBtns[rightI];
    }
    
    //设置按钮文字的大小缩放
    CGFloat scaleR = scrollView.contentOffset.x / SYScreenW - leftI;
    CGFloat scaleL = 1 - scaleR;
    leftBTn.transform = CGAffineTransformMakeScale(scaleL * 0.2 + 1, scaleL * 0.2 + 1);
    rightBtn.transform = CGAffineTransformMakeScale(scaleR * 0.2 + 1, scaleR * 0.2 + 1);
    
    //设置按钮颜色的变化
    UIColor *colorR = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *colorL = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    
    [leftBTn setTitleColor:colorL forState:UIControlStateNormal];
    [rightBtn setTitleColor:colorR forState:UIControlStateNormal];
    
    //    按钮底部小条的滚动

//        _underLine.sy_centerX = scrollView.contentOffset.x * (SYScreenW / _topTitleBtn);
   
}
@end

