//
//  RVLWebServices.h
//  RevealSDK
//
//  Created by Sean Doherty on 1/7/15.
//  Copyright (c) 2015 StepLeader Digtial. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RVLBeacon.h"

@interface RVLWebServices : NSObject
+(void) setApiKey:(NSString *)apiKey;
+(void) setApiUrl:(NSString *)apiUrl;
+(void) registerDeviceWithResult:(void (^)(BOOL success, NSDictionary* result, NSError* error))result;
+(void) sendNotificationOfBeacon:(RVLBeacon*) beacon
        result:(void (^)(BOOL success, NSDictionary* result, NSError* error))result;
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (NSDictionary *)getIPAddresses;
@end

