//
//  CollectionFootView.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/17.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const collectionFootViewID = @"collectionFootViewID";

@interface CollectionFootView : UICollectionReusableView

@property (nonatomic, strong) UILabel *footLable;

@property (nonatomic, strong) UIView *whiteView;

@end
