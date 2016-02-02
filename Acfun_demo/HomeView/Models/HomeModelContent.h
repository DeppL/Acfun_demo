//
//  HomeModelContent.h
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



@interface HomeModelContent : NSObject

@property (nonatomic, copy) NSString *actionId;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *hide;
@property (nonatomic, copy) NSString *contentId;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, strong) HomeModelLatestBangumiVideo *latestBangumiVideo;
@property (nonatomic, strong) HomeModelOwner *owner;
@property (nonatomic, copy) NSString *regionId;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSString *releasedAt;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subUrl;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) HomeModelVisit *visit;

@end
