//
//  DetailVideoModel.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/3.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DetailVideoModelOwner;
@class DetailVideoModelVisit;

@interface DetailVideoModel : NSObject

@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *contentId;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *descriptionText;
@property (nonatomic, copy) NSString *display;
@property (nonatomic, copy) NSString *isArticle;
@property (nonatomic, copy) NSString *isRecommend;
@property (nonatomic, strong) DetailVideoModelOwner *owner;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *topLevel;
@property (nonatomic, copy) NSString *updatedAt;
@property (nonatomic, copy) NSString *videoCount;
@property (nonatomic, copy) NSArray *videos;
@property (nonatomic, copy) NSString *viewOnly;
@property (nonatomic, strong) DetailVideoModelVisit *visit;


@end

@interface DetailVideoModelOwner : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *ownerId;
@property (nonatomic, copy) NSString *name;

@end

@interface DetailVideoModelVideo : NSObject

@property (nonatomic, copy) NSString *allowDanmaku;
@property (nonatomic, copy) NSString *commentId;
@property (nonatomic, copy) NSString *danmakuId;
@property (nonatomic, copy) NSString *sourceId;
@property (nonatomic, copy) NSString *sourceType;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *videoId;

@end

@interface DetailVideoModelVisit : NSObject

@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *danmakuSize;
@property (nonatomic, copy) NSString *goldBanana;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *stows;
@property (nonatomic, copy) NSString *ups;
@property (nonatomic, copy) NSString *views;

@end

