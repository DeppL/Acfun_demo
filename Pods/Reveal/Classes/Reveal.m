//
//  RevealSDK.m
//  RevealSDK
//
//  Created by Sean Doherty on 1/8/2015.
//  Copyright (c) 2015 StepLeader Digtial. All rights reserved.
//

#import "Reveal.h"
#import <UIKit/UIKit.h>
#import "RVLBlueToothManager.h"
#import "RVLWebServices.h"
#import "CompilerMacros.h"
#import "RVLDebugLog.h"

@interface Reveal (PrivateMethods)
@end

@implementation Reveal
NSString * const kRevealBaseURLSandbox = @"https://sandboxsdk.revealmobile.com/";
NSString * const kRevealBaseURLProduction = @"https://sdk.revealmobile.com/";
NSString * const kRevealNSUserDefaultsKey = @"personas";
static Reveal *_sharedInstance;

- (instancetype) init {
    self = [super init];
    if (self){
        
    }
    return self;
}

- (void) dealloc {
    
}

+(Reveal*) sharedInstance {
    // refuse to initialize unless we're at iOS 7 or later.
    if ([[[UIDevice currentDevice] systemVersion] integerValue] < 7){
        return nil;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[Reveal alloc] init];
        _sharedInstance.debug = NO;
        _sharedInstance.beaconScanningEnabled = YES;
    });
    
    return  _sharedInstance;
}

-(id) setupWithAPIKey:(NSString*) key {
    return [self setupWithAPIKey:key andServiceType:RVLServiceTypeProduction];
}

-(id) setupWithAPIKey:(NSString*) key andServiceType:(RVLServiceType) serviceType {
    [RVLWebServices setApiKey:key];
    //Set service type value and update webservices with appropriate base url
    self.serviceType = serviceType;
    if (serviceType == RVLServiceTypeSandbox){
        [RVLWebServices setApiUrl:kRevealBaseURLSandbox];

    } else {
        [RVLWebServices setApiUrl:kRevealBaseURLProduction];
    }
    
    return [Reveal sharedInstance];
}

- (void) registerDevice: (BOOL) isStarting {
    RVLLog(@"Registering device with Server");
    [RVLWebServices registerDeviceWithResult:^(BOOL success, NSDictionary *result, NSError *error) {
        if (success){
            RVLLog(@"Device registered successfully");
            self.personas = objc_dynamic_cast(NSArray, [result objectForKey:@"personas"]);
            
            //Only start scanning if server returns discovery_enabled = true
            if ([objc_dynamic_cast(NSNumber, result[@"discovery_enabled"]) boolValue]){
                if (self.beaconScanningEnabled) {
                    //If we have debug UUID's set, ignore list from server
                    if (self.debugUUIDs) {
                        [self startScanningForBeacons:self.debugUUIDs];
                    } else {
                        NSArray *beaconsToScan = objc_dynamic_cast(NSArray, result[@"beacons"]);
                        [self startScanningForBeacons:beaconsToScan];
                    }
                } else {
                    RVLLog(@"Beacon scanning was manually disabled");
                }
            } else {
                [self stopScanningForBeacons];
            }

        } else {
            RVLLog(@"Device registration failed");
            self.errors = objc_dynamic_cast(NSArray, [result objectForKey:@"errors"]);
        }
    }];
}

-(void) startScanningForBeacons: (NSArray*) beacons {
    RVLLog(@"Starting beacon scanning");
    for (NSString *uuid in beacons){
        RVLLog(@"Scanning for beacons with UUID: %@", uuid);
        [[RVLBlueToothManager sharedMgr] addBeacon:uuid];
    }
}

-(void) stopScanningForBeacons {
    [[RVLBlueToothManager sharedMgr] shutdownMonitor];
}

- (void)start {
    RVLLog(@"Starting Reveal SDK");
    if ([CBCentralManager instancesRespondToSelector:@selector(initWithDelegate:queue:options:)]) {
        RVLLog(@"This device supports Bluetooth LE");
        // enable beacon scanning if this device supports Bluetooth LE
        [[RVLBlueToothManager sharedMgr] addStatusBlock:^(CBCentralManagerState state){
            RVLLog(@"Bluetooth status block called");
            // don't connect to the endpoint until the bluetooth status is ready
            static BOOL firstTime = YES;
            
            if (firstTime){
                [self registerDevice: YES];
                firstTime = NO;
            };
        }];
    } else {
        [self registerDevice: YES];
    }
    
    RVLLog( @"IP: %@\n%@\n\n", [RVLWebServices getIPAddress: YES], [RVLWebServices getIPAddresses] );
}

-(void) restart {
    [self registerDevice:NO];
}

-(void)setPersonas:(NSArray *)personas {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:personas forKey:kRevealNSUserDefaultsKey];
    [defaults synchronize];
}

-(NSArray *)personas {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kRevealNSUserDefaultsKey];
}

- (NSDictionary*)beacons
{
    NSDictionary* result = @{};
    NSDictionary* dict = [[RVLBlueToothManager sharedMgr] seenBeacons];
    
    if ( dict )
    {
        result = [NSDictionary dictionaryWithDictionary: dict];
    }
    
    return result;
}

- (CLPlacemark*) location
{
    return [[RVLBlueToothManager sharedMgr] userPlacemark];
}

@end
