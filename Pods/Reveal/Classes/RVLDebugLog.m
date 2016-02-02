//
//  RVLDebugLog.m
//  RevealSDK
//
//  Created by Jay Lyerly on 10/20/14.
//  Copyright (c) 2014 StepLeader Digtial. All rights reserved.
//

#import "RVLDebugLog.h"
#import "Reveal.h"

void RVLLog(NSString *format, ...) {
    va_list arguments;
    va_start(arguments, format);
    
    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:arguments];
    [[RVLDebugLog sharedRevealDebugLog] logString:formattedString];
    
    va_end(arguments);
}

@interface RVLDebugLog ()
@property (nonatomic, readonly)     BOOL    enabled;
@end

@implementation RVLDebugLog

+ (RVLDebugLog *) sharedRevealDebugLog {
    static RVLDebugLog *_mgr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mgr = [[RVLDebugLog alloc] init];
    });
    
    return _mgr;
}

- (void) logString:(NSString *)aString {
    if (self.enabled){
        NSLog(@"Reveal: %@", aString);
    }
}

- (BOOL) enabled{
    return [Reveal sharedInstance].debug;
}

@end
