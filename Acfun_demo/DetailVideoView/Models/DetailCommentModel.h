//
//  DetailCommentModel.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/14.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailCommentModelPage;

@interface DetailCommentModel : NSObject

@property (nonatomic, copy) NSString *cache;
@property (nonatomic, strong) DetailCommentModelPage *page;

@end

@interface DetailCommentModelPage : NSObject

@property (nonatomic, copy) NSString *totalCount;
@property (nonatomic, copy) NSString *pageSize;
@property (nonatomic, copy) NSString *pageNo;
@property (nonatomic, copy) NSArray *list;
@property (nonatomic, copy) NSDictionary *map;

@end


@interface DetailCommentModelComment : NSObject

@property (nonatomic, copy) NSString *commentId;
@property (nonatomic, copy) NSString *quoteId;
@property (nonatomic, copy) NSString *refCount;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *floor;
@property (nonatomic, copy) NSString *deep;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *contentId;
@property (nonatomic, copy) NSString *isAt;
@property (nonatomic, copy) NSString *nameRed;
@property (nonatomic, copy) NSString *avatarFrame;


@end


