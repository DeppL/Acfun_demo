//
//  ClassifierViewCollectionReusableView.h
//  Acfun_demo
//
//  Created by DeppL on 16/3/2.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const ClassifierViewCollectionReusableViewID;

@interface ClassifierViewCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *mainLabel;

@end
