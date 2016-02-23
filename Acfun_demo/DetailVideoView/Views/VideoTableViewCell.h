//
//  VideoTableViewCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/13.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailVideoModel;

extern NSString * const VideoTableViewCellID;
extern NSString * const DetailVideoTableViewCellImageCompleted;

@interface VideoTableViewCell : UITableViewCell

- (void)setUpVideoTableViewCellWithModel:(DetailVideoModel *)model;

- (void)setUpVideoTableViewCellWithImage:(UIImage *)image;

@end
