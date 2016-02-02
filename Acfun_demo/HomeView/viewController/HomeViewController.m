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

#import "UserViewController.h"

//#import "HomeModel.h"
#import "HomeModelConfig.h"
#import "HomeCollectionViewCell.h"
#import "HomeCollectionHeadView.h"
#import "HomeCollectionFootView.h"



@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *homeCollectionView;

@property (nonatomic, copy) NSArray *homeModelsArr;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    
//    [self setUpHomelList];
    
    [self setUpCollectionView];
    
}


- (NSArray *)homeModelsArr {
    if (!_homeModelsArr) {
        _homeModelsArr = [NSArray array];
    }
    return _homeModelsArr;
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

// 设置CollectionView
- (void)setUpCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    self.homeCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.homeCollectionView.delegate = self;
    self.homeCollectionView.dataSource = self;
    
    [self.homeCollectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:homeCellID];
    [self.homeCollectionView registerClass:[HomeCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:homeCollectionHeadViewID];
    [self.homeCollectionView registerClass:[HomeCollectionFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:homeCollectionFootViewID];
    
    self.view = self.homeCollectionView;
}

// 下载channelList
- (void)setUpHomelList {
    
    [SingleHttpTool GETHomeModelSuccess:^(id object) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.homeModelsArr = [HomeModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.homeCollectionView reloadData];
            });
        });
    } failure:^(NSError *error) {
        NSLog(@"failure");
    } offline:^{
        NSLog(@"offline");
    }];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ((HomeModel *)self.homeModelsArr[section]).contents.count;
    //    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCellID forIndexPath:indexPath];
    
    // 获取subCell模型数据
    HomeModelContent *subModel = [HomeModel getSubHomeModelInModelArr:self.homeModelsArr withSection:indexPath.section andRow:indexPath.row];
    
    UIImage *placeHolderImage = [UIImage imageNamed:@"placeHolder"];
    NSURL *url = [NSURL URLWithString:subModel.image];
    
    // 设置subCell
    [cell.mainImageView sd_setImageWithURL:url placeholderImage:placeHolderImage];
    //    [cell.subChannelImageView setImage:placeHolderImage];
    cell.labelTitle.text = subModel.title;
//    NSLog(@"%f",cell.frame.size.height);
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.homeModelsArr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (UICollectionElementKindSectionHeader == kind) {
        NSString *headTitle = ((HomeModel *)self.homeModelsArr[indexPath.section]).name;
        HomeCollectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:homeCollectionHeadViewID forIndexPath:indexPath];
        [headView.headButton setTitle:headTitle forState:UIControlStateNormal];
        [headView.headButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [headView.headButton addTarget:self action:@selector(pushToSearchView) forControlEvents:UIControlEventTouchUpInside];
        return headView;
    } else {
        NSString *footTitle = ((HomeModelMenu *)((HomeModel *)self.homeModelsArr[indexPath.section]).menus[0]).name;
        HomeCollectionFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:homeCollectionFootViewID forIndexPath:indexPath];
//        NSString *footTitle = [NSString stringWithFormat:@"%@推荐->",headTitle];
        footView.footLable.text = footTitle;
        
        return footView;
    }
}
#pragma mark - UICollectionViewDelegate

#warning cell selected
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld--%ld",(long)indexPath.section, (long)indexPath.row);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kDeviceWidth, 44);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kDeviceWidth, 44);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(kDeviceWidth, kDeviceWidth * 0.5);
        case 2:
            return CGSizeMake(kDeviceWidth, kDeviceWidth * 0.5);
        case 5:
            return CGSizeMake(kDeviceWidth, kDeviceWidth * 0.5);
        case 8:
            return CGSizeMake(kDeviceWidth, kDeviceWidth * 0.5);
        default:
            return CGSizeMake(kDeviceWidth * 0.5 - 20, kDeviceWidth * 0.25 - 10);
    }
    
//    return CGSizeMake(kDeviceWidth * 0.5 - 20, kDeviceWidth * 0.25 - 10);
}

#warning edge
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(0, 0, 0 ,0);
        case 2:
            return UIEdgeInsetsMake(0, 0, 0 ,0);
        case 5:
            return UIEdgeInsetsMake(0, 0, 0 ,0);
        case 8:
            return UIEdgeInsetsMake(0, 0, 0 ,0);
        default:
            return UIEdgeInsetsMake(10, 10, 10 ,10);
    }
}




#pragma mark - 内存警告

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
