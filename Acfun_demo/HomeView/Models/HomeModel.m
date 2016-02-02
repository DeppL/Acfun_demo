//
//  HomeModel.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/28.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"homeId" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"contents" : @"HomeModelContent",
             @"menus" : @"HomeModelMenu"
             };
}

+ (HomeModelContent *)getSubHomeModelInModelArr:(NSArray *)arr withSection:(NSInteger)section andRow:(NSInteger)row {
    return ((HomeModel *)arr[section]).contents[row];
}


@end
