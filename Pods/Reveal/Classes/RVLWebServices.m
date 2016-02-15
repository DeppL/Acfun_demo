//
//  RVLWebServices.m
//  RevealSDK
//
//  Created by Sean Doherty on 1/7/15.
//  Copyright (c) 2015 StepLeader Digtial. All rights reserved.
//

#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>
#import "RVLWebServices.h"
#import "CompilerMacros.h"
#import "RVLDebugLog.h"
#import "RVLBlueToothManager.h"
#import "RVLUDIDElement.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

typedef enum {
    ConnectionTypeUnknown,
    ConnectionTypeNone,
    ConnectionType3G,
    ConnectionTypeWiFi
} ConnectionType;

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/SystemConfiguration.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

NSString * const kGodzillaDefaultsUrl = @"kGodzillaDefaultsUrl";
NSString * const kGodzillaDefaultsKey = @"kGodzillaDefaultsKey";

@implementation RVLWebServices
// Persist the info to access Godzilla for background operation
+(NSString *) apiKey{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kGodzillaDefaultsKey];
}

+(void) setApiKey:(NSString *)apiKey {
    [[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:kGodzillaDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *) apiUrl{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kGodzillaDefaultsUrl];
}

+(void) setApiUrl:(NSString *)apiUrl {
    [[NSUserDefaults standardUserDefaults] setObject:apiUrl forKey:kGodzillaDefaultsUrl];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSMutableDictionary*) getDefaultParameters {
    
    CLLocation *location = [RVLBlueToothManager sharedMgr].userLocation;
    CLLocationCoordinate2D coord = location.coordinate;
    NSTimeInterval coordAge = [[NSDate date] timeIntervalSinceDate:location.timestamp];
    NSUInteger coordAgeMS = (NSUInteger)(coordAge * pow(10,6));  // convert to milliseconds
    
    NSMutableDictionary *fullParameters = [@{
                                             @"os"                : @"ios",
                                             @"bluetooth_enabled" : @([RVLBlueToothManager sharedMgr].hasBluetooth),
                                             @"device_id"         : [RVLUDIDElement getUDID],
                                             @"app_version"       : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                                             @"location"          : @{
                                                     @"lat"  : @(coord.latitude),
                                                     @"long" : @(coord.longitude),
                                                     
                                                     @"time" : @(coordAgeMS),
                                                     },
                                             } mutableCopy];
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        //[DO] idfa is not guaranteed to return a valid string when device firsts starts up
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        RVLLog(@"IDFA Available and is %@",idfa);
        if (idfa != nil && ![idfa isEqualToString:@""]) {
            fullParameters[@"idfa"] = idfa;
        }
    }
    return fullParameters;
}

+(void) registerDeviceWithResult:(void (^)(BOOL success, NSDictionary* result, NSError* error))result {
    NSDictionary *params = @{
                             @"version"           : [[UIDevice currentDevice] systemVersion],
                             @"locale"            : [[NSLocale currentLocale] localeIdentifier],
                             //@"bluetooth_version" : @"4",     // not available on iOS
                             @"bluetooth_enabled" : @([RVLBlueToothManager sharedMgr].hasBluetooth),
                             @"supports_ble"      : @([RVLBlueToothManager sharedMgr].hasBluetooth),
                             };
    NSMutableDictionary* fullParams = [RVLWebServices getDefaultParameters];
    [fullParams addEntriesFromDictionary:params];
    [RVLWebServices sendRequestToEndpoint:@"info" withParams:fullParams forResult:result];
}

