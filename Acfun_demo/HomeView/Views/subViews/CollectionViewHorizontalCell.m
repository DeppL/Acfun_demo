//
//  CollectionViewHorizontalCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/28.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "CollectionViewHorizontalCell.h"
//#import "HomeModel.h"
#import "HomeModelConfig.h"

#define kMainLabelFont [UIFont systemFontOfSize:16]

#define kSubLabelFont [UIFont systemFontOfSize:14]


@interface CollectionViewHorizontalCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *mainLabel;

@property (nonatomic, strong) UILabel *playCountLabel;

@property (nonatomic, strong) UILabel *danmakuSizeLabel;

@end

@implementation CollectionViewHorizontalCell

- (UIImageView *)imageView {
    if (!_imageView) {
        CGRect rect = CGRectMake(0, 0, 360, 200);
        _imageView = [[UIImageView alloc]initWithFrame:rect];
        _imageView.layer.cornerRadius = 5.0f;
        _imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)mainLabel {
    if (!_mainLabel) {
        CGRect rect = CGRectMake(0, 200, 360, 30);
        _mainLabel = [[UILabel alloc]initWithFrame:rect];
        _mainLabel.font = kMainLabelFont;
        _mainLabel.textAlignment = NSTextAlignmentLeft;
        _mainLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_mainLabel];
    }
    return _mainLabel;
}

- (UILabel *)playCountLabel {
    if (!_playCountLabel) {
        CGRect rect = CGRectMake(0, 230, 100, 20);
        _playCountLabel = [[UILabel alloc]initWithFrame:rect];
        _playCountLabel.font = kSubLabelFont;
        _playCountLabel.textAlignment = NSTextAlignmentLeft;
        _playCountLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_playCountLabel];

    }
    return _playCountLabel;
}

- (UILabel *)danmakuSizeLabel {
    if (!_danmakuSizeLabel) {
        CGRect rect = CGRectMake(100, 230, 150, 20);
        _danmakuSizeLabel = [[UILabel alloc]initWithFrame:rect];
        _danmakuSizeLabel.font = kSubLabelFont;
        _danmakuSizeLabel.textAlignment = NSTextAlignmentLeft;
        _danmakuSizeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_danmakuSizeLabel];
    }
    return _danmakuSizeLabel;
}

- (void)setUpCollectionHorizontalCellWithModel:(HomeModelContent *)model {
    UIImage *image = [UIImage imageNamed:@"placeHolder"];
    NSURL *url = [NSURL URLWithString:model.image];
    [self.imageView sd_setImageWithURL:url placeholderImage:image];
    
    [self.mainLabel setText:model.title];
    
    
    if ([model.visit.views integerValue] > 9000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"播放 %.1f万",[model.visit.views integerValue] / 10000.0];
    }
    else {
        self.playCountLabel.text = [NSString stringWithFormat:@"播放 %@",model.visit.views];
    }
    
    
    if ([model.visit.danmakuSize integerValue] > 9000) {
        self.danmakuSizeLabel.text = [NSString stringWithFormat:@"弹幕 %.1f万",[model.visit.danmakuSize integerValue] / 10000.0];
    }
    else {
        self.danmakuSizeLabel.text = [NSString stringWithFormat:@"弹幕 %@",model.visit.danmakuSize];
    }

}

@end
