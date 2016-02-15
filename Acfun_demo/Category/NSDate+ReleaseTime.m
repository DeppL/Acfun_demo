//
//  NSDate+ReleaseTime.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/15.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "NSDate+ReleaseTime.h"

@implementation NSDate (ReleaseTime)

+ (NSString *)compareWithReleaseTime:(NSString *)interval {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval floatValue]/1000];
    NSTimeInterval timeInterval = date.timeIntervalSinceNow * -1;
    
    
    if (timeInterval <= 60 * 2) {
        return @"刚刚发布";
    }
    else if (timeInterval > 60 * 2 && timeInterval <= 60 * 60) {
        NSString *mmStr = [NSString stringWithFormat:@"%d分钟前发布",((int)timeInterval / 60)];
        return mmStr;
    }
    else if (timeInterval > 60 *60 && timeInterval <= 60 *60 *24) {
        NSString *hhStr = [NSString stringWithFormat:@"%d小时前发布",((int)timeInterval / 60 / 60)];
        return hhStr;
    }else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *str = [dateFormatter stringFromDate:date];
        NSString *ddStr = [NSString stringWithFormat:@"于%@发布",str];
        return ddStr;
    }
    
}


@end
