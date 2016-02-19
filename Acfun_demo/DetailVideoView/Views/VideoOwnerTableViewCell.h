//
//  VideoOwnerTableViewCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/14.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailVideoModel;
extern NSString * const VideoOwnerTableViewCellID;

@interface VideoOwnerTableViewCell : UITableViewCell

- (void)setUpVideoOwnerTableViewCellWithModel:(DetailVideoModel *)model;

@end
