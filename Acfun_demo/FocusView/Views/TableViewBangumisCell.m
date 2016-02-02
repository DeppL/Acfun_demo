//
//  TableViewBangumisCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/26.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "TableViewBangumisCell.h"
#import "CollectionViewVerticalCell.h"
//#import "HomeModel.h"
#import "HomeModelConfig.h"

#define kMainLabelFont [UIFont systemFontOfSize:18]

#define kSubLabelFont [UIFont systemFontOfSize:14]

@interface TableViewBangumisCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *headLabel;

@property (nonatomic, strong) UILabel *footLabel;

@property (nonatomic, strong) HomeModel *homeModel;

@end

@implementation TableViewBangumisCell

#pragma mark - Public
- (void)setUpWithModel:(HomeModel *)model {
    
    self.homeModel = model;
    
    if (model.image) {
        NSURL *url = [NSURL URLWithString:model.image];
        UIImage *image = [UIImage imageNamed:@"placeHolder"];
        [self.headImageView sd_setImageWithURL:url placeholderImage:image];
    }
    
    [self.headLabel setText:model.name];
    
    if ([model.channelId integerValue]) {
        self.footLabel.hidden = NO;
        HomeModelMenu *menuModel = model.menus[0];
        self.footLabel.text = menuModel.name;
    } else self.footLabel.hidden = YES;
    
}

- (void)setUpWithModelFrame:(HomeModelFrame *)modelFrame {
    self.headImageView.frame = modelFrame.headImageViewF;
    self.headLabel.frame = modelFrame.headLabelF;
    self.mainCollectionView.frame = modelFrame.collectionViewF;
    self.footLabel.frame = modelFrame.footLabelF;
}

#pragma mark - Private

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_headImageView];
    }
    return _headImageView;
}

- (UILabel *)headLabel {
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]init];
        _headLabel.font = kMainLabelFont;
        _headLabel.textAlignment = NSTextAlignmentLeft;
        _headLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_headLabel];
        
    }
    return _headLabel;
}

- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.scrollEnabled = NO;
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        [_mainCollectionView registerClass:[CollectionViewVerticalCell class] forCellWithReuseIdentifier:CollecionViewVerticalCellID];
        [self.contentView addSubview:_mainCollectionView];
    }
    return _mainCollectionView;
}

- (UILabel *)footLabel {
    if (!_footLabel) {
        _footLabel = [[UILabel alloc]init];
        _footLabel.font = kSubLabelFont;
        _footLabel.textColor = kMyRed;
        _footLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_footLabel];
    }
    return _footLabel;
}

- (HomeModel *)homeModel {
    if (!_homeModel) {
        _homeModel = [[HomeModel alloc]init];
    }
    return _homeModel;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.homeModel.contents.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewVerticalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollecionViewVerticalCellID forIndexPath:indexPath];
    HomeModelContent *subModel = self.homeModel.contents[indexPath.row];
    [cell setUpCollectionVerticalCellWithModel:subModel];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(bangumisCellDidSelectRowAtURL:)]) {
        HomeModelContent *subModel = self.homeModel.contents[indexPath.row];
        [self.delegate bangumisCellDidSelectRowAtURL:subModel.url];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kCustomPadding;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(235, 360);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}



@end
