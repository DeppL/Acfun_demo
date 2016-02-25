//
//  DLHttpTool.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/17.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DLHttpToolRequestCachePolicy){
    DLHttpToolReturnCacheDataThenLoad = 0,    /** 有缓存就先返回缓存，同步请求数据 */
    DLHttpToolReloadIgnoringLocalCacheData,   /** 忽略缓存，重新请求 */
    DLHttpToolReturnCacheDataElseLoad,        /** 有缓存就用缓存，没有缓存就重新请求(用于数据不变时) */
    DLHttpToolReturnCacheDataDontLoad         /** 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）*/
};


@interface DLHttpTool : NSObject


/**
 *  创建单例对象
 */
+ (DLHttpTool *)defaultHttpTool;

/**
 *  移除所有缓存
 */
+ (void)removeAllCaches;

/**
 *  根据指定key移除缓存
 */
+ (void)removeCachesForKey:(NSString *)key;

/**
 *  清除本地缓存文件
 */
+ (void)clearCacheFile;

/**
 *  计算本地缓存文件大小
 *
 *  @return MB
 */
+ (double)getCacheFileSize;

/**
 *  取消下载任务
 *
 *  @param url
 */
+ (void)cancelTaskWithURL:(NSURL *)url;

/**
 *  默认 DLHttpToolReturnCacheDataThenLoad 的缓存方式
 */
+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id json))success
    failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id json))success
     failure:(void (^)(NSError *error))failure;

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
cachePolicy:(DLHttpToolRequestCachePolicy)cachePolicy
    success:(void (^)(id json))success
    failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
 cachePolicy:(DLHttpToolRequestCachePolicy)cachePolicy
     success:(void (^)(id json))success
     failure:(void (^)(NSError *error))failure;



@end
