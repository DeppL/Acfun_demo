//
//  ChannelModel.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/16.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "ChannelModel.h"
#import <MJExtension.h>

@implementation ChannelModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"channelId" : @"id"
             };

}


+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"childChannels" : @"ChannelModel"
             };
}

+ (ChannelModel *)getSubChannelModelInModelArr:(NSArray *)channelModelsArr withSection:(NSInteger)section andRow:(NSInteger)row {
      return ((ChannelModel *)channelModelsArr[section]).childChannels[row];
}


@end
