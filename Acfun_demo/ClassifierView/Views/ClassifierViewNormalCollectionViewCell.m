//
//  ClassifierViewNormalCollectionViewCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/3/2.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "ClassifierViewNormalCollectionViewCell.h"

#import "ClassifierViewModel.h"

NSString * const ClassifierViewNormalCollectionViewCellID = @"ClassifierViewNormalCollectionViewCellID";


@interface ClassifierViewNormalCollectionViewCell ()

@property (nonatomic, strong) UIImageView *mainImageView;

@property (nonatomic, strong) UILabel *mainLabel;

@property (nonatomic, strong) UILabel *subLabel;

@property (nonatomic, strong) UILabel *playCountLabel;

@property (nonatomic, strong) UILabel *danmakuSizeLabel;

@end

@implementation ClassifierViewNormalCollectionViewCell

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    return self;
//}

- (void)setUpWithNormalModel:(ClassifierViewVideoModel *)model {
    NSURL *url = [NSURL URLWithString:model.cover];
    [self.mainImageView sd_setImageWithURL:url placeholderImage:IMAGE(@"placeHolderPic")];
    
    self.mainLabel.text = model.title;
    
    self.subLabel.text = model.myDescription;
    
    if ([model.views integerValue] > 9000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"播放 %.1f万",[model.views integerValue] / 10000.0];
    }
    else {
        self.playCountLabel.text = [NSString stringWithFormat:@"播放 %@",model.views];
    }
    
    if ([model.danmakuSize integerValue] > 9000) {
        self.danmakuSizeLabel.text = [NSString stringWithFormat:@"弹幕 %.1f万",[model.danmakuSize integerValue] / 10000.0];
    }
    else {
        self.danmakuSizeLabel.text = [NSString stringWithFormat:@"弹幕 %@",model.danmakuSize];
    }
}

- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        CGRect rect = CGRectMake(kCustomPadding, kCustomPadding, 150, 110);
        _mainImageView = [[UIImageView alloc]initWithFrame:rect];
        _mainImageView.layer.cornerRadius = 5.0f;
        _mainImageView.layer.masksToBounds = YES;
        _mainImageView.backgroundColor = kMyRed;
        [self.contentView addSubview:_mainImageView];
    }
    return _mainImageView;
}

- (UILabel *)mainLabel {
    if (!_mainLabel) {
        CGRect rect = CGRectMake(180, kCustomPadding, kDeviceWidth - 180, 40);
        _mainLabel = [[UILabel alloc]initWithFrame:rect];
        _mainLabel.font = kMainLabelFont;
        _mainLabel.textAlignment = NSTextAlignmentLeft;
        _mainLabel.textColor = [UIColor blackColor];
        _mainLabel.backgroundColor = kMyWhite;
        [self.contentView addSubview:_mainLabel];
    }
    return _mainLabel;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        CGRect rect = CGRectMake(180, 75, kDeviceWidth - 180, 60);
        _subLabel = [[UILabel alloc]initWithFrame:rect];
        _subLabel.font = [UIFont systemFontOfSize:18];
        _subLabel.textAlignment = NSTextAlignmentLeft;
        _subLabel.textColor = [UIColor blackColor];
        _subLabel.backgroundColor = kMyWhite;
        _subLabel.numberOfLines = 2;
        [self.contentView addSubview:_subLabel];
    }
    return _subLabel;
}

- (UILabel *)playCountLabel {
    if (!_playCountLabel) {
        CGRect rect = CGRectMake(180, 55, 100, 20);
        _playCountLabel = [[UILabel alloc]initWithFrame:rect];
        _playCountLabel.font = kSubLabelFont;
        _playCountLabel.textAlignment = NSTextAlignmentLeft;
        _playCountLabel.textColor = [UIColor grayColor];
        _playCountLabel.backgroundColor = kMyWhite;
        [self.contentView addSubview:_playCountLabel];
        
    }
    return _playCountLabel;
}

- (UILabel *)danmakuSizeLabel {
    if (!_danmakuSizeLabel) {
        CGRect rect = CGRectMake(280, 55, 150, 20);
        _danmakuSizeLabel = [[UILabel alloc]initWithFrame:rect];
        _danmakuSizeLabel.font = kSubLabelFont;
        _danmakuSizeLabel.textAlignment = NSTextAlignmentLeft;
        _danmakuSizeLabel.textColor = [UIColor grayColor];
        _danmakuSizeLabel.backgroundColor = kMyWhite;
        [self.contentView addSubview:_danmakuSizeLabel];
    }
    return _danmakuSizeLabel;
}




@end
