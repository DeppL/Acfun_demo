//
//  FocusViewController.m
//  Acfun_demo
//
//  Created by DeppL on 15/12/26.
//  Copyright © 2015年 DeppL. All rights reserved.
//

#import "FocusViewController.h"
#import "DownloadViewController.h"
#import "HistoryViewController.h"
#import "SearchViewController.h"

#import "TableViewArticlesCell.h"
#import "TableViewBangumisCell.h"
#import "TableViewBannersCell.h"
#import "TableViewCarouselsCell.h"
#import "TableViewVideosCell.h"

#import "HomeModelConfig.h"


@interface FocusViewController () <UITableViewDataSource, UITableViewDelegate, TableViewArticlesCellDelegate, TableViewVideosCellDelegate, TableViewBangumisCellDelegate>

@property (nonatomic, copy) NSArray *homeModelsArr;
@property (nonatomic, copy) NSArray *homeModelsFrameArr;

@property (nonatomic, strong) UITableView *homeTableView;

@end


@implementation FocusViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    
    [self setUpTableView];
    
    [self setUpHomelList];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - initialize

- (NSArray *)homeModelsArr {
    if (!_homeModelsArr) {
        _homeModelsArr = [NSArray array];
    }
    return _homeModelsArr;
}

- (NSArray *)homeModelsFrameArr {
    if (!_homeModelsFrameArr) {
        _homeModelsFrameArr = [[NSArray alloc]init];
    }
    return _homeModelsFrameArr;
}

- (UITableView *)homeTableView {
    if (!_homeTableView) {
        CGRect rect = CGRectMake(0, 64, kDeviceWidth, KDeviceHeight - 64);
        _homeTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _homeTableView;
}


- (void)setUpNav {
    
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

- (void)setUpTableView {
    [self.homeTableView registerClass:[TableViewArticlesCell class] forCellReuseIdentifier:TableViewArticlesCellID];
    [self.homeTableView registerClass:[TableViewBangumisCell class] forCellReuseIdentifier:TableViewBangumisCellID];
    [self.homeTableView registerClass:[TableViewBannersCell class] forCellReuseIdentifier:TableViewBannersCellID];
    [self.homeTableView registerClass:[TableViewCarouselsCell class] forCellReuseIdentifier:TableViewCarouselsCellID];
    [self.homeTableView registerClass:[TableViewVideosCell class] forCellReuseIdentifier:TableViewVideosCellID];
    [self.view addSubview:self.homeTableView];
    
}

- (void)setUpHomelList {
    
    [SingleHttpTool GETHomeModelSuccess:^(id object) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            self.homeModelsArr = [HomeModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            self.homeModelsFrameArr = [HomeModelFrame setUpFrameWithHomeModelArr:self.homeModelsArr];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.homeTableView reloadData];
            });
        });
    } failure:^(NSError *error) {
        NSLog(@"failure");
    } offline:^{
        NSLog(@"offline");
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
            
        default: return nil;
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
    HomeModelFrame *modelFrame = self.homeModelsFrameArr[indexPath.section];
    
    if (indexPath.section == self.homeModelsArr.count - 1) return modelFrame.cellHight + 100;
    return modelFrame.cellHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *model = self.homeModelsArr[indexPath.row];
    NSLog(@"focusTableView:%@ --- cell --- %ld",model.name, (long)indexPath.section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 1 || section == 4 || section == 7 || section == 16) return 0;
    return 5;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionFooterHeight = 40;
    CGFloat ButtomHeight = scrollView.contentSize.height - self.homeTableView.frame.size.height;
    
    if (ButtomHeight - sectionFooterHeight <= scrollView.contentOffset.y && scrollView.contentSize.height > 0) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } else  {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, -(sectionFooterHeight), 0);
    }
    
}

#pragma mark - TableViewArticlesCellDelegate TableViewVideosCellDelegate

- (void)articleCellDidSelectRowAtURL:(NSString *)url {
    NSLog(@"articleCell-Clicked With %@",url);
}

- (void)videosCellDidSelectRowAtURL:(NSString *)url {
    NSLog(@"videosCell-Clicked With %@",url);
}

- (void)bangumisCellDidSelectRowAtURL:(NSString *)url {
    NSLog(@"bangumisCell-Clicked With %@",url);
}


#pragma mark - 内存警告

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //    SearchViewController *searchVC = [[SearchViewController alloc]init];
    //    [self.navigationController pushViewController:searchVC animated:NO];
    NSLog(@"btnClick");
}


@end
