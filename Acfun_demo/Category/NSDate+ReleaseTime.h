//
//  NSDate+ReleaseTime.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/15.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ReleaseTime)

/**
 *  Get release time
 *
 *  @param interval NSString since 1970 ms
 *
 *  @return NSString *
 */
+ (NSString *)dl_dateCompareWithReleaseTime:(NSString *)interval;

@end
