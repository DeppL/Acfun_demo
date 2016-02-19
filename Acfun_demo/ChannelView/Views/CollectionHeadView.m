//
//  CollectionHeadView.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/17.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "CollectionHeadView.h"

@implementation CollectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _headButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _headButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _headButton.backgroundColor = kMyWhite;
        [self addSubview:_headButton];
    }
    return self;
}

@end
