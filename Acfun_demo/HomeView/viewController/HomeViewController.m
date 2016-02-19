//
//  HomeViewController.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/18.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "HomeViewController.h"
#import "DownloadViewController.h"
#import "HistoryViewController.h"
#import "SearchViewController.h"

#import "TableViewArticlesCell.h"
#import "TableViewBangumisCell.h"
#import "TableViewBannersCell.h"
#import "TableViewCarouselsCell.h"
#import "TableViewVideosCell.h"

#import "DetailVideoViewController.h"

#import "HomeModelConfig.h"

NSString *const homeModelURL = @"http://api.aixifan.com/regions";

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, TableViewArticlesCellDelegate, TableViewVideosCellDelegate, TableViewBangumisCellDelegate>

@property (nonatomic, copy) NSMutableArray *homeModelsArr;

@property (nonatomic, copy) NSArray *homeModelsFrameArr;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeViewController


#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loadingView"]];
    
    [self setUpRefreshHeader];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpNav];
    
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}


#pragma mark - 内存警告

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[SDImageCache sharedImageCache] clearMemory];
}



#pragma mark - initialize

- (NSMutableArray *)homeModelsArr {
    if (!_homeModelsArr) {
        _homeModelsArr = [[NSMutableArray alloc] init];
    }
    return _homeModelsArr;
}

- (NSArray *)homeModelsFrameArr {
    if (!_homeModelsFrameArr) {
        _homeModelsFrameArr = [NSArray array];
    }
    return _homeModelsFrameArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loadingView"]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TableViewArticlesCell class] forCellReuseIdentifier:TableViewArticlesCellID];
        [_tableView registerClass:[TableViewBangumisCell class] forCellReuseIdentifier:TableViewBangumisCellID];
        [_tableView registerClass:[TableViewBannersCell class] forCellReuseIdentifier:TableViewBannersCellID];
        [_tableView registerClass:[TableViewCarouselsCell class] forCellReuseIdentifier:TableViewCarouselsCellID];
        [_tableView registerClass:[TableViewVideosCell class] forCellReuseIdentifier:TableViewVideosCellID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)setUpNav {
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    //------------------------------------------- self.navigationItem.leftBarButtonItem ------------------------------------------
    // handTitle
    UILabel *handTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    handTitle.text = @"Acfun";
    handTitle.textColor = [UIColor whiteColor];
    handTitle.font = [UIFont fontWithName:@"Verdana-Bold" size:25];
    handTitle.textAlignment = NSTextAlignmentCenter;
    
    UIBarButtonItem *titleBarButten = [[UIBarButtonItem alloc]initWithCustomView:handTitle];
    
    self.navigationItem.leftBarButtonItem = titleBarButten;
    
    //------------------------------------------- self.navigationItem.rightBarButtonItem ------------------------------------------
    
    UIButton *downLoadBtn = [[UIButton alloc]initWithFrame:CGRectMake(1536 / 2.0 - 132, 20, 44, 44)];
    [downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [downLoadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downLoadBtn addTarget:self action:@selector(pushToDownloadView) forControlEvents:UIControlEventTouchUpInside];
    
    // historyBtn
    UIButton *historyBtn = [[UIButton alloc]initWithFrame:CGRectMake(1536 / 2.0 - 88, 20, 44, 44)];
    [historyBtn setTitle:@"历史" forState:UIControlStateNormal];
    [historyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [historyBtn addTarget:self action:@selector(pushToHistoryView) forControlEvents:UIControlEventTouchUpInside];
    
    // searchBtn
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(1536 / 2.0 - 44, 20, 44, 44)];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(pushToSearchView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *downloadBarButten = [[UIBarButtonItem alloc]initWithCustomView:downLoadBtn];
    UIBarButtonItem *historyBarButten = [[UIBarButtonItem alloc]initWithCustomView:historyBtn];
    UIBarButtonItem *searchBarButten = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    
    self.navigationItem.rightBarButtonItems = @[searchBarButten, historyBarButten, downloadBarButten];
    
}

- (void)setUpRefreshHeader {
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setUpHomeList];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
}


/**
 *  主模型
 */
- (void)setUpHomeList {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    __weak __typeof(self) weakSelf = self;
    [DLHttpTool get:homeModelURL params:nil cachePolicy:DLHttpToolReloadIgnoringLocalCacheData success:^(id json) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            if (_homeModelsArr.count) { // 主tableview内容，是否已经存在
                
                NSArray *arr = [HomeModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                
                for (int i = 0; i < arr.count; i++) {
                    
                    HomeModel *model = arr[i];
                    if (model.contents) {
                        
                        [weakSelf.homeModelsArr replaceObjectAtIndex:i withObject:model];
                        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:i];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                        });
                        
                    }
                    else {
                        [weakSelf getSubHomeListWith:model.homeId];
                    }
                }
            }
            else {
                _homeModelsArr = [HomeModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                _homeModelsFrameArr = [HomeModelFrame setUpFrameWithHomeModelArr:weakSelf.homeModelsArr];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
                
                for (HomeModel *subOriginModel in weakSelf.homeModelsArr) {
                    if (!subOriginModel.contents) [weakSelf getSubHomeListWith:subOriginModel.homeId];
                }
            }
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"failure");
        [weakSelf.tableView.mj_header endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }];
}


