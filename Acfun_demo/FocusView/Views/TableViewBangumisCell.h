
//
//  TableViewBangumisCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/26.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;
@class HomeModelFrame;

static NSString * const TableViewBangumisCellID = @"TableViewBangumisCellID";

@protocol TableViewBangumisCellDelegate <NSObject>

@optional
- (void)bangumisCellDidSelectRowAtURL:(NSString *)url;

@end

@interface TableViewBangumisCell : UITableViewCell

@property (nonatomic, weak) id <TableViewBangumisCellDelegate> delegate;

- (void)setUpWithModel:(HomeModel *)model;

- (void)setUpWithModelFrame:(HomeModelFrame *)modelFrame;

@end
