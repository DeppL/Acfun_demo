//
//  VideoOwnerTableViewCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/14.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "VideoOwnerTableViewCell.h"
#import "DetailVideoModel.h"
#import "NSDate+ReleaseTime.h"

@interface VideoOwnerTableViewCell ()

@property (nonatomic, strong) UIImageView *ownerAvatar;

@property (nonatomic, strong) UILabel *ownerName;

@property (nonatomic, strong) UILabel *releaseDateLabel;

@property (nonatomic, strong) UIButton *followedButten;

@property (nonatomic, assign) BOOL followedState;

@end

@implementation VideoOwnerTableViewCell

- (void)setUpVideoOwnerTableViewCellWithModel:(DetailVideoModel *)model {
    NSURL *url = [NSURL URLWithString:model.owner.avatar];
    [self.ownerAvatar sd_setImageWithURL:url];
    self.ownerName.text = model.owner.name;
    
    NSString *str = [NSDate compareWithReleaseTime:model.releaseDate];
    self.releaseDateLabel.text = str;
    [self.contentView addSubview:self.followedButten];
    self.followedState = NO;
}

#pragma mark - private

//- (NSString *)compareWithReleaseTime:(NSString *)interval {
//    
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval floatValue]/1000];
//    NSTimeInterval timeInterval = date.timeIntervalSinceNow * -1;
//    
//    
//    if (timeInterval <= 60 * 2) {
//        return @"刚刚发布";
//    }
//    else if (timeInterval > 60 * 2 && timeInterval <= 60 * 60) {
//        NSString *mmStr = [NSString stringWithFormat:@"%d分钟前发布",((int)timeInterval / 60)];
//        return mmStr;
//    }
//    else if (timeInterval > 60 *60 && timeInterval <= 60 *60 *24) {
//        NSString *hhStr = [NSString stringWithFormat:@"%d小时前发布",((int)timeInterval / 60 / 60)];
//        return hhStr;
//    }else {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
//        NSString *str = [dateFormatter stringFromDate:date];
//        NSString *ddStr = [NSString stringWithFormat:@"于%@发布",str];
//        return ddStr;
//    }
//    
//}

- (UIImageView *)ownerAvatar {
    if (!_ownerAvatar) {
        CGRect rect = CGRectMake(10, 10, 70, 70);
        _ownerAvatar = [[UIImageView alloc]initWithFrame:rect];
        _ownerAvatar.layer.cornerRadius = 50.0;
        _ownerAvatar.layer.masksToBounds = YES;
        _ownerAvatar.contentMode = UIViewContentModeScaleToFill;
        _ownerAvatar.backgroundColor = kMyWhite;
        [self.contentView addSubview:_ownerAvatar];
    }
    return _ownerAvatar;
}

- (UILabel *)ownerName {
    if (!_ownerName) {
        CGRect rect = CGRectMake(100, 10, 400, 35);
        _ownerName = [[UILabel alloc]initWithFrame:rect];
        _ownerName.textAlignment = NSTextAlignmentLeft;
        _ownerName.font = [UIFont systemFontOfSize:21];
        _ownerName.backgroundColor = kMyWhite;
        [self.contentView addSubview:_ownerName];

    }
    return _ownerName;
}

- (UILabel *)releaseDateLabel {
    if (!_releaseDateLabel) {
        CGRect rect = CGRectMake(100, 45, 400, 35);
        _releaseDateLabel = [[UILabel alloc]initWithFrame:rect];
        _releaseDateLabel.textAlignment = NSTextAlignmentLeft;
        _releaseDateLabel.font = [UIFont systemFontOfSize:15];
        _releaseDateLabel.textColor = [UIColor grayColor];
        _releaseDateLabel.backgroundColor = kMyWhite;
        [self.contentView addSubview:_releaseDateLabel];

    }
    return _releaseDateLabel;
}

- (UIButton *)followedButten {
    if (!_followedButten) {
        CGRect rect = CGRectMake(kDeviceWidth - 100, 15, 100, 40);
        _followedButten = [[UIButton alloc]initWithFrame:rect];
        [_followedButten setTitle:@"关注" forState:UIControlStateNormal];
        [_followedButten setTitleColor:kMyRed forState:UIControlStateNormal];
        [_followedButten addTarget:self action:@selector(followedStateChanged) forControlEvents:UIControlEventTouchUpInside];
        _followedButten.backgroundColor = kMyWhite;
    }
    return _followedButten;
}

- (void)followedStateChanged {
    if (self.followedState) {
        [_followedButten setTitle:@"已关注" forState:UIControlStateNormal];
        [_followedButten setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.followedState = NO;
    }
    else {
        [_followedButten setTitle:@"关注" forState:UIControlStateNormal];
        [_followedButten setTitleColor:kMyRed forState:UIControlStateNormal];
        self.followedState = YES;
    }
}

@end
