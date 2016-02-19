//
//  VideoDescriptionTableViewCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/14.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "VideoDescriptionTableViewCell.h"
#import "DetailVideoModel.h"

NSString * const VideoDescriptionTableViewCellID = @"VideoDescriptionTableViewCellID";

@interface VideoDescriptionTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLable;

@property (nonatomic ,strong) UILabel *subLabel;

@property (nonatomic ,strong) UILabel *descriptionLabel;

@end

@implementation VideoDescriptionTableViewCell

- (void)setUpVideoDescriptionTableViewCellWithModel:(DetailVideoModel *)model {
    self.titleLable.text = model.title;
    
    NSString *str = [NSString stringWithFormat:@"播放：%@  评论：%@  香蕉：%@",model.visit.views,model.visit.comments,model.visit.goldBanana];
    self.subLabel.text = str;
    self.descriptionLabel.text = model.descriptionText;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        CGRect rect = CGRectMake(10, 0, kDeviceWidth - 20, 44);
        _titleLable = [[UILabel alloc]initWithFrame:rect];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.font = [UIFont systemFontOfSize:18];
        _titleLable.backgroundColor = kMyWhite;
        [self.contentView addSubview:_titleLable];
    }
    return _titleLable;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        CGRect rect = CGRectMake(10, 44, kDeviceWidth - 20, 20);
        _subLabel = [[UILabel alloc]initWithFrame:rect];
        _subLabel.textAlignment = NSTextAlignmentLeft;
        _subLabel.font = [UIFont systemFontOfSize:12];
        _subLabel.textColor = [UIColor grayColor];
        _subLabel.backgroundColor = kMyWhite;
        [self.contentView addSubview:_subLabel];
    }
    return _subLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        CGRect rect = CGRectMake(10, 64, kDeviceWidth - 20, 40);
        _descriptionLabel = [[UILabel alloc]initWithFrame:rect];
        _descriptionLabel.font = [UIFont systemFontOfSize:14];
        _descriptionLabel.textColor = [UIColor grayColor];
        _descriptionLabel.backgroundColor = kMyWhite;
        _descriptionLabel.numberOfLines = 0;
        [self.contentView addSubview:_descriptionLabel];
    }
    return _descriptionLabel;
}

@end
