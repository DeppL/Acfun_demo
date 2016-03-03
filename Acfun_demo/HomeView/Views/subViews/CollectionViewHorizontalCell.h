//
//  CollectionViewHorizontalCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/28.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModelContent;
@class ClassifierViewVideoModel;

extern NSString * const CollecionViewHorizontalCellID;

@interface CollectionViewHorizontalCell : UICollectionViewCell

- (void)setUpCollectionHorizontalCellWithHomeModel:(HomeModelContent *)model;

- (void)setUpCollectionHorizontalCellWithClassifierViewVideoModel:(ClassifierViewVideoModel *)model;

@end
