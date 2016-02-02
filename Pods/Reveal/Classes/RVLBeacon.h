//
//  RVLBeacon.h
//  ShareLib
//
//  Created by Jay Lyerly on 6/9/14.
//  Copyright (c) 2014 StepLeader Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLBeacon;
@class CLBeaconRegion;

@interface RVLBeacon : NSObject

@property (nonatomic, strong)   NSUUID   *proximityUUID;
@property (nonatomic, strong)   NSString *major;
@property (nonatomic, strong)   NSString *minor;

@property (nonatomic, copy)     NSString *proximity;
@property (nonatomic, strong)   NSNumber *accuracy;
@property (nonatomic, strong)   NSNumber *rssi;

@property (nonatomic, readonly) NSString *rvlUniqString;

@property (nonatomic, strong)   NSDate   *discoveryTime;
@property (nonatomic, strong)   NSDate   *sentTime;

- (instancetype) initWithBeacon:(CLBeacon *)beacon;
- (instancetype) initWithBeaconRegion:(CLBeaconRegion *)beaconRegion;

+ (NSString*)rvlUniqStringWithBeacon:(CLBeacon*) beacon;

@end
