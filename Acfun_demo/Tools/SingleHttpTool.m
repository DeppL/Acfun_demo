//
//  SingleHttpTool.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/22.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "SingleHttpTool.h"

#import "ChannelModel.h"

static NSString * const SingleHttpToolCache = @"SingleHttpToolCache";
static NSString * const channelModelURL = @"http://api.aixifan.com/channels/allChannels";
static NSString * const homeModelURL = @"http://api.aixifan.com/regions";


@interface SingleHttpTool ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) YYCache *cache;

@end

@implementation SingleHttpTool

#pragma mark - 初始化

- (instancetype)init {
    self = [super init];
    if (self) {
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
        [mgr.requestSerializer setValue:@"0" forHTTPHeaderField:@"deviceType"];
        [mgr.requestSerializer setValue:@"2000" forHTTPHeaderField:@"productId"];
        [mgr.requestSerializer setValue:@"appstore" forHTTPHeaderField:@"market"];
        [mgr.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        [mgr.requestSerializer setValue:@"4.1.0" forHTTPHeaderField:@"appVersion"];
        [mgr.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
        [mgr.requestSerializer setValue:@"zh-Hans-CN;q=1" forHTTPHeaderField:@"Accept-Language"];
        [mgr.requestSerializer setValue:@"\"24e6f768-2be3-4381-b221-964a39e4abd7\"" forHTTPHeaderField:@"If-None-Match"];
        [mgr.requestSerializer setValue:@"0" forHTTPHeaderField:@"deviceType"];
        [mgr.requestSerializer setValue:@"AcFun/4.1.0 (iPad; iOS 9.2; Scale/2.00)" forHTTPHeaderField:@"User-Agent"];
        [mgr.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
        [mgr.requestSerializer setValue:@"1536x2048" forHTTPHeaderField:@"resolution"];
        [mgr.requestSerializer setValue:@"C5EOO719-6DF8-4EC0-314B-4C82D57E72CC" forHTTPHeaderField:@"udid"];
        self.manager = mgr;
        
        YYCache *cache = [[YYCache alloc]initWithName:SingleHttpToolCache];
        cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
        cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
        self.cache = cache;
    }
    return self;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    NSDate *date = [NSDate date];
    NSDateFormatter *forMatter = [[NSDateFormatter alloc]init];
    [forMatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss"];
    NSString *dateNow = [forMatter stringFromDate:date];
    dateNow = [dateNow stringByAppendingString:@" GMT"];
    
    [_manager.requestSerializer setValue:dateNow forHTTPHeaderField:@"If-Modified-Since"];
    
    return _manager;
}

+ (instancetype)shareHttpTool {
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}


#pragma mark - public

//- (void)GETDetilModelWithParams:(NSString *)subURL;
//- (void)GETClassifierModelWithChannelId:(NSString *)channelID;


+ (void)GETChannelModelSuccess:(success)success failure:(failure)failure offline:(offline)offline {
    NSString *str = channelModelURL;
    
    id object = [[SingleHttpTool shareHttpTool].cache objectForKey:str];
    if (object) {
        success(object);
    }
    
    [SingleHttpTool GETModelWithURL:str success:success failure:failure offline:offline];
}

+ (void)GETHomeModelSuccess:(success)success failure:(failure)failure offline:(offline)offline {
    
    NSString *str = homeModelURL;
    
    [SingleHttpTool GETModelWithURL:str success:^(id object) {
        
        __block NSMutableArray *mMainArr = [NSMutableArray arrayWithArray:object[@"data"]];
        
        for (NSDictionary *subDict in mMainArr) {
            
            if (subDict[@"contents"]) continue;
            
            NSString *lastStr = [NSString stringWithFormat:@"%@",subDict[@"id"]];
            NSString *urlSubStr = [homeModelURL stringByAppendingPathComponent:lastStr];
            
            [[SingleHttpTool shareHttpTool].manager GET:urlSubStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                for (int i = 0; i < mMainArr.count; i ++) {
                    if (responseObject[@"data"][@"id"] == mMainArr[i][@"id"]) {
                        
                        [mMainArr setObject:responseObject[@"data"] atIndexedSubscript:i];
                        break;
                    }
                    
                }
                for (NSDictionary *dict in mMainArr) {
                    if (!dict[@"contents"]) return;
                }
                
                NSMutableDictionary *responseDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
                [responseDict setObject:mMainArr forKey:@"data"];
                [[SingleHttpTool shareHttpTool].cache setObject:responseDict forKey:homeModelURL];
                success(responseDict);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                nil;
            }];
            
        }
    } failure:failure offline:offline];
}


#pragma mark - private

+ (void)GETModelWithURL:(NSString *)url success:(success)success failure:(failure)failure offline:(offline)offline {
    SingleHttpTool *tool = [SingleHttpTool shareHttpTool];
    
    if (![SingleHttpTool isConnectionAvailiable]) {
        offline();
        return;
    }
    
    id object = [tool.cache objectForKey:url];
    if (object) {
        success(object);
    }
    
    
    [[SingleHttpTool shareHttpTool].manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            [tool.cache setObject:responseObject forKey:url];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (BOOL)isConnectionAvailiable {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"]intValue];
//            NSLog(@"%d",type);
            if (0 == type) {
                return NO;
            }else return YES;
        }
    }
    return NO;
}

@end
