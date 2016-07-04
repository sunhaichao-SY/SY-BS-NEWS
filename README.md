#四爷——仿写百思不得姐(最新版)

######首先先阐述一下该仿写百思这个APP的背景，年初开始一直看叶神的斗鱼直播，偶然间看到关于下厨房的视频，于是也开始打算模仿一个APP制作，一开始是准备打算模仿半糖，因为个人比较喜欢这个软件，然后上网搜了一下，发现这个半糖公司正好在上海，也就是我接下来要准备去找工作的地方，后来看了看半糖的APP发现有些地方还不太会于是就该仿写APP了。六月份开始准备，所有的数据都是通过青花瓷抓取下来的，网上包括教学机构虽然都有百思的文档，但我发现所有的文档在主页面只有五内容的数据，并且数据都是旧的，我通过自己最新抓取的数据和通过文档里给的数据对比了一下，发现数据格式是不一样的，所以为了锻炼一下水平就采取了最新的数据，其他内容如果需要做的话都需要用青花瓷去抓取，所以干脆所有的数据接口都用青花瓷来抓。从六月四号开始陆陆续续一直持续到七月四号，将近一个月的时间，参考了一些其他的代码，就这样坎坎坷坷写完了，过程中遇到很多bug，有时候一个bug可能因为思路不对好几天也解决不了，后来改变一下思路就发现其实特简单，在写代码的时候因为自己记性不好，所以每次遇到重点难点，或者解决好的bug的时候，我都会把注释写的清清楚楚，包括原因和解决方法。废话不多说，开始阐述一下我在做这个APP过程中的心得同时说一下这个APP中要理解的东西。
#####分三块研究：第一块，从整体出发，主要说该APP的主要概括。第二块，从各个模块出发分别说一下我在各个模块中遇到的问题以及各个模块中的重要点。第三块，局部东西，零零散散的注意点。如有不足，请多指教。

##整体
#####当你第一时间想仿写一个APP的时候你不要着急去布局去抓取数据，你首先要先观察这个APP的整体结构，整体逻辑，以及各个板块之间的联系和构造，然后再根据你自己的经验去画草图，在草图中简要的标注一下各个界面的实现方式和需要用到的控件。
#####我们先看下百思的整体结构

<img src="http://ww4.sinaimg.cn/mw690/7306bf8agw1f5i8llx3nsj20ku11247i.jpg" width="30%" height="30%">
<img src="http://ww2.sinaimg.cn/mw690/7306bf8agw1f5i8ll1vr1j20ku112tje.jpg" width="30%" height="30%">
<img src="http://ww4.sinaimg.cn/mw690/7306bf8agw1f5i8lo2rocj20ku112q9z.jpg" width="30%" height="30%">
<img src="http://ww2.sinaimg.cn/mw690/7306bf8agw1f5i8lp4j0vj20ku112adf.jpg" width="30%" height="30%">

#####通过各个页面的和对比我们会发现，上部导航栏和底部tabbar是固定的，只是中间部分是不同的。
#####我们先看一下导航栏和底部tabbar

<img src="http://ww4.sinaimg.cn/mw690/7306bf8agw1f5i8lreod8j20pi16y79a.jpg" width="30%" height="30%">

#####顶部导航拦中间有的是图片有的是文字，两边都是按钮，这个实现很简单。

<img src="http://ww1.sinaimg.cn/mw690/7306bf8agw1f5i8lsayeuj20kk02sq2x.jpg" width="30%" height="30%">

<img src="http://ww2.sinaimg.cn/mw690/7306bf8agw1f5i8lslvw7j20km02cdg2.jpg" width="30%" height="30%">

<img src="http://ww4.sinaimg.cn/mw690/7306bf8agw1f5i8lswlc8j20ke01yglu.jpg" width="30%" height="30%">

<img src="http://ww2.sinaimg.cn/mw690/7306bf8agw1f5i8lt4r6jj20kk028glk.jpg" width="30%" height="30%">

<img src="http://ww4.sinaimg.cn/mw690/7306bf8agw1f5i8ltxwvej212m0e0n1q.jpg" width="70%" height="70%">

#####再来看一下底部，我们会发现底部中间有个按钮和其他按钮是不同的这个时候我们有两种方法来解决这个问题。
#####第一种需要自定义tabbar
#####这里我继承了UIView实现了一个自定义tabbar的效果，修改里面tabBarItem的位置



```objc
	//重新布局TabBar
	- (void)layoutSubviews
	{

    [super layoutSubviews];
    
    //标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    CGFloat width = self.sy_width;
    CGFloat height = self.sy_height;
    
    // 设置发布按钮的frame
    _publishButton.center = CGPointMake(width * 0.5, height * 0.5 + 2);
    _publishButton.sy_height = height;
    _publishButton.sy_width = width;
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    //因为在这里里面需要设置button的监听 如果是view *button 那么就不会提示addtag这个方法
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 增加索引
        index++;
        if (added == NO) {
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    added = YES;
	}	
```

