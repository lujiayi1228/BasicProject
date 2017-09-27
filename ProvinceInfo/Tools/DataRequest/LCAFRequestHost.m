//
//  LCAFRequestHost.m
//  PackageAFNetworking
//
//  Created by 金嗓子卡卡 on 2016/10/13.
//  Copyright © 2016年 LUC. All rights reserved.
//

#import "LCAFRequestHost.h"
#import "LCAFCache.h"

@interface LCAFRequestHost()



@property (nonatomic,strong) LCAFCache *afCache;

@end

@implementation LCAFRequestHost


- (id)initWithHost:(NSString *)host
{
    self = [super init];
    if (self) {
        
        self.baseUrlStr = [NSString stringWithFormat:@"http://%@/", host];
        NSURL *baseUrl = [NSURL URLWithString:self.baseUrlStr];
        self.requestManager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseUrl];
        self.requestManager.operationQueue.maxConcurrentOperationCount = MaxOperationCount;
        self.afCache = [LCAFCache sharedWithDirectoryName:kAFCacheDirectoryName memoryCost:kAFMemoryCost];
        self.requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
        response.removesKeysWithNullValues = YES;
        self.requestManager.responseSerializer = response;
        self.requestManager.requestSerializer.timeoutInterval = TimeOut;
    }
    return self;
}
- (void)enableCacheWithDirectory:(NSString *)cacheDirectoryPath
                    inMemoryCost:(NSUInteger)inMemoryCost
{
    self.afCache = nil;
    self.afCache = [LCAFCache sharedWithDirectoryName:kAFCacheDirectoryName memoryCost:kAFMemoryCost];;
}
- (void)afRequestWithUrlString:(NSString *)urlString
                        method:(NSString *)method
                    parameters:(NSDictionary *)param
                         cache:(BOOL)isCache
                  successBlock:(LCSuccessBlock)success
                     failBlock:(LCFailBlock)fail
{
    if ([method isEqualToString:@"POST"]) {
        [self.requestManager POST:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSData *saveData = responseObject;
            NSString *uniqueKey = [self uniqueKeyForUrlString:urlString
                                                       method:method
                                                       params:param];
            
            if (isCache) {
                [self.afCache setCacheData:saveData forKey:uniqueKey];
            }
            if (!responseObject) {
                responseObject = [[self.afCache cacheDataForKey:uniqueKey]copy];
            }
            success(task,responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error  %@",error);
            NSString *uniqueKey = [self uniqueKeyForUrlString:urlString
                                                       method:method
                                                       params:param];
            NSData *getData = [self.afCache cacheDataForKey:uniqueKey];
            if (getData) {
                success(task,getData);
            }else{
                fail(task,error);
            }
        }];
        
    }else if ([method isEqualToString:@"GET"]){
        
        [self.requestManager POST:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSData *saveData = responseObject;
            NSString *uniqueKey = [self uniqueKeyForUrlString:urlString
                                                       method:method
                                                       params:param];
            [self.afCache setCacheData:saveData forKey:uniqueKey];
            if (!responseObject) {
                responseObject = [[self.afCache cacheDataForKey:uniqueKey]copy];
            }

            success(task,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error  %@",error);
            NSString *uniqueKey = [self uniqueKeyForUrlString:urlString
                                                       method:method
                                                       params:param];
            NSData *getData = [self.afCache cacheDataForKey:uniqueKey];
            if (getData) {
                success(task,getData);
            }else{
                fail(task,error);
            }
        }];
        
    }else if ([method isEqualToString:@"DELETE"]){
        [self addObserver:self forKeyPath:@"" options:NSKeyValueObservingOptionNew context:nil];
        [self.requestManager DELETE:urlString parameters:param success:success failure:fail];
    }

}

- (NSString *)uniqueKeyForUrlString:(NSString *)urlString
                             method:(NSString *)method
                             params:(NSDictionary *)params
{
    NSString *str = [NSString stringWithFormat:@"%@ %@",
                            method,
                            urlString];
    for (NSString *key in params){
        NSString *value = [NSString stringWithFormat:@"%@",params[key]];
        str = [str stringByAppendingString:value];
        str = [str stringByAppendingString:key];
    }
    return str;
}
- (NSString *)baseUrl;
{
    return self.baseUrlStr;
}
@end
