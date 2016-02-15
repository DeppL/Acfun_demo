//
//  DetailCommentModelFrame.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/15.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DetailCommentModelFrame : NSObject

@property (nonatomic, assign) CGRect userAvatarF;

@property (nonatomic, assign) CGRect userNameLabelF;

@property (nonatomic, assign) CGRect releaseDateLabelF;

@property (nonatomic, assign) CGRect floorLabelF;

@property (nonatomic, assign) CGRect commentContentLabelF;

@property (nonatomic, assign) CGFloat cellHeight;

+ (NSDictionary *)setUpFrameWithDetailCommentModelDict:(NSDictionary *)detailCommentModelDict;

@end
