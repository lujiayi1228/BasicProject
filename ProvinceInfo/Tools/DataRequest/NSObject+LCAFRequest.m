//
//  NSObject+LCAFRequest.m
//  PackageAFNetworking
//
//  Created by 金嗓子卡卡 on 2016/10/13.
//  Copyright © 2016年 LUC. All rights reserved.
//

#import "NSObject+LCAFRequest.h"
#import "LCAFRequestHost.h"

@implementation NSObject (LCAFRequest)

- (void)POSTWithHost:(NSString *)host
                path:(NSString *)path
               param:(NSDictionary *)param
               cache:(BOOL)isCache
           completed:(LCSuccessBlock)completed
               error:(LCFailBlock)errorBlock
{
    host = host.length>0 ? host : HOST_IP;
    [self afEnqueOperationForHost:host Path:path param:param method:@"POST" cache:isCache  completed:completed error:errorBlock];
}

- (void)GETWithHost:(NSString *)host
               path:(NSString *)path
              param:(NSDictionary *)param
              cache:(BOOL)isCache
          completed:(LCSuccessBlock)completed
              error:(LCFailBlock)errorBlock
{
    host = host.length>0 ? host : HOST_IP;
    [self afEnqueOperationForHost:host Path:path param:param method:@"GET" cache:isCache  completed:completed error:errorBlock];
}



- (void)upload:(NSString *)path parameters:(NSDictionary *)dic constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block progress:(void (^)(NSProgress * _Nonnull uploadProgress))progress success:(LCSuccessBlock)success failure:(LCFailBlock)failure
{
    LCAFRequestHost *networkHost = [[LCAFRequestHost alloc] initWithHost:HOST_IP];
    networkHost.requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [networkHost.requestManager POST:path parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传失败 %@", error);
        failure(task,error);
    }];
}
#pragma mark --- Privat Method



- (void)afEnqueOperationForHost:(NSString *)host
                           Path:(NSString *)path
                          param:(NSDictionary *)param
                         method:(NSString *)method
                          cache:(BOOL)isCache
                      completed:(LCSuccessBlock)completed
                          error:(LCFailBlock)errorBlock
{
    LCAFRequestHost *networkHost = [[LCAFRequestHost alloc]initWithHost:host];
    [networkHost afRequestWithUrlString:path method:method parameters:param cache:isCache successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completed(task,responseObject);
    } failBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(task,error);

    }];
    [self printUrlForPath:path
               andBaseUrl:[networkHost baseUrl]
               andParaDic:param];
}

- (void)printUrlForPath:(NSString *)path
             andBaseUrl:(NSString *)baseUrl
             andParaDic:(NSDictionary *)paramDic
{
    NSString *param = @"";
    for (int i=0; i<paramDic.count; i++) {
        NSString *key = [paramDic.allKeys objectAtIndex:i];
        param = [NSString stringWithFormat:@"%@&%@=%@", param, key, [paramDic objectForKey:key]];
    }
    if (param.length > 1) {
        NSLog(@"request url = %@?%@", [baseUrl stringByAppendingString:path], [param substringFromIndex:1]);
    }
    else {
        NSLog(@"request url = %@", [baseUrl stringByAppendingString:path]);
    }
}



- (void)cancelRequest{

}
@end

