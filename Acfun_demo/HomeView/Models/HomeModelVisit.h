//
//  HomeModelVisit.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/28.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeModelType;
@class HomeModelVisit;
@class HomeModelOwner;
@class HomeModelContent;
@class HomeModelLatestBangumiVideo;

@interface HomeModelVisit : NSObject

@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *danmakuSize;
@property (nonatomic, copy) NSString *goldBanana;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *stows;
@property (nonatomic, copy) NSString *ups;
@property (nonatomic, copy) NSString *views;

@end
