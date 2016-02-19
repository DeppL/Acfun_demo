//
//  CollectionViewVerticalCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/28.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModelContent;

extern NSString * const CollecionViewVerticalCellID;

@interface CollectionViewVerticalCell : UICollectionViewCell

- (void)setUpCollectionVerticalCellWithModel:(HomeModelContent *)model;

@end
