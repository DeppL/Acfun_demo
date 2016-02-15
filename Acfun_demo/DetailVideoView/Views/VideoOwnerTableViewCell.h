//
//  VideoOwnerTableViewCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/14.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailVideoModel;
static NSString * const VideoOwnerTableViewCellID = @"VideoOwnerTableViewCellID";

@interface VideoOwnerTableViewCell : UITableViewCell

- (void)setUpVideoOwnerTableViewCellWithModel:(DetailVideoModel *)model;

@end