#####第二种空出一个tabbarItem的位置，把这个按钮放在这个空出来的tabbarItem上。
#####通过对比我们会发现精华和最新页面中间部分是相同的，在导航栏下都有一个scrollView，只是里面的数据和中间tableView展示的数据不一样。

<img src="http://ww1.sinaimg.cn/mw690/7306bf8agw1f5i8lv992cj20ka0umaoe.jpg" width="30%" height="30%">  
<img src="http://ww3.sinaimg.cn/mw690/7306bf8agw1f5i8lvrpcdj20kq0uk448.jpg" width="30%" height="30%">

#####那么我们就可以理解为，精华页面和最新页面的结构大致一样，这个时候我们就可以抽取一个基类SYBaseViewController.h 

<img src="http://ww1.sinaimg.cn/mw690/7306bf8agw1f5i8lxarv4j20bg06sab8.jpg" width="30%" height="30%">

#####然后让这两个模块的控制器分别继承这个基类，那么这样就可以拥有相同的效果。
#####所谓基类就是把相同的代码抽取出来，然后让其他控制器继承于它，这样一下就可以实现基类里所展示的效果。
#####精华和最新的界面的结构确定下来之后就是里面tableView的设置，我们观察图片会发现当我们控制器是可以左右滑动的，而且每个控制器有可以上下滑动。这个时候我们会想到scrollView和UICollectionView以及tableView的使用，根据对各个控件的了解UICollectionView它是自带循环利用功能的，所以我们采取UICollectionView加tableView的方法创建，首先采取UICollectionView的流水布局确定左右可以滑动，然后在添加上tableView，就可以实现左右和上下的滑动了。在这需要注意的是如果用UICollectionView那么就必须设置流水布局。但是这里我们必须取消系统自带的滑动功能，并添加滑动手势


```objc
	//让控制器作为NavigationBar的手势处理代理对象
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    
    //如果滑动移除控制器的功能失效，则清空即可
    self.interactivePopGestureRecognizer.enabled = NO;
```
    
 #####在导航栏下会有一行标题，这个标题是可以左右滑动的，我采取的是UIScrollView，里面利用for循环加添对应数量的Button

```objc

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
            
            CGFloat h = 2;
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
```


##各个模块
###精华模块
#####这里着重说一下像这种不定义等高的cell是如何创建的。我们可以先把每个cell中固定不变的控件通过xib创建出来，然后把那些随即改变的控件通过动态的方式添加上去。我们可以看一下，每个cell中都有的控件如下（除了最热评论）

<img src="http://ww2.sinaimg.cn/mw690/7306bf8agw1f5i8m1q3vqj20le0euwfj.jpg" width="70%" height="70%">

#####其他的控件都是需要通过xib创建然后动态加入到cell中，这个地方我在代码的注释中写的很详细，仔细看一下我代码精华模块中view和model两部分的代码，其实很简单，就是分别把不同的部分用xib先确定下来，然后在模型中设置cell高度的同时添加进去即可。这部分属于该APP中的一个重中之重，这一块需要理解透彻才好。

<img src="http://ww4.sinaimg.cn/mw690/7306bf8agw1f5i8m16usrj20ag0jaacm.jpg" width="30%" height="30%">

#####当我们点击cell可以跳转到评论页面，我们观察评论页面顶部的整体cell是从主页面直接传进去的不是通过网络加载的，这个时候我们就需要把主页面的cell的模型整体传过去，然后下面通过自定义cell就可以了。
<img src="http://ww1.sinaimg.cn/mw690/7306bf8ajw1f5iark4awcj20fm0rswmx.jpg" width="30%" height="30%">
<img src="http://ww2.sinaimg.cn/mw690/7306bf8ajw1f5iarrit5yj20fm0rs42e.jpg" width="30%" height="30%">
###最新
#####最新页面和精华页面的布局基本上是一样的这个时候我们可以把中间的逻辑代码抽取一个基类SYEssenceBaseViewController.h，然后让精华和最新的控制器都继承这个基类，那么效果是一样的，需要做的就是根据不同的界面传入不同的URL。
###关注
#####关注页面相对于还是很简单的，上面我在navigationItem的titleView中添加了两个按钮然后设置了一下两个按钮之间的间距。对应两个按钮我分别创建两个控制器，在每个控制器里面根据对应的按钮设置相对应的布局。

