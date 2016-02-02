//
//  HomeModelType.h
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

typedef NS_ENUM(NSInteger, HomeViewCellType) {
    HomeViewCellTypeVideos = 1,
    HomeViewCellTypeArticles = 2,
    HomeViewCellTypeBangumis = 3,
    HomeViewCellTypeCarousels = 5,
    HomeViewCellTypeBanners = 6
};


@interface HomeModelType : NSObject

@property (nonatomic, copy) NSNumber *typeId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;

@end
