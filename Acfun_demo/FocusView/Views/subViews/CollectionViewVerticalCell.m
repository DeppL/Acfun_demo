//
//  CollectionViewVerticalCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/28.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "CollectionViewVerticalCell.h"
//#import "HomeModel.h"
#import "HomeModelConfig.h"

#define kMainLabelFont [UIFont systemFontOfSize:16]

#define kSubLabelFont [UIFont systemFontOfSize:14]

@interface CollectionViewVerticalCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *mainLabel;

@property (nonatomic, strong) UILabel *subLabel;

@end

@implementation CollectionViewVerticalCell

- (UIImageView *)imageView {
    if (!_imageView) {
        CGRect rect = CGRectMake(0, 0, 235, 310);
        _imageView = [[UIImageView alloc]initWithFrame:rect];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)mainLabel {
    if (!_mainLabel) {
        CGRect rect = CGRectMake(0, 310, 235, 30);
        _mainLabel = [[UILabel alloc]initWithFrame:rect];
        _mainLabel.font = kMainLabelFont;
        _mainLabel.textAlignment = NSTextAlignmentLeft;
        _mainLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_mainLabel];
    }
    return _mainLabel;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        CGRect rect = CGRectMake(0, 340, 235, 15);
        _subLabel = [[UILabel alloc]initWithFrame:rect];
        _subLabel.font = kSubLabelFont;
        _subLabel.textAlignment = NSTextAlignmentLeft;
        _subLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_subLabel];
    }
    return _subLabel;
}

- (void)setUpCollectionVerticalCellWithModel:(HomeModelContent *)model {
    UIImage *image = [UIImage imageNamed:@"placeHolder"];
    NSURL *url = [NSURL URLWithString:model.image];
    [self.imageView sd_setImageWithURL:url placeholderImage:image];
    
    [self.mainLabel setText:model.title];
    
    [self.subLabel setText:model.latestBangumiVideo.title];
}


@end
