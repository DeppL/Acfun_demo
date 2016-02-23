//
//  TableViewVideosCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/26.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "TableViewVideosCell.h"
//#import "HomeModel.h"
#import "HomeModelConfig.h"
#import "HomeModelFrame.h"
#import "CollectionViewHorizontalCell.h"

#define kMainLabelFont [UIFont systemFontOfSize:18]

#define kSubLabelFont [UIFont systemFontOfSize:14]

NSString * const TableViewVideosCellID = @"TableViewVideosCellID";

@interface TableViewVideosCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *headLabel;

@property (nonatomic, strong) UILabel *footLabel;

@property (nonatomic, strong) HomeModel *homeModel;

@end

@implementation TableViewVideosCell


#pragma mark - Public
#pragma mark -

- (void)setUpWithModel:(HomeModel *)model {
    
    self.homeModel = model;
    
    if (model.image) {
        NSURL *url = [NSURL URLWithString:model.image];
        UIImage *image = [UIImage imageNamed:@"placeHolder"];
        [self.headImageView sd_setImageWithURL:url placeholderImage:image];
    }
    
    NSString *headLabelText = [NSString stringWithFormat:@"%@ -> %@", model.name, model.homeId];
    self.headLabel.text = headLabelText;
//    [self.headLabel setText:model.name];
    
    
    if ([model.channelId integerValue]) {
        self.footLabel.hidden = NO;
        HomeModelMenu *menuModel = model.menus[0];
        self.footLabel.text = menuModel.name;
        
    } else {
        self.footLabel.hidden = YES;
    }
    
    [self.mainCollectionView reloadData];
}

- (void)setUpWithModelFrame:(HomeModelFrame *)modelFrame {
    self.headImageView.frame = modelFrame.headImageViewF;
    self.headLabel.frame = modelFrame.headLabelF;
    self.mainCollectionView.frame = modelFrame.collectionViewF;
    self.footLabel.frame = modelFrame.footLabelF;
}

#pragma mark - Private
#pragma mark -

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.backgroundColor = kMyWhite;
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
        _headLabel.backgroundColor = kMyWhite;
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
        _mainCollectionView.backgroundColor = kMyWhite;
        [_mainCollectionView registerClass:[CollectionViewHorizontalCell class] forCellWithReuseIdentifier:CollecionViewHorizontalCellID];
        
        
        [self.contentView addSubview:_mainCollectionView];
    }
    return _mainCollectionView;
}

- (UILabel *)footLabel {
    if (!_footLabel) {
        _footLabel = [[UILabel alloc]init];
        _footLabel.font = kSubLabelFont;
        _footLabel.textColor = kMyRed;
        _footLabel.backgroundColor = kMyWhite;
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
    CollectionViewHorizontalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollecionViewHorizontalCellID forIndexPath:indexPath];
    HomeModelContent *subModel = self.homeModel.contents[indexPath.row];
    [cell setUpCollectionHorizontalCellWithModel:subModel];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(videosCellDidSelectRowAtURL:)]) {
        HomeModelContent *subModel = self.homeModel.contents[indexPath.row];
        [self.delegate videosCellDidSelectRowAtURL:subModel.url];
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 35;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(360, 250);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

@end
