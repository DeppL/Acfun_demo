//
//  RVLBeaconLogger.m
//  IBeaconDemo
//
//  Created by Jay Lyerly on 5/20/14.
//  Copyright (c) 2014 StepLeader Digital. All rights reserved.
//

#import "RVLBeaconLogger.h"
#import "RVLBeacon.h"
#import "CompilerMacros.h"
#import "RVLDebugLog.h"

@interface RVLBeaconLogger ()
@property (nonatomic, strong) NSMutableArray *watchers;
@end

@implementation RVLBeaconLogger

+ (RVLBeaconLogger *) sharedMgr {
    static RVLBeaconLogger *_mgr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mgr = [[RVLBeaconLogger alloc] init];
    });
    
    return _mgr;
}

- (instancetype) init {
    self = [super init];
    if (self){
        _watchers = [ @[] mutableCopy ];
    }
    return self;
}

- (void)logBeaconRegion:(CLBeaconRegion *)beaconRegion {
    [self logRvlBeacon:[[RVLBeacon alloc] initWithBeaconRegion:beaconRegion]];
}


- (void)logBeacon:(CLBeacon *)beacon {
    [self logRvlBeacon:[[RVLBeacon alloc] initWithBeacon:beacon]];
}

- (void)logRvlBeacon:(RVLBeacon *)beacon {
    NSMutableString *logString = [@"" mutableCopy];
    [logString appendFormat:@"Saw Beacon: %@:%@ %@", beacon.major, beacon.minor, [beacon.proximityUUID UUIDString]];
    RVLLog(@"%@", logString);
    
    for (id watcher in self.watchers){
        if ([watcher respondsToSelector:@selector(beaconLogger:didLogMessage:date:)]){
            [watcher beaconLogger:self didLogMessage:logString date:[NSDate date]];
        }
        if ([watcher respondsToSelector:@selector(beaconLogger:didLogBeacon:date:)]){
            [watcher beaconLogger:self didLogBeacon:beacon date:[NSDate date]];
        }
    }
}

- (void)addWatcher:(id<RVLBeaconLoggerWatcher>)watcher {
    [self.watchers addObject:watcher];
}

@end
