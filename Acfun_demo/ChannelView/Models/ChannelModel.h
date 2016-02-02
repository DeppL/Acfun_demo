//
//  ChannelModel.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/16.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject


@property (nonatomic, copy) NSArray *childChannels;
@property (nonatomic, copy) NSString *configRegion;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *dbstatus;
@property (nonatomic, copy) NSString *hide;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *parents;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *priority;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *updateDate;
@property (nonatomic, copy) NSString *updater;


+ (ChannelModel *)getSubChannelModelInModelArr:(NSArray *)channelModelsArr withSection:(NSInteger)section andRow:(NSInteger)row;


@end
