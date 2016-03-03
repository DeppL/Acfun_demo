//
//  ChildClassifierViewController.m
//  Acfun_demo
//
//  Created by DeppL on 16/3/2.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "ChildClassifierViewController.h"

//#import "ClassifierViewNormalTableViewCell.h"
#import "ClassifierViewNormalCollectionViewCell.h"
#import "CollectionViewHorizontalCell.h"
#import "ClassifierViewCollectionReusableView.h"
#import "DetailVideoViewController.h"


#import "ChannelModel.h"
#import "ClassifierViewModel.h"

static NSString * const classifierRecommendViewURL = @"http://api.aixifan.com/searches/channel?pageNo=1&pageSize=4&range=604800000&sort=1";
static NSString * const classifierNormalViewURL = @"http://api.aixifan.com/searches/channel?app_version=4.1.0&market=appstore&origin=ios&resolution=1536x2048&sort=4&sys_name=ios&sys_version=9.2.1&pageNo=1&pageSize=20";


@interface ChildClassifierViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) ClassifierViewModel *recommendModel;
@property (nonatomic, strong) ClassifierViewModel *normalModel;

@end

@implementation ChildClassifierViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:IMAGE(@"loadingView")];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpClassifierViewList)];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}


- (void)setUpClassifierViewList {
    
    __weak __typeof(self) weakSelf = self;
    NSString *recommendUrlString = [classifierRecommendViewURL stringByAppendingFormat:@"&channelIds=%@", self.subModel.channelId];
    
    [DLHttpTool get:recommendUrlString params:nil cachePolicy:DLHttpToolReturnCacheDataThenLoad success:^(id json) {
        
        weakSelf.recommendModel = [ClassifierViewModel mj_objectWithKeyValues:json[@"data"]];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
    
    NSString *normalUrlString = [classifierNormalViewURL stringByAppendingFormat:@"&channelIds=%@", self.subModel.channelId];
    
    [DLHttpTool get:normalUrlString params:nil cachePolicy:DLHttpToolReturnCacheDataThenLoad success:^(id json) {
        
        weakSelf.normalModel = [ClassifierViewModel mj_objectWithKeyValues:json[@"data"]];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGRect rect = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight - 105);
        _collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kMyWhite;
        [_collectionView registerClass:[ClassifierViewNormalCollectionViewCell class] forCellWithReuseIdentifier:ClassifierViewNormalCollectionViewCellID];
        [_collectionView registerClass:[CollectionViewHorizontalCell class] forCellWithReuseIdentifier:CollecionViewHorizontalCellID];
        [_collectionView registerClass:[ClassifierViewCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ClassifierViewCollectionReusableViewID];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (0 == section && self.recommendModel) {
        return self.recommendModel.list.count;
    }
    else if (1 == section) {
        return self.normalModel.list.count;
    }
    else return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.normalModel) return 2;
    if (self.recommendModel) return 1;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        CollectionViewHorizontalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollecionViewHorizontalCellID forIndexPath:indexPath];
        [cell setUpCollectionHorizontalCellWithClassifierViewVideoModel:self.recommendModel.list[indexPath.row]];
        return cell;
    }
    else if (1 == indexPath.section) {
        ClassifierViewNormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassifierViewNormalCollectionViewCellID forIndexPath:indexPath];
        [cell setUpWithNormalModel:self.normalModel.list[indexPath.row]];
        return cell;
    }
    else return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ClassifierViewCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ClassifierViewCollectionReusableViewID forIndexPath:indexPath];
    
    if (0 == indexPath.section) {
        header.mainImageView.image = [UIImage imageNamed:@"RecommendIcon"];
        header.mainLabel.text = self.subModel.name;
    }
    else if (1 == indexPath.section) {
        header.mainImageView.image = [UIImage imageNamed:@"NormalIcon"];
        header.mainLabel.text = @"更多内容";
    }
    return header;
}




#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld -- %ld", (long)indexPath.section, (long)indexPath.row);
    
    DetailVideoViewController *detailVC = [[DetailVideoViewController alloc]init];
    
    if (0 == indexPath.section) {
        ClassifierViewVideoModel *model = self.recommendModel.list[indexPath.row];
        
        detailVC.strURL = [model.contentId stringByReplacingOccurrencesOfString:@"ac" withString:@""];
    }
    else if (1 == indexPath.section) {
        ClassifierViewVideoModel *model = self.normalModel.list[indexPath.row];
        detailVC.strURL = [model.contentId stringByReplacingOccurrencesOfString:@"ac" withString:@""];
        
    }
    else {}
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return CGSizeMake(360, 250);
    }
    else if (1 == indexPath.section) {
        return CGSizeMake(kDeviceWidth, 135);
    }
    else return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (0 == section) {
        return UIEdgeInsetsMake(0, 15, 0, 15);
    }
//    else if (1 == section) {
        return UIEdgeInsetsZero;
//    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kDeviceWidth, 55);
}


@end
