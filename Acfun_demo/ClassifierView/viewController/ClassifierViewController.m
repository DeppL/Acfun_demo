//
//  ClassifierViewController.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/21.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "ClassifierViewController.h"
#import "ChannelModel.h"

#import "ChildClassifierViewController.h"
//#import "ClassifierViewCollectionViewCell.h"
#import "ClassifierViewModel.h"


#define kGuideViewHight 40
#define kGuideViewWidth kDeviceWidth / _tabCount

@interface ClassifierViewController () <UIScrollViewDelegate>

// 总页数
@property (nonatomic, assign) NSInteger tabCount;

// 第一响应页
@property (nonatomic, assign) NSInteger firstResponseRow;

// 当前页
@property (nonatomic, assign) NSInteger currentRow;

// 主功能视图
@property (nonatomic, strong) UIView *slideView;
@property (nonatomic, strong) UIView *guideView;
@property (nonatomic, strong) UIScrollView *scrollView;

// 记录childVC是否存在
@property (nonatomic, assign) NSInteger childVCState;


@property (nonatomic, strong) ChannelModel *channelSubModel;

@end

@implementation ClassifierViewController



#pragma mark -
#pragma mark - public

- (void)setChannelModel:(ChannelModel *)subModel andFirstResponseViewWithIndex:(NSInteger)indexRow {
    self.firstResponseRow = indexRow;
    self.currentRow = indexRow;
    self.channelSubModel = subModel;
    NSLog(@"%ld", (long)self.currentRow);
}

#pragma mark -
#pragma mark - private


#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置导航条
//    [self.view addSubview:self.guideView];
    self.guideView.backgroundColor = kMyWhite;
    self.view.backgroundColor = kMyWhite;
    
    // 设置第一响应视图
    [self setFirstResponseView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - 初始化
- (UIView *)slideView {
    if (!_slideView) {
        _slideView = [[UIView alloc]init];
//        _slideView = [[UIView alloc]initWithFrame:CGRectMake((kGuideViewWidth - 30) * 0.5, kGuideViewHight + 64 - 5, 30, 5)];
        _slideView = [[UIView alloc]initWithFrame:CGRectMake((kGuideViewWidth - 30) * 0.5, kGuideViewHight - 5, 30, 5)];
        _slideView.backgroundColor = kMyRed;
    }
    return _slideView;
}

- (UIView *)guideView {
    if (!_guideView) {
        
        CGRect guideRect = CGRectMake(0, 64, kDeviceWidth, kGuideViewHight);
        _guideView = [[UIView alloc]initWithFrame:guideRect];
        _tabCount = self.channelSubModel.childChannels.count;
        _guideView.backgroundColor = kMyWhite;
        [self.view addSubview:_guideView];
        
        for (int i = 0; i < _tabCount; i ++) {
//            CGRect btnRect = CGRectMake(kGuideViewWidth * i, 64, kGuideViewWidth, kGuideViewHight);
            CGRect btnRect = CGRectMake(kGuideViewWidth * i, 0, kGuideViewWidth, kGuideViewHight);
            UIButton *btn = [[UIButton alloc]initWithFrame:btnRect];
//            UIButton *btn = [[UIButton alloc]init];
            ChannelModel *model = self.channelSubModel.childChannels[i];
            [btn setTitle:model.name forState:UIControlStateNormal];
            [btn setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(guideBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:i];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [_guideView addSubview:btn];
        }
        [_guideView addSubview:self.slideView];
    }
    return _guideView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGRect rect = CGRectMake(0, 105, kDeviceWidth, KDeviceHeight - 105);
        _scrollView = [[UIScrollView alloc]initWithFrame:rect];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loadingView"]];
        _scrollView.contentSize = CGSizeMake(kDeviceWidth * _tabCount, rect.size.height);
//        [self.view addSubview:_scrollView];
        [self.view insertSubview:_scrollView belowSubview:_guideView];
    }
    return _scrollView;
}

// 添加当前countVC
- (void)addChildClassifierViewControllerWithNSInteger:(NSInteger)i {
    
    NSInteger count = 1 << i;
    
    if (count & self.childVCState) return;
    
    self.childVCState += count;
    
    ChildClassifierViewController *childVC = [[ChildClassifierViewController alloc] init];
    childVC.view.frame = CGRectMake(kDeviceWidth * i, 0, kDeviceWidth, KDeviceHeight - 64 - 40);
    
    ChannelModel *subModel = self.channelSubModel.childChannels[i];
    childVC.subModel = subModel;
    [self addChildViewController:childVC];
    [self.scrollView addSubview:childVC.view];
}


// 设置第一响应视图
- (void)setFirstResponseView {
    
    if (!self.scrollView || !self.slideView) return;
    
    [_scrollView setContentOffset:CGPointMake(kDeviceWidth * _firstResponseRow, 0) animated:NO];
    
    CGFloat slideViewCenterX = kGuideViewWidth * (_firstResponseRow + 0.5);
    CGPoint slideViewCenterP = _slideView.center;
    slideViewCenterP.x = slideViewCenterX;
    [_slideView setCenter:slideViewCenterP];
    
    UIButton *btn = self.guideView.subviews[_firstResponseRow];
    [btn setTitleColor:kMyRed forState:UIControlStateNormal];
    
    self.currentRow = _firstResponseRow;
    
    [self addChildClassifierViewControllerWithNSInteger:self.currentRow];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 位置系数
    CGFloat i = scrollView.contentOffset.x / kDeviceWidth;
    
    // 设置_slideView.frame
    CGRect rect = _slideView.frame;
    rect.origin.x = kGuideViewWidth * i + (kGuideViewWidth - 30) * 0.5;
    _slideView.frame = rect;
    
    // 滚动时，设置guideView的颜色
    if (i >= _guideView.subviews.count - 2 || fabs(i - (NSUInteger)(i) + 0.5) < 0.1 ) return;
    
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


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.x < 0) {
        [self clickToCancel];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.currentRow == scrollView.contentOffset.x / kDeviceWidth) return;
    self.currentRow = scrollView.contentOffset.x / kDeviceWidth;
    [self addChildClassifierViewControllerWithNSInteger:self.currentRow];
    NSLog(@"%ld", (long)self.currentRow);
}

#pragma mark - 点击响应事件

- (void)clickToCancel {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)guideBtnClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [_scrollView setContentOffset:CGPointMake(btn.tag * kDeviceWidth, 0) animated:YES];
    self.currentRow = btn.tag;
    [self addChildClassifierViewControllerWithNSInteger:self.currentRow];
    NSLog(@"%ld", (long)self.currentRow);
}




@end
