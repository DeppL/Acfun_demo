//
//  ClassifierViewController.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/21.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "ClassifierViewController.h"
#import "ChannelModel.h"

#define kGuideViewHight 40

@interface ClassifierViewController () <UIScrollViewDelegate>

@property (assign) NSInteger tabCount;

@property (nonatomic, assign) NSInteger firstResponseRow;
@property (nonatomic, strong) UIView *slideView;
@property (nonatomic, strong) UIView *guideView;
@property (nonatomic, strong) UIScrollView *mainScrollView;


@end

@implementation ClassifierViewController

#pragma mark -
#pragma mark - public
- (void)setFirstResponseViewWithIndex:(NSInteger)indexRow {
    self.firstResponseRow = indexRow;
}

#pragma mark -
#pragma mark - private

#pragma mark - 初始化
- (UIView *)slideView {
    if (!_slideView) {
        _slideView = [[UIView alloc]init];
    }
    return _slideView;
}

- (UIView *)guideView {
    if (!_guideView) {
        _guideView = [[UIView alloc]init];
    }
    return _guideView;
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]init];
    }
    return _mainScrollView;
}

// 设置navigationItem
- (void)setUpNav {
    
    
    self.tabBarController.tabBar.hidden = YES;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.text = self.channelSubModel.name;
    titleLabel.textColor = kMyWhite;
    [self.navigationItem.titleView addSubview:titleLabel];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    [cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickToCancel) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    [deleteBtn setTitle:@"delete" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [deleteBtn addTarget:self action:@selector(clickToDelete) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc]initWithCustomView:deleteBtn];
    self.navigationItem.rightBarButtonItem = deleteItem;
    
}

// 设置导航条
- (void)setUpGuideView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tabCount = self.channelSubModel.childChannels.count;
    
    
    CGRect guideRect = CGRectMake(0, 64, kDeviceWidth, kGuideViewHight);
    _guideView = [[UIScrollView alloc]initWithFrame:guideRect];
    [_guideView setBounds:guideRect];
    _guideView.backgroundColor = kMyWhite;
    
    
    CGFloat width = (CGFloat)kDeviceWidth / _tabCount;
    for (int i = 0; i < _tabCount; i ++) {
        CGRect btnRect = CGRectMake(width * i, 64, width, kGuideViewHight);
        UIButton *btn = [[UIButton alloc]initWithFrame:btnRect];
        ChannelModel *model = self.channelSubModel.childChannels[i];
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(guideBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_guideView addSubview:btn];
    }
    
    
    _slideView = [[UIView alloc]initWithFrame:CGRectMake((width - 30) * 0.5, kGuideViewHight + 64 - 5, 30, 5)];
    _slideView.backgroundColor = kMyRed;
    [_guideView addSubview:_slideView];
    
    [self.view addSubview:_guideView];
}

// 设置主视图
- (void)setUpMainScrollView {
    CGRect mainScrollViewRect = CGRectMake(0, 64 + kGuideViewHight, kDeviceWidth, KDeviceHeight - kGuideViewHight - 64);
    _mainScrollView = [[UIScrollView alloc]initWithFrame:mainScrollViewRect];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.delegate = self;
    for (int i = 0; i < _tabCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth * i, 0, kDeviceWidth, KDeviceHeight - kGuideViewHight - 64)];
        imageView.image = [UIImage imageNamed:@"placeHolder"];
        [_mainScrollView addSubview:imageView];
    }
    
    [self.view addSubview:_mainScrollView];
}


// 设置第一响应视图
- (void)setFirstResponseView {
    [_mainScrollView setContentOffset:CGPointMake(kDeviceWidth * _firstResponseRow, 0) animated:YES];
    
    CGFloat slideViewCenterX = kDeviceWidth / (CGFloat)_tabCount * (_firstResponseRow + 0.5);
    CGPoint slideViewCenterP = _slideView.center;
    slideViewCenterP.x = slideViewCenterX;
    [_slideView setCenter:slideViewCenterP];
    
    UIButton *btn = _guideView.subviews[_firstResponseRow];
    [btn setTitleColor:kMyRed forState:UIControlStateNormal];
    
}


#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置navigationItem
    [self setUpNav];
    
    // 设置导航条
    [self setUpGuideView];
    
    // 设置主视图
    [self setUpMainScrollView];
    
    // 设置第一响应视图
    [self setFirstResponseView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _mainScrollView.contentSize = CGSizeMake(kDeviceWidth * _tabCount, KDeviceHeight - kGuideViewHight - 64);
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 位置系数
    CGFloat i = scrollView.contentOffset.x / kDeviceWidth;
    
    // 设置_slideView.frame
    CGRect rect = _slideView.frame;
    rect.origin.x = kDeviceWidth / _tabCount * i + (kDeviceWidth / _tabCount - 30) * 0.5;
    _slideView.frame = rect;
    
    // 滚动时，设置guideView的颜色
    if (i >= _guideView.subviews.count - 4 || fabs(i - (NSUInteger)(i) + 0.5) < 0.1 ) return;
    
    UIButton *leftBtn = _guideView.subviews[(NSUInteger)i];
    UIButton *rightBtn = _guideView.subviews[(NSUInteger)(i + 1)];
    if ((i - (NSUInteger)i) < 0.5) {
        [leftBtn setTitleColor:kMyRed forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }else {
        [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [rightBtn setTitleColor:kMyRed forState:UIControlStateNormal];
    }
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.x < 0) {
        [self clickToCancel];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {}


#pragma mark - 点击响应事件

- (void)clickToCancel {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)guideBtnClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [_mainScrollView setContentOffset:CGPointMake(btn.tag * kDeviceWidth, 0) animated:YES];
}



@end
