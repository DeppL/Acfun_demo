//
//  DLHttpTool.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/17.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "DLHttpTool.h"


static NSString * const DLHttpToolRequestCache = @"DLHttpToolRequestCache";

typedef NS_ENUM(NSUInteger, DLHttpToolRequestType) {
    DLHttpToolRequestTypeGET = 0,
    DLHttpToolRequestTypePOST
};

@interface DLHttpTool ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) YYCache *cache;
@property (nonatomic, strong) UIAlertView *alert;

@end

@implementation DLHttpTool

- (id)init{
    if (self = [super init]){
        
        // 创建请求管理者
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
        mgr.requestSerializer.timeoutInterval = 10.0;
        [mgr.requestSerializer setValue:@"0" forHTTPHeaderField:@"deviceType"];
        [mgr.requestSerializer setValue:@"2000" forHTTPHeaderField:@"productId"];
        [mgr.requestSerializer setValue:@"appstore" forHTTPHeaderField:@"market"];
        [mgr.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        [mgr.requestSerializer setValue:@"4.1.0" forHTTPHeaderField:@"appVersion"];
        [mgr.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
        [mgr.requestSerializer setValue:@"zh-Hans-CN;q=1" forHTTPHeaderField:@"Accept-Language"];
        [mgr.requestSerializer setValue:@"\"37a6f768-2be3-4381-b221-964a39e4abd7\"" forHTTPHeaderField:@"If-None-Match"];
        [mgr.requestSerializer setValue:@"0" forHTTPHeaderField:@"deviceType"];
        [mgr.requestSerializer setValue:@"AcFun/4.1.0 (iPad; iOS 9.2; Scale/2.00)" forHTTPHeaderField:@"User-Agent"];
        [mgr.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
        [mgr.requestSerializer setValue:@"2048x1536" forHTTPHeaderField:@"resolution"];
        [mgr.requestSerializer setValue:@"C3ACO719-6DF8-4EC0-314B-4C82D57E72CC" forHTTPHeaderField:@"udid"];
        self.manager = mgr;

    }
    return self;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
//    NSDate *date = [NSDate date];
//    NSDateFormatter *forMatter = [[NSDateFormatter alloc]init];
//    [forMatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss"];
//    NSString *dateNow = [forMatter stringFromDate:date];
//    dateNow = [dateNow stringByAppendingString:@" GMT"];
//    [_manager.requestSerializer setValue:dateNow forHTTPHeaderField:@"If-Modified-Since"];
    
    return _manager;
}

#pragma mark -------------------- public --------------------

+ (DLHttpTool *)defaultHttpTool {
    static DLHttpTool *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id json))success
    failure:(void (^)(NSError *error))failure
{
    [DLHttpTool requestMethod:DLHttpToolRequestTypeGET url:url params:params cachePolicy:DLHttpToolReturnCacheDataThenLoad success:success failure:failure];
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id json))success
     failure:(void (^)(NSError *error))failure
{
    [DLHttpTool requestMethod:DLHttpToolRequestTypePOST url:url params:params cachePolicy:DLHttpToolReturnCacheDataThenLoad success:success failure:failure];
}

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
cachePolicy:(DLHttpToolRequestCachePolicy)cachePolicy
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure
{
    [DLHttpTool requestMethod:DLHttpToolRequestTypeGET url:url params:params cachePolicy:cachePolicy success:success failure:failure];
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
 cachePolicy:(DLHttpToolRequestCachePolicy)cachePolicy
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure
{
    [DLHttpTool requestMethod:DLHttpToolRequestTypePOST url:url params:params cachePolicy:cachePolicy success:success failure:failure];
}


+ (void)removeAllCaches {
    [[DLHttpTool defaultHttpTool].cache removeAllObjects];
}

+ (void)removeCachesForKey:(NSString *)key {
    [[DLHttpTool defaultHttpTool].cache removeObjectForKey:key];
}


/**
 *  清除本地缓存文件
 */
+ (void)clearCacheFile {
    [[SDWebImageManager sharedManager].imageCache clearDisk];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [DLHttpTool removeAllCaches];
}


+ (void)clearCacheFileOld {
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *files = [fileManager subpathsAtPath:cachPath];
    
    for (NSString *fileName in files) {
        
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:fileName];
        
        if ([fileManager fileExistsAtPath:path]) [fileManager removeItemAtPath:path error:&error];
        
    }
    
}

/**
 *  计算本地缓存文件大小
 *
 *  @return MB
 */
+ (double)getCacheFileSize {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    double fileSize = 0.0;
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [fileManager subpathsAtPath:cachPath];
    
    for (NSString *fileName in files) {
        
        NSString *path = [cachPath stringByAppendingPathComponent:fileName];
        
        if ([fileManager fileExistsAtPath:path]) {
            
            NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
            
            fileSize += (double)([fileAttributes fileSize]);
        }
    }
    
    return fileSize / (1024.0 * 1024);
    
}


#pragma mark -------------------- private --------------------

+ (void)requestMethod:(DLHttpToolRequestType)requestType
                  url:(NSString *)url
               params:(NSDictionary *)params
          cachePolicy:(DLHttpToolRequestCachePolicy)cachePolicy
              success:(void (^)(id json))success
              failure:(void (^)(NSError *error))failure
{
    NSString *cacheKey = url;
    if (params) {
        if (![NSJSONSerialization isValidJSONObject:params]) return ; //参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [url stringByAppendingString:paramStr];
    }
    
    YYCache *cache = [[YYCache alloc] initWithName:DLHttpToolRequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    id object = [cache objectForKey:cacheKey];
    [DLHttpTool defaultHttpTool].cache = cache;
    
    switch (cachePolicy) {
        case DLHttpToolReturnCacheDataThenLoad: { // 先返回缓存，同时请求
            if (object) {
                success(object);
            }
            break;
        }
        case DLHttpToolReloadIgnoringLocalCacheData: { // 忽略本地缓存直接请求
            // 不做处理，直接请求
            break;
        }
        case DLHttpToolReturnCacheDataElseLoad: { // 有缓存就返回缓存，没有就请求
            if (object) { // 有缓存
                success(object);
                return ;
            }
            break;
        }
        case DLHttpToolReturnCacheDataDontLoad: { // 有缓存就返回缓存,从不请求（用于没有网络）
            if (object) { // 有缓存
                success(object);
            }
            return ; // 退出从不请求
        }
        default: {
            break;
        }
    }
    [DLHttpTool requestMethod:requestType url:url params:params cache:cache cacheKey:cacheKey success:success failure:failure];
}

+ (void)requestMethod:(DLHttpToolRequestType)requestType
                  url:(NSString *)url
               params:(NSDictionary *)params
                cache:(YYCache *)cache
             cacheKey:(NSString *)cacheKey
              success:(void (^)(id json))success
              failure:(void (^)(NSError *error))failure
{
    switch (requestType) {
        case DLHttpToolRequestTypeGET: {
            if ([DLHttpTool isConnectionAvailable]) {
                // 2.发送请求
                [[DLHttpTool defaultHttpTool].manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if (success) {
                        [cache setObject:responseObject forKey:cacheKey];   // YYCache 已经做了responseObject为空处理
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(error);
                    }
                }];
            } else {
                [DLHttpTool showExceptionDialog];
            }
            break;
        }
        case DLHttpToolRequestTypePOST: {
            if ([DLHttpTool isConnectionAvailable]) {
                // 2.发送请求
                [[DLHttpTool defaultHttpTool].manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        [cache setObject:responseObject forKey:cacheKey];   // YYCache 已经做了responseObject为空处理
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(error);
                    }
                }];
            } else {
                [DLHttpTool showExceptionDialog];
            }
            
            break;
        }
        default:
            break;
    }
}

