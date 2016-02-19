//
//  VideoTableViewCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/13.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "DetailVideoModel.h"

#define kVideoViewFHight 300
NSString * const VideoTableViewCellID = @"VideoTableViewCellID";

@interface VideoTableViewCell ()

@property (nonatomic, strong) UIImageView *videoImageView;

@end

@implementation VideoTableViewCell

- (void)setUpVideoTableViewCellWithModel:(DetailVideoModel *)model {
    NSURL *url = [NSURL URLWithString:model.cover];
    [self.videoImageView sd_setImageWithURL:url placeholderImage:IMAGE(@"placeHolder") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if ([image images]) {
            UIImage *staticImage = [image images][0];
            self.videoImageView.image = staticImage;
        }
    }];
}


- (UIImageView *)videoImageView {
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 400)];
        _videoImageView.contentMode = UIViewContentModeScaleToFill;
        _videoImageView.backgroundColor = kMyWhite;
        [self.contentView addSubview:_videoImageView];
    }
    return _videoImageView;
}

@end
