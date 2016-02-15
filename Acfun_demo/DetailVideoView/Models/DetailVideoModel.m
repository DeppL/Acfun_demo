//
//  DetailVideoModel.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/3.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "DetailVideoModel.h"

@implementation DetailVideoModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"videos" : @"DetailModelVideo"
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"descriptionText" : @"description"
             };
}

@end


@implementation DetailVideoModelOwner

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ownerId" : @"id"
             };
}
@end


@implementation DetailVideoModelVideo

@end


@implementation DetailVideoModelVisit

@end

