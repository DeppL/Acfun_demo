//
//  TableViewBannersCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/26.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;
@class HomeModelFrame;

extern NSString * const TableViewBannersCellID;


@interface TableViewBannersCell : UITableViewCell

- (void)setUpWithModel:(HomeModel *)model;

- (void)setUpWithModelFrame:(HomeModelFrame *)modelFrame;

@end
