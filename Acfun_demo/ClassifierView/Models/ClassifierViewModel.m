//
//  ClassifierViewModel.m
//  Acfun_demo
//
//  Created by DeppL on 16/3/1.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "ClassifierViewModel.h"

@implementation ClassifierViewModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ClassifierViewVideoModel"
             };
}

@end


@implementation ClassifierViewVideoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"myDescription" : @"description",
             };
}

@end


@implementation ClassifierViewVideoUserModel

@end
