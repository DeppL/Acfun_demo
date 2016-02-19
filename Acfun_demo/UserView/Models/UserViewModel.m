//
//  UserViewModel.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/18.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "UserViewModel.h"

@implementation UserViewModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"sectionArr" : @"UserViewSectionModel"
             };
}


@end


@implementation UserViewSectionModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"rowArr" : @"UserViewRowModel"
             };
}

@end


@implementation UserViewRowModel


@end
