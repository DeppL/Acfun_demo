//
//  ClassifierViewModel.h
//  Acfun_demo
//
//  Created by DeppL on 16/3/1.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClassifierViewVideoUserModel;

@interface ClassifierViewModel : NSObject

@property (nonatomic, copy) NSString *pageNo;
@property (nonatomic, copy) NSString *pageSize;
@property (nonatomic, copy) NSString *totalCount;
@property (nonatomic, copy) NSArray *list;

@end


@interface ClassifierViewVideoModel : NSObject

@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *contentId;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *danmakuSize;
@property (nonatomic, copy) NSString *myDescription;
@property (nonatomic, copy) NSString *isArticle;
@property (nonatomic, copy) NSString *isRecommend;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSString *stows;
@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) ClassifierViewVideoUserModel *user;
@property (nonatomic, copy) NSString *viewOnly;
@property (nonatomic, copy) NSString *views;


@end


@interface ClassifierViewVideoUserModel : NSObject

@property (nonatomic, copy) NSString *userImg;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *username;

@end
