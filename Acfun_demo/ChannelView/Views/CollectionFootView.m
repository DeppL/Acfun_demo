//
//  CollectionFootView.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/17.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "CollectionFootView.h"

@implementation CollectionFootView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _footLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 5)];
        _footLable.textColor = kMyRed;
        _footLable.font = [UIFont systemFontOfSize:15];
        _footLable.textAlignment = NSTextAlignmentCenter;
        _footLable.backgroundColor = kMyWhite;
        
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 5, frame.size.width, 5)];
        _whiteView.backgroundColor = RGBA(240, 240, 240, 1.0);
        
        [self addSubview:_footLable];
        [self addSubview:_whiteView];
    }
    return self;
}


@end
