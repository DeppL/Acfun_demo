//
//  ClassifierViewNormalCollectionViewCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/3/2.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClassifierViewVideoModel;

extern NSString * const ClassifierViewNormalCollectionViewCellID;

@interface ClassifierViewNormalCollectionViewCell : UICollectionViewCell

- (void)setUpWithNormalModel:(ClassifierViewVideoModel *)model;

@end
