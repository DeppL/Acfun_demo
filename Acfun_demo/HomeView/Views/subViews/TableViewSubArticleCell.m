//
//  TableViewSubArticleCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/28.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "TableViewSubArticleCell.h"
//#import "HomeModel.h"
#import "HomeModelConfig.h"

@interface TableViewSubArticleCell ()

@property (nonatomic, strong) UILabel *articlePathLabel;

@property (nonatomic, strong) UILabel *commentsCountLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *commentsLabel;

@property (nonatomic, strong) UILabel *ownerSubLabel;

@property (nonatomic, strong) UILabel *viewsLabel;

@end


@implementation TableViewSubArticleCell



#pragma mark - Public
#pragma mark -

- (void)setUpTableViewArticleCellWithModel:(HomeModelContent *)model {
    self.articlePathLabel.text = @"/ 来自";
    
    self.commentsCountLabel.text = model.visit.comments;
    
    self.titleLabel.text = model.title;
    
    self.commentsLabel.text = @"评论";
    
    self.ownerSubLabel.text = [NSString stringWithFormat:@"UP主：%@", model.owner.name];
    
    if ([model.visit.views integerValue] > 9000) {
        NSString *str = [NSString stringWithFormat:@"观看 %.1f万",[model.visit.views integerValue] / 10000.0];
        self.viewsLabel.text = str;
    }
    else {
        NSString *str = [NSString stringWithFormat:@"观看 %@",model.visit.views];
        self.viewsLabel.text = str;
    }
}


#pragma mark - Private
#pragma mark -

- (UILabel *)articlePathLabel {
    if (!_articlePathLabel) {
        CGRect rect = CGRectMake(kCustomPadding, 10, kDeviceWidth, 20);
        _articlePathLabel = [[UILabel alloc]initWithFrame:rect];
        _articlePathLabel.font = [UIFont systemFontOfSize:10];
        _articlePathLabel.textColor = [UIColor grayColor];
        _articlePathLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_articlePathLabel];
    }
    return _articlePathLabel;
}

- (UILabel *)commentsCountLabel {
    if (!_commentsCountLabel) {
        CGRect rect = CGRectMake(kCustomPadding, 40, 40, 20);
        _commentsCountLabel = [[UILabel alloc]initWithFrame:rect];
        _commentsCountLabel.font = [UIFont systemFontOfSize:18];
        _commentsCountLabel.textColor = [UIColor redColor];
        _commentsCountLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_commentsCountLabel];
    }
    return _commentsCountLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGRect rect = CGRectMake(40 + 2 * kCustomPadding, 40, kDeviceWidth - 60, 20);
        _titleLabel = [[UILabel alloc]initWithFrame:rect];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)commentsLabel {
    if (!_commentsLabel) {
        CGRect rect = CGRectMake(kCustomPadding, 70, 40, 20);
        _commentsLabel = [[UILabel alloc]initWithFrame:rect];
        _commentsLabel.font = [UIFont systemFontOfSize:12];
        _commentsLabel.textColor = [UIColor grayColor];
        _commentsLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_commentsLabel];
    }
    return _commentsLabel;
}


- (UILabel *)ownerSubLabel {
    if (!_ownerSubLabel) {
        CGRect rect = CGRectMake(40 + 2 * kCustomPadding, 70, kDeviceWidth - 60, 20);
        _ownerSubLabel = [[UILabel alloc]initWithFrame:rect];
        _ownerSubLabel.font = [UIFont systemFontOfSize:12];
        _ownerSubLabel.textColor = [UIColor grayColor];
        _ownerSubLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_ownerSubLabel];
    }
    return _ownerSubLabel;
}

- (UILabel *)viewsLabel {
    if (!_viewsLabel) {
        CGRect rect = CGRectMake(kDeviceWidth - 70, 70, 60, 15);
        _viewsLabel = [[UILabel alloc]initWithFrame:rect];
        _viewsLabel.font = [UIFont systemFontOfSize:10];
        _viewsLabel.textColor = [UIColor grayColor];
        _viewsLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_viewsLabel];
    }
    return _viewsLabel;
}




@end
