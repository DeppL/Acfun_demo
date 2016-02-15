//
//  VideoCommentsTableViewCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/14.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "VideoCommentsTableViewCell.h"
#import "DetailCommentModel.h"
#import "DetailCommentModelFrame.h"

#import "NSDate+ReleaseTime.h"

@interface VideoCommentsTableViewCell ()

@property (nonatomic, strong) UIImageView *userAvatar;

@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UILabel *releaseDateLabel;

@property (nonatomic, strong) UILabel *floorLabel;

@property (nonatomic, strong) UILabel *commentContentLabel;



@end

@implementation VideoCommentsTableViewCell

- (void)setUpVideoCommentsTableViewCellWithModel:(DetailCommentModelComment *)model {
    NSURL *url = [NSURL URLWithString:model.avatar];
    [self.userAvatar sd_setImageWithURL:url];
    self.userNameLabel.text = model.username;
    NSString *releaseTimeStr = [NSDate compareWithReleaseTime:model.time];
    self.releaseDateLabel.text = releaseTimeStr;
    NSString *floorStr = [NSString stringWithFormat:@"#%@",model.floor];
    self.floorLabel.text = floorStr;
    self.commentContentLabel.text = model.content;
}

- (void)setUpVideoCommentsTableViewCellFrameWithModel:(DetailCommentModelFrame *)commentModelCommentF {
    self.userAvatar.frame = commentModelCommentF.userAvatarF;
    self.userNameLabel.frame = commentModelCommentF.userNameLabelF;
    self.releaseDateLabel.frame = commentModelCommentF.releaseDateLabelF;
    self.floorLabel.frame = commentModelCommentF.floorLabelF;
    self.commentContentLabel.frame = commentModelCommentF.commentContentLabelF;
    
}

- (UIImageView *)userAvatar {
    if (!_userAvatar) {
        CGRect rect = CGRectMake(10, 10, 70, 70);
        _userAvatar = [[UIImageView alloc]initWithFrame:rect];
        _userAvatar.layer.cornerRadius = 50.0;
        _userAvatar.layer.masksToBounds = YES;
        _userAvatar.contentMode = UIViewContentModeScaleToFill;
        _userAvatar.backgroundColor = kMyWhite;
        [self.contentView addSubview:_userAvatar];
    }
    return _userAvatar;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        CGRect rect = CGRectMake(100, 10, 400, 35);
        _userNameLabel = [[UILabel alloc]initWithFrame:rect];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.font = [UIFont systemFontOfSize:21];
        _userNameLabel.backgroundColor = kMyWhite;
        [self.contentView addSubview:_userNameLabel];
        
    }
    return _userNameLabel;
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

- (UILabel *)floorLabel {
    if (!_floorLabel) {
        CGRect rect = CGRectMake(kDeviceWidth - 100, 10, 100, 70);
        _floorLabel = [[UILabel alloc]initWithFrame:rect];
        _floorLabel.textColor = [UIColor grayColor];
        _floorLabel.backgroundColor = kMyWhite;
        [self.contentView addSubview:_floorLabel];
    }
    return _floorLabel;
}

- (UILabel *)commentContentLabel {
    if (!_commentContentLabel) {
        CGRect rect = CGRectMake(10, 90, kDeviceWidth - 20, 100);
        _commentContentLabel = [[UILabel alloc]initWithFrame:rect];
        _commentContentLabel.numberOfLines = 0;
        [self.contentView addSubview:_commentContentLabel];
    }
    return _commentContentLabel;
}

@end
