//
//  TableViewArticlesCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/26.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "TableViewArticlesCell.h"
#import "TableViewSubArticleCell.h"
//#import "HomeModel.h"
#import "HomeModelConfig.h"

#define kMainLabelFont [UIFont systemFontOfSize:18]

#define kSubLabelFont [UIFont systemFontOfSize:14]

@interface TableViewArticlesCell () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *headLabel;

@property (nonatomic, strong) UILabel *footLabel;

@property (nonatomic, strong) HomeModel *homeModel;

@end

@implementation TableViewArticlesCell

#pragma mark - Public
#pragma mark -

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
    self.mainTableView.frame = modelFrame.tableViewF;
    self.footLabel.frame = modelFrame.footLabelF;
}


#pragma mark - Private
#pragma mark -


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

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]init];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.scrollEnabled = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        _mainTableView.showsVerticalScrollIndicator = NO;
//        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:[TableViewSubArticleCell class] forCellReuseIdentifier:TableViewSubArticleCellID];
        [self.contentView addSubview:_mainTableView];
    }
    return _mainTableView;
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeModel.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSubArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewSubArticleCellID forIndexPath:indexPath];
    HomeModelContent *subModel = self.homeModel.contents[indexPath.row];
    
    [cell setUpTableViewArticleCellWithModel:subModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(articleCellDidSelectRowAtURL:)]) {
        HomeModelContent *subModel = self.homeModel.contents[indexPath.row];
        [self.delegate articleCellDidSelectRowAtURL:subModel.url];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
