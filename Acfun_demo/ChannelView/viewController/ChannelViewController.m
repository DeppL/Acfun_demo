//
//  ChannelViewController.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/18.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "ChannelViewController.h"
#import "SearchViewController.h"

#import "ClassifierViewController.h"

#import "ChannelModel.h"
#import "ChannelCollectionViewCell.h"
#import "CollectionHeadView.h"
#import "CollectionFootView.h"


@interface ChannelViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *channelCollectionView;

@property (nonatomic, copy) NSArray *channelModelsArr;


@end

@implementation ChannelViewController


#pragma mark - 视图生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loadingView"]];
    
    // 设置导航栏
    [self setUpNav];
    
    // 设置CollectionView
    [self setUpCollectionView];
    
    // 设置channelList
    [self setUpChannelList];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
}


#pragma mark - 数据初始化


// 设置导航栏
- (void)setUpNav {
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    //------------------------------------------- self.navigationItem.titleView ------------------------------------------
    // searchBtn
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchBtn.frame = CGRectMake(0, 0, 1536 / 2.0, 30);
    searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn setTitle:@"请输入关键词或ac号" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [searchBtn.layer setCornerRadius:5.0];
    [searchBtn addTarget:self action:@selector(pushToSearchView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = searchBtn;
}

// 设置CollectionView
- (void)setUpCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    self.channelCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.channelCollectionView.delegate = self;
    self.channelCollectionView.dataSource = self;
    self.channelCollectionView.backgroundColor = RGBA(255, 255, 255, 1.0);
    
    [self.channelCollectionView registerClass:[ChannelCollectionViewCell class] forCellWithReuseIdentifier:channelCellID];
    [self.channelCollectionView registerClass:[CollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeadViewID];
    [self.channelCollectionView registerClass:[CollectionFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionFootViewID];
    
    self.view = self.channelCollectionView;
}

// SingleHttpTool下载channelList
#warning channelList Download
- (void)setUpChannelList {
    
    [SingleHttpTool GETChannelModelSuccess:^(id object) {
//        NSLog(@"success");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.channelModelsArr = [ChannelModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.channelCollectionView reloadData];
            });
        });
    } failure:^(NSError *error) {
        NSLog(@"error");
    } offline:^{
        NSLog(@"offline");
    }];
}



#pragma mark - DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ((ChannelModel *)self.channelModelsArr[section]).childChannels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ChannelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:channelCellID forIndexPath:indexPath];
    
    // 获取subCell模型数据
    ChannelModel *subModel = [ChannelModel getSubChannelModelInModelArr:self.channelModelsArr withSection:indexPath.section andRow:indexPath.row];
    
    UIImage *placeHolderImage = [UIImage imageNamed:@"placeHolder"];
    NSURL *url = [NSURL URLWithString:subModel.img];
    
    // 设置subCell
    [cell.subChannelImageView sd_setImageWithURL:url placeholderImage:placeHolderImage];
//    cell.subChannelLabel.text = subModel.channelId;
    cell.subChannelLabel.text = subModel.name;
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.channelModelsArr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ChannelModel *channelModel = self.channelModelsArr[indexPath.section];
    
    
    if (UICollectionElementKindSectionHeader == kind) {
        CollectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeadViewID forIndexPath:indexPath];
        [headView.headButton setTitle:channelModel.name forState:UIControlStateNormal];
        [headView.headButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [headView.headButton addTarget:self action:@selector(pushToSearchView:) forControlEvents:UIControlEventTouchUpInside];
        return headView;
    } else {

        CollectionFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionFootViewID forIndexPath:indexPath];
        NSString *footTitle = [NSString stringWithFormat:@"%@推荐->%@",channelModel.name, channelModel.channelId];
        footView.footLable.text = footTitle;
        footView.whiteView.hidden = NO;
        
        if (indexPath.section == self.channelModelsArr.count - 1) footView.whiteView.hidden = YES;
        
        return footView;
    }
}

#pragma mark - Delegate

#warning cell selected
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld--%ld",(long)indexPath.section, (long)indexPath.row);
    
    ClassifierViewController *classifierVC = [[ClassifierViewController alloc]init];
    [classifierVC setFirstResponseViewWithIndex:indexPath.row];
    
    classifierVC.channelSubModel = self.channelModelsArr[indexPath.section];
    
//    [self.navigationController presentViewController:userVC animated:YES completion:nil];
//    [self presentViewController:userVC animated:YES completion:nil];
    [self.navigationController pushViewController:classifierVC animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kDeviceWidth, 44);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(100, 44);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat edge = kDeviceWidth - (((ChannelModel *)self.channelModelsArr[section]).childChannels.count * 80);
    
    return UIEdgeInsetsMake(10, edge * 0.5, 0, edge * 0.5);
}


#pragma mark - 事件响应

- (IBAction)pushToSearchView:(id)sender {
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:NO];
}

@end