// 弹出网络错误提示框
+ (void)showExceptionDialog
{
    if ([DLHttpTool defaultHttpTool].alert) {
        return;
    }
    [DLHttpTool defaultHttpTool].alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"网络异常，请检查网络连接"
                                                                   delegate:self
                                                          cancelButtonTitle:@"好的"
                                                          otherButtonTitles:nil, nil];
    [[DLHttpTool defaultHttpTool].alert show];
}
// 查看网络状态是否给力
+ (BOOL)isConnectionAvailable {
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


//+ (BOOL)isConnectionAvailable
//{
//    // 创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
//    struct sockaddr_in zeroAddress;
//    bzero(&zeroAddress, sizeof(zeroAddress));
//    zeroAddress.sin_len = sizeof(zeroAddress);
//    zeroAddress.sin_family = AF_INET;
//    
//    /**
//     *  SCNetworkReachabilityRef: 用来保存创建测试连接返回的引用
//     *
//     *  SCNetworkReachabilityCreateWithAddress: 根据传入的地址测试连接.
//     *  第一个参数可以为NULL或kCFAllocatorDefault
//     *  第二个参数为需要测试连接的IP地址,当为0.0.0.0时则可以查询本机的网络连接状态.
//     *  同时返回一个引用必须在用完后释放.
//     *  PS: SCNetworkReachabilityCreateWithName: 这个是根据传入的网址测试连接,
//     *  第二个参数比如为"www.apple.com",其他和上一个一样.
//     *
//     *  SCNetworkReachabilityGetFlags: 这个函数用来获得测试连接的状态,
//     *  第一个参数为之前建立的测试连接的引用,
//     *  第二个参数用来保存获得的状态,
//     *  如果能获得状态则返回TRUE，否则返回FALSE
//     *
//     */
//    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
//    SCNetworkReachabilityFlags flags;
//    
//    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
//    CFRelease(defaultRouteReachability);
//    
//    if (!didRetrieveFlags)
//    {
//        printf("Error. Could not recover network reachability flagsn");
//        return NO;
//    }
//    
//    /**
//     *  kSCNetworkReachabilityFlagsReachable: 能够连接网络
//     *  kSCNetworkReachabilityFlagsConnectionRequired: 能够连接网络,但是首先得建立连接过程
//     *  kSCNetworkReachabilityFlagsIsWWAN: 判断是否通过蜂窝网覆盖的连接,
//     *  比如EDGE,GPRS或者目前的3G.主要是区别通过WiFi的连接.
//     *
//     */
//    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
//    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
//    return (isReachable && !needsConnection) ? YES : NO;
//}



@end
