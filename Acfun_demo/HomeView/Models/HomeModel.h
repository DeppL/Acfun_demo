//
//  HomeModel.h
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


@interface HomeModel : NSObject

@property (nonatomic, copy) NSString *belong;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *contentCount;
@property (nonatomic, copy) NSArray *contents;                // ~~ HomeModelContent ~~
@property (nonatomic, copy) NSString *goText;
@property (nonatomic, copy) NSString *hide;
@property (nonatomic, copy) NSString *homeId;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *menuCount;
@property (nonatomic, copy) NSArray *menus;                   // ~~ HomeModelMenu ~~
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *platformId;
@property (nonatomic, copy) NSString *showLine;
@property (nonatomic, copy) NSString *showMore;
@property (nonatomic, copy) NSString *showName;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, strong) HomeModelType *type;            // ~~ HomeModelType ~~
@property (nonatomic, copy) NSString *url;

+ (HomeModelContent *)getSubHomeModelInModelArr:(NSArray *)arr withSection:(NSInteger)section andRow:(NSInteger)row;


@end
