//
//  RVLBlueToothManager.h
//  Reveal
//
//  Created by Jay Lyerly on 5/19/14.
//  Copyright (c) 2014 StepLeader Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

#define kFoundBeaconsKey        @"FOUND_BEACONS"

typedef void (^RVLBlueToothStatusBlock)(CBCentralManagerState state);
typedef void (^RVLBlueToothBeaconBlock)(NSArray *beacons);
typedef void (^RVLBlueToothRegionBlock)(CLRegion *region, BOOL entered);

@interface RVLBlueToothManager : NSObject
@property (nonatomic, copy, readonly)   NSString                *status;
@property (nonatomic, readonly)         BOOL                    hasBluetooth;

@property (nonatomic, assign, readonly) CLLocationCoordinate2D  userCoordinate;
@property (nonatomic, strong, readonly) CLLocation              *userLocation;
@property (nonatomic, strong, readonly) CLPlacemark             *userPlacemark;

@property (nonatomic, strong) NSMutableDictionary               *seenBeacons;

+ (RVLBlueToothManager *) sharedMgr;
- (void) addBeacon:(NSString *)beaconID;
- (void) addStatusBlock:(RVLBlueToothStatusBlock)block;
- (void) addBeaconBlock:(RVLBlueToothBeaconBlock)block;
- (void) addRegionBlock:(RVLBlueToothRegionBlock)block;
- (void) shutdownMonitor;

@end
