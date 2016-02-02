//
//  SingleHttpTool.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/22.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^success)(id object);
typedef void(^failure)(NSError *error);
typedef void(^offline)();

@interface SingleHttpTool : NSObject

@property (nonatomic, strong) NSMutableDictionary *downLoadList;


//- (void)GETDetilModelWithSubURL:(NSString *)subURL;
//- (void)GETClassifierModelWithChannelId:(NSString *)channelID;


+ (void)GETHomeModelSuccess:(success)success failure:(failure)failure offline:(offline)offline;
+ (void)GETChannelModelSuccess:(success)success failure:(failure)failure offline:(offline)offline;
+ (void)GETModelWithURL:(NSString *)url success:(success)success failure:(failure)failure offline:(offline)offline;



+ (instancetype)shareHttpTool;

@end
