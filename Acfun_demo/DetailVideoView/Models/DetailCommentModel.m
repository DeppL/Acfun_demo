//
//  DetailCommentModel.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/14.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "DetailCommentModel.h"

@implementation DetailCommentModel

@end

@implementation DetailCommentModelPage

@end

@implementation DetailCommentModelComment

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"commentId" : @"id"
             };
}


@end