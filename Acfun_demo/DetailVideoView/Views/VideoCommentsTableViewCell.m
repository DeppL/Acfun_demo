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

NSString * const VideoCommentsTableViewCellID = @"VideoCommentsTableViewCellID";

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
    [self.userAvatar sd_setImageWithURL:url placeholderImage:IMAGE(@"placeHolder")];
    self.userNameLabel.text = model.username;
    NSString *releaseTimeStr = [NSDate dateCompareWithReleaseTime:model.time];
    self.releaseDateLabel.text = releaseTimeStr;
    NSString *floorStr = [NSString stringWithFormat:@"#%@",model.floor];
    self.floorLabel.text = floorStr;
    
    NSString *string = [model.content stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    self.commentContentLabel.text = string;
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
        _userAvatar = [[UIImageView alloc]init];
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
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.font = [UIFont systemFontOfSize:17];
        _userNameLabel.textColor = [UIColor grayColor];
        _userNameLabel.backgroundColor = kMyWhite;
        [self.contentView addSubview:_userNameLabel];
        
    }
    return _userNameLabel;
}

- (UILabel *)releaseDateLabel {
    if (!_releaseDateLabel) {
        _releaseDateLabel = [[UILabel alloc]init];
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
        _floorLabel = [[UILabel alloc]init];
        _floorLabel.textColor = [UIColor grayColor];
        _floorLabel.font = [UIFont systemFontOfSize:15];
        _floorLabel.backgroundColor = kMyWhite;
        _floorLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_floorLabel];
    }
    return _floorLabel;
}

- (UILabel *)commentContentLabel {
    if (!_commentContentLabel) {
        _commentContentLabel = [[UILabel alloc]init];
        _commentContentLabel.font = [UIFont systemFontOfSize:18];
        _commentContentLabel.numberOfLines = 0;
        _commentContentLabel.backgroundColor = kMyWhite;
        [self.contentView addSubview:_commentContentLabel];
    }
    return _commentContentLabel;
}

@end
