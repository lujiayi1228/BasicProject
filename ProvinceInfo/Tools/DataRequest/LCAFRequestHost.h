//
//  LCAFRequestHost.h
//  PackageAFNetworking
//
//  Created by 金嗓子卡卡 on 2016/10/13.
//  Copyright © 2016年 LUC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCAFHttpRequestProtocol.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  @brief 基于AF的网络请求
 */
@interface LCAFRequestHost : NSObject

@property (nonatomic,strong) AFHTTPSessionManager *requestManager;

@property (nonatomic,strong) NSString *baseUrlStr;

- (instancetype)initWithHost:(NSString *)host;

- (NSString *)baseUrl;

- (void)afRequestWithUrlString:(NSString *)urlString
                        method:(NSString *)method
                    parameters:(NSDictionary *)param
                         cache:(BOOL)isCache
                  successBlock:(LCSuccessBlock)success
                     failBlock:(LCFailBlock)fail;

- (void)enableCacheWithDirectory:(NSString *)cacheDirectoryPath
                    inMemoryCost:(NSUInteger)inMemoryCost;


@end

NS_ASSUME_NONNULL_END