/**
 *  子模型
 *
 */
- (void)getSubHomeListWith:(NSString *)subURL {
    
    NSString *urlSubStr = [homeModelURL stringByAppendingPathComponent:subURL];
    
    __weak __typeof(self) weakSelf = self;
    [DLHttpTool get:urlSubStr params:nil cachePolicy:DLHttpToolReloadIgnoringLocalCacheData success:^(id json) {
        
        HomeModel *subModel = [HomeModel mj_objectWithKeyValues:json[@"data"]];
        for (int i = 0; i < weakSelf.homeModelsArr.count; i ++) {
            
            HomeModel *subOriginModel = weakSelf.homeModelsArr[i];
            if (subModel.homeId != subOriginModel.homeId) continue;
            
            [weakSelf.homeModelsArr replaceObjectAtIndex:i withObject:subModel];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:i];
            [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        }
     
    } failure:^(NSError *error) {
        NSLog(@"subModel -- failure");
        
    }];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HomeModel *model = self.homeModelsArr[indexPath.section];
    HomeModelFrame *modelFrame = self.homeModelsFrameArr[indexPath.section];
    
    id cell;
    
    switch ([model.type.typeId integerValue]) {
        case HomeViewCellTypeVideos: {
            cell = (TableViewVideosCell *)[tableView dequeueReusableCellWithIdentifier:TableViewVideosCellID forIndexPath:indexPath];
            [cell setDelegate:self];
            break;
        }
            
        case HomeViewCellTypeBanners: {
            cell = (TableViewBannersCell *)[tableView dequeueReusableCellWithIdentifier:TableViewBannersCellID forIndexPath:indexPath];
            break;
        }
            
        case HomeViewCellTypeBangumis: {
            cell = (TableViewBannersCell *)[tableView dequeueReusableCellWithIdentifier:TableViewBangumisCellID forIndexPath:indexPath];
            [cell setDelegate:self];
            break;
        }
            
        case HomeViewCellTypeCarousels: {
            cell = (TableViewCarouselsCell *)[tableView dequeueReusableCellWithIdentifier:TableViewCarouselsCellID forIndexPath:indexPath];
            break;
        }
            
        case HomeViewCellTypeArticles: {
            cell = (TableViewBannersCell *)[tableView dequeueReusableCellWithIdentifier:TableViewArticlesCellID forIndexPath:indexPath];
            [cell setDelegate:self];
            break;
        }
        
    }
    
    [cell setUpWithModel:model];
    [cell setUpWithModelFrame:modelFrame];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.homeModelsArr.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_homeModelsFrameArr) return 100;
    
    HomeModelFrame *modelFrame = self.homeModelsFrameArr[indexPath.section];
    
    return modelFrame.cellHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    HomeModel *model = self.homeModelsArr[indexPath.row];
//    NSLog(@"focusTableView:%@ --- cell --- %ld",model.name, (long)indexPath.section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if ( 1 == section || 4 == section || 7 == section || 16 == section ) return 0;
    return 5;
}


#pragma mark - TableViewArticlesCellDelegate TableViewVideosCellDelegate

- (void)articleCellDidSelectRowAtURL:(NSString *)url {
}

- (void)videosCellDidSelectRowAtURL:(NSString *)url {
    
    DetailVideoViewController *detailVC = [[DetailVideoViewController alloc]init];
    detailVC.strURL = url;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)bangumisCellDidSelectRowAtURL:(NSString *)url {
}


#pragma mark - 事件响应

- (void)pushToDownloadView {
    //    DownloadViewController *downloadVC = [[DownloadViewController alloc]init];
    //    [self.navigationController pushViewController:downloadVC animated:NO];
}

- (void)pushToHistoryView {
    //    HistoryViewController *historyVC = [[HistoryViewController alloc]init];
    //    [self.navigationController pushViewController:historyVC animated:YES];
}

- (void)pushToSearchView {
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:NO];
    NSLog(@"btnClick");
}



@end