+(void) sendNotificationOfBeacon:(RVLBeacon*) beacon
                          result:(void (^)(BOOL success, NSDictionary* result, NSError* error))result{
    
    CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
    NSString* networkType = nil;
    
    switch ( [RVLWebServices connectionType] )
    {
        case ConnectionTypeWiFi:
            networkType = @"wifi";
            break;
            
        case ConnectionTypeNone:
            networkType = @"none";
            break;
            
        default:
            networkType = telephonyInfo.currentRadioAccessTechnology;
            networkType = [networkType stringByReplacingOccurrencesOfString: @"CTRadioAccessTechnology" withString: @""];
            break;
    }
    
    RVLLog( @"Network type: %@", networkType );

    NSMutableDictionary *params = [@{
                                     @"beacon_uuid"       : [[beacon proximityUUID] UUIDString],
                                     @"beacon_major"      : beacon.major,
                                     @"beacon_minor"      : beacon.minor,
                                     @"beacon_proximity"  : beacon.proximity,
                                     @"beacon_accuracy"   : beacon.accuracy,
                                     @"beacon_rssi"       : beacon.rssi,
                                     @"con_type"          : networkType
                                     //@"beacon_mac"        : @"",  // not available on iOS
                                     } mutableCopy];
    
    CLPlacemark *addressPlacemark = [RVLBlueToothManager sharedMgr].userPlacemark;
    if (addressPlacemark){
        params[@"address"] = @{
                               @"street"  : addressPlacemark.addressDictionary[@"Street"] ?: @"",
                               @"city"    : addressPlacemark.locality                     ?: @"",
                               @"state"   : addressPlacemark.administrativeArea           ?: @"",
                               @"zip"     : addressPlacemark.postalCode                   ?: @"",
                               @"country" : addressPlacemark.country                      ?: @"",
                               };
    }
    NSMutableDictionary* fullParams = [RVLWebServices getDefaultParameters];
    [fullParams addEntriesFromDictionary:params];
    [RVLWebServices sendRequestToEndpoint:@"event/beacon" withParams:fullParams forResult:result];
}



+(void) sendRequestToEndpoint:(NSString*) endpoint withParams:(NSDictionary*) params forResult:(void (^)(BOOL success, NSDictionary* result, NSError* error))result {
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // These gyrations avoid a double slash (http://foo.com//api/info)
        // which gives godzilla the fits.
        NSURL *apiUrl = [NSURL URLWithString:self.apiUrl];
        NSString *methodPath = [NSString stringWithFormat:@"/api/v3/%@", endpoint];
        NSURL *reqUrl = [NSURL URLWithString:methodPath relativeToURL:apiUrl];
        
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:reqUrl];
        [urlRequest setValue:self.apiKey         forHTTPHeaderField:@"X-API-KEY"];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil]];
        
        // TODO: [JL] This is mostly for debugging and can go when this settles down.
        NSString *requestString = [[NSString alloc] initWithData:urlRequest.HTTPBody encoding:NSUTF8StringEncoding];
        RVLLog(@"Request post to URL: %@ with data: %@", reqUrl.absoluteURL, requestString );
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest
                                                completionHandler:^(NSData *data,
                                                                    NSURLResponse *response,
                                                                    NSError *error)
                                      {
                                          RVLLog(@"Response from server is %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                          //if error or no data, return error to result
                                          if ([data length] == 0 || error) {
                                              result(NO,@{@"errors":@"Error requesting Reveal API"},error);
                                              return;
                                          }
                                          
                                          //build JSON for result
                                          NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:NSJSONReadingMutableContainers
                                                                                                     error:&error];
                                          
                                          //if json error, return error to result
                                          if (error){
                                              result(NO,@{@"errors":@"Error parsing response from Reveal API"},error);
                                              return;
                                          }
                                          
                                          //check json result for error array
                                          NSArray* errorsArray = objc_dynamic_cast(NSArray, [jsonDict objectForKey:@"errors"]);
                                          if (errorsArray && [errorsArray count] > 0){
                                              //if errors returned from server, return error to result
                                              result(NO,jsonDict,error);
                                              return;
                                          }
                                          
                                          //if no errors, return success to result
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              result(YES,jsonDict,error);
                                          });
                                      }];
        [task resume];
    });
}

+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [RVLWebServices getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

// code from: http://stackoverflow.com/questions/7938650/ios-detect-3g-or-wifi
//
// for most things yoiu want to use Reachability, but we are using this simple sychronua call
//
+ (ConnectionType)connectionType
{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, "8.8.8.8");
    SCNetworkReachabilityFlags flags;
    BOOL success = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    if (!success)
    {
        return ConnectionTypeUnknown;
    }
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL isNetworkReachable = (isReachable && !needsConnection);
    
    if (!isNetworkReachable)
    {
        return ConnectionTypeNone;
    }
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0)
    {
        return ConnectionType3G;
    }
    else
    {
        return ConnectionTypeWiFi;
    }
}

@end
