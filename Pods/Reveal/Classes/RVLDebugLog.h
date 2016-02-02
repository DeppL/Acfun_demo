//
//  RVLDebugLog.h
//  RevealSDK
//
//  Created by Jay Lyerly on 10/20/14.
//  Copyright (c) 2014 StepLeader Digtial. All rights reserved.
//

#import <Foundation/Foundation.h>

void RVLLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

@interface RVLDebugLog : NSObject

+ (instancetype)sharedRevealDebugLog;

- (void)logString:(NSString *)aString;

@end
