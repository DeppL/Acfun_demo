//
//  HomeCollectionFootView.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/20.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "HomeCollectionFootView.h"

@implementation HomeCollectionFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _footLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 5)];
        _footLable.textColor = kMyRed;
        _footLable.font = [UIFont systemFontOfSize:15];
        _footLable.textAlignment = NSTextAlignmentCenter;
        
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 5, frame.size.width, 5)];
        whiteView.backgroundColor = RGBA(240, 240, 240, 1.0);
        [self addSubview:_footLable];
        [self addSubview:whiteView];
    }
    return self;
}


@end
