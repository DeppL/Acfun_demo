//
//  TableViewSubArticleCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/28.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModelContent;

static NSString * const TableViewSubArticleCellID = @"TableViewSubArticleCellID";


@interface TableViewSubArticleCell : UITableViewCell

- (void)setUpTableViewArticleCellWithModel:(HomeModelContent *)model;

@end
