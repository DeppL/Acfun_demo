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
NSString * const DetailVideoTableViewCellImageCompleted = @"DetailVideoTableViewCellImageCompleted";
@interface VideoTableViewCell ()

@property (nonatomic, strong) UIImageView *videoImageView;

@end

@implementation VideoTableViewCell

- (void)setUpVideoTableViewCellWithModel:(DetailVideoModel *)model {
    
    if (!model) return;
    NSURL *url = [NSURL URLWithString:model.cover];
    [self.videoImageView sd_setImageWithURL:url placeholderImage:IMAGE(@"placeHolderPic") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIImage *staticImage;
        if ([image images]) {
            staticImage = [image images][0];
        }
        else {
            staticImage = image;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:DetailVideoTableViewCellImageCompleted object:staticImage];
        
    }];
}

- (void)setUpVideoTableViewCellWithImage:(UIImage *)image {
    self.videoImageView.image = image;
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
