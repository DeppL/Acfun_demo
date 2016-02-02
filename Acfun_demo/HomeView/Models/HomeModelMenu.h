//
//  HomeModelMenu.h
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


@interface HomeModelMenu : NSObject

@property (nonatomic, copy) NSString *actionId;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *hide;
@property (nonatomic, copy) NSString *menuId;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *regionId;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *url;


@end
