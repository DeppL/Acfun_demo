//
//  HomeModelOwner.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/28.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "HomeModelOwner.h"

@implementation HomeModelOwner

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ownerId" : @"id"
             };
    
}

@end
