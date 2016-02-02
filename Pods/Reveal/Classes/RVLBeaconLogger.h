//
//  RVLBeaconLogger.h
//  IBeaconDemo
//
//  Created by Jay Lyerly on 5/20/14.
//  Copyright (c) 2014 StepLeader Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class RVLBeacon;
@class RVLBeaconLogger;

@protocol RVLBeaconLoggerWatcher <NSObject>
@optional
- (void) beaconLogger:(RVLBeaconLogger *)logger didLogMessage:(NSString *)msg date:(NSDate *)date;
- (void) beaconLogger:(RVLBeaconLogger *)logger didLogBeacon:(RVLBeacon *)beacon date:(NSDate *)date;
@end

@interface RVLBeaconLogger : NSObject
+ (RVLBeaconLogger *) sharedMgr;

- (void)logBeacon:(CLBeacon *)beacon;
- (void)logBeaconRegion:(CLBeaconRegion *)beaconRegion;
- (void)addWatcher:(id<RVLBeaconLoggerWatcher>)watcher;

@end
