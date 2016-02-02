//
//  UDIDElement.m
//
//  Created by David Oldis on 3/26/12.
//  Copyright 2012 StepLeader Inc. All rights reserved.
//

#import "RVLUDIDElement.h"
//#import "NSString+trim.h"
#import <UIKit/UIKit.h>

@interface RVLUDIDElement (private)

@end

@implementation RVLUDIDElement

+ (NSString *) getUDID {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

@end
