//
//  RevealSDK.h
//  RevealSDK
//
//  Created by Sean Doherty on 1/8/2015.
//  Copyright (c) 2015 StepLeader Digtial. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLPlacemark;

typedef NS_ENUM(NSInteger, RVLServiceType) {
    RVLServiceTypeSandbox,
    RVLServiceTypeProduction
};

@interface Reveal : NSObject

@property (assign,nonatomic) RVLServiceType serviceType;

// Array of strings, each containing a UUID.  These UUIDs
// will override the list retrieved from the NearKat
// server.  This is useful to debug/verify that the SDK
// can detect a known iBeacon when testing.  This is a
// development feature and should not be used in production.
// In order to override the UUIDs from the server, this
// property should be set before starting the service.
@property (nonatomic, strong) NSArray <NSString*> *debugUUIDs;

// Debug flag for the SDK.  If this value is YES, the SDK
// will log debugging information to the console.
// Default value is NO.
// This can be toggled during the lifetime of the SDK usage.
@property (nonatomic, assign) BOOL debug;

// An option to allow a developer to manually disable beacon scanning
// Default value is YES
@property (nonatomic, assign) BOOL beaconScanningEnabled;

// Accessor properties for the SDK.
// At any time, the client can access the list of errors
// and the list of personas.  Both are arrays of NSStrings.
// Values may be nil.
@property (nonatomic, strong) NSArray <NSString*> *personas;
@property (nonatomic, strong) NSArray <NSString*> *errors;

// SDK singleton.  All SDK access should occur through this object.
+ (Reveal*) sharedInstance;

-(id) setupWithAPIKey:(NSString*) key;
-(id) setupWithAPIKey:(NSString*) key andServiceType:(RVLServiceType) serviceType;

// Start the SDK service.  The SDK will contact the API and retrieve
// further configuration info.  Background beacon scanning will begin
// and beacons will be logged via the API.
-(void) start;

// Notify the SDK that the app is restarting.  To be called in applicationDidBecomeActive
-(void) restart;

// list of beacons encountered
- (NSDictionary*)beacons;

// address if known
- (CLPlacemark*) location;
@end
