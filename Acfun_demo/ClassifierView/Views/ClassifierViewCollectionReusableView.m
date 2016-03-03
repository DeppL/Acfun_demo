//
//  ClassifierViewCollectionReusableView.m
//  Acfun_demo
//
//  Created by DeppL on 16/3/2.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "ClassifierViewCollectionReusableView.h"

NSString * const ClassifierViewCollectionReusableViewID = @"ClassifierViewCollectionReusableViewID";

@interface ClassifierViewCollectionReusableView ()

@end

@implementation ClassifierViewCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainImageView];
        [self addSubview:self.mainLabel];
    }
    return self;
}


- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        CGRect rect = CGRectMake(kCustomPadding, kCustomPadding, 25, 25);
        _mainImageView = [[UIImageView alloc]initWithFrame:rect];
    }
    return _mainImageView;
}

- (UILabel *)mainLabel {
    if (!_mainLabel) {
        CGRect rect = CGRectMake(55, 0, 200, 55);
        _mainLabel = [[UILabel alloc]initWithFrame:rect];
    }
    return _mainLabel;
}

@end