```objc

	//设置navigationItem.title的标题
	- (void)setupNavigationItemTitle
	{
    UIView *titleBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    
    UIButton *subscribeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    subscribeBtn.frame = CGRectMake(0, 0, titleBtnView.sy_width * 0.5 , titleBtnView.sy_height);
    [subscribeBtn setTitle:@"订阅" forState:UIControlStateNormal];
    [subscribeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [subscribeBtn addTarget:self action:@selector(subscribeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [subscribeBtn.titleLabel sizeToFit];
   
    CGFloat w = subscribeBtn.titleLabel.frame.size.width;
    CGFloat h = subscribeBtn.sy_height;
    [titleBtnView addSubview:subscribeBtn];
    
    //底部滚动线条
    UIView *underLine = [[UIView alloc]init];
    underLine.backgroundColor = [UIColor redColor];
    underLine.frame = CGRectMake(0, h, w, 3);
    [subscribeBtn.titleLabel addSubview:underLine];
    _underLine = underLine;
    
    UIButton *attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionBtn.frame = CGRectMake(titleBtnView.sy_width * 0.5, 0, titleBtnView.sy_width * 0.5 , titleBtnView.sy_height);
    [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    [attentionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [attentionBtn.titleLabel sizeToFit];
    [attentionBtn addTarget:self action:@selector(subscribeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [titleBtnView addSubview:attentionBtn];
    
    self.navigationItem.titleView = titleBtnView;
	}

```
#####点击左上角是推荐关注，里面采取在一个控制器上放了两个tableView的方式来制作的，只要根据左边数据传过来相对应的ID就可以设置右边内容
。
<img src="http://ww4.sinaimg.cn/mw690/7306bf8agw1f5i8lyb2swj211c0g6wig.jpg" width="70%" height="70%">

###我的界面
#####我的界面这个整体来说还是挺简单的控制器是UItableView，stype设置成group,下面的九宫格才去的是UICollectionView的流水不拒，然后添加到tableFooterView上即可。

```objc

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




```
#####左上角设置页面里面的数据可以用静态单元格也可以用动态单元格，我采取的是动态单元格的方式，首先设置各个样式的模型，运用MVC的思想实现了各个CELL的样式和点击。


```objc

	//添加第一组，创建对应的模型数据然后直接调用其模型就可以直接创建组
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
    SYArrowSettingItem *clear = [SYArrowSettingItem itemWithTitle:_saveCaching];
    clear.itemOpertion = ^(NSIndexPath *indexPath){
        [[SDImageCache sharedImageCache] clearDisk];
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

```
###发布功能
#####点击中间发布按钮会弹出发布界面，里面是动画，类似于微博，在这里我运用了POP这个框架相对来说比较容易


```objc

      //因为我们要利用pop这个框架给按钮做动画，所以我们在调用框架的方法中对按钮的位置进行赋值，即一开始按钮的Y位置位于控制器View的最上面，当动画开始时从上方滑下来
        //设置frame
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - SYScreenH;
        [self.view addSubview:button];
        
        //按钮动画
        //利用POP里面的POPSpringAnimation方法，弹簧效果
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        //设置按钮从哪里开始
        anim.fromValue =[NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        //设置按钮到哪里结束
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        //弹簧的弹力
        anim.springBounciness =SYSpringFactor;
        //弹簧的速度
        anim.springSpeed = SYSpringFactor;
        //设置每个按钮的开始下滑的时间，每个按钮开始时间间距0.1秒
        anim.beginTime = CACurrentMediaTime() + SYAnimationDelay * i;
        //把动画效果添加给按钮
        [button pop_addAnimation:anim forKey:nil];

```
###局部东西
#####我在做的时候遇到了种种问题，现在分别列举一下。
#####1.在上拉刷新和下拉刷新的时候要考虑失败的情况，还要判断重复加载和突然切换页面，比如当我们上拉或者下拉的时候突然想切换页面了，这个时候我们要取消一切的加载请求。在这里可以看一下SYCommentViewController.m里面我写的注释，比较详细
#####2.就是我的页面左上角设置界面的搭建方式，在搭建设置界面我采用的是MVC的思想，通过模型来创建对应的View，这一块是很重要的
#####3就是对于第三库的封装，在这里我封装了一个展示加载数据的库，这里我们要考虑如果下次更换其他库的安全性和实用性。

#####零零散散说了一堆，写完之后有仔细的把代码看了一遍发现在中途遇到的bug现在看来都是蛮简单的，其实只是思路上的转变，换个方式就可以解决了。写的特别粗糙，大家可以把我的demo下载下来研究一下，因为这个demo里的注释我写的非常详细，包括我遇到的问题，原因和解决办法我都有记载，基本上说，只要你仔细的把我写的代码多看几遍，先不说质的改变，但总体会有一定量的改变。
#####因为月底要去上海找工作时间太紧，最后草草收尾还有几个Bug没有解决，
#####1 我的页面左上角设置页面中清除缓存还没修复
#####2 每段文字以及评论的行与行之间的间距还没有设置
#####3 当点击导航栏顶部的时候cell会返回
#####剩下的就是一些零散的调整还有一些功能的实现，如果后期有时间会把播放视频的功能和数据库以及分享实现。
###请尽请指出不足之处，我欣然接受
[四爷——仿写百思不得姐(最新版)github地址](https://github.com/sunhaichao-SY/SY-BS-NEWS.git)
#####(第一次写文档，太垃圾了，见笑~~)
