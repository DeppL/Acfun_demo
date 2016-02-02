//
//  ChannelCollectionViewCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/16.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const channelCellID = @"channelCellID";

@interface ChannelCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *subChannelImageView;

@property (nonatomic, strong) UILabel *subChannelLabel;

@end
