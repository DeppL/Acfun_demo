//
//  VideoDescriptionTableViewCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/14.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailVideoModel;
extern NSString * const VideoDescriptionTableViewCellID;

@interface VideoDescriptionTableViewCell : UITableViewCell

- (void)setUpVideoDescriptionTableViewCellWithModel:(DetailVideoModel *)model;

@end
