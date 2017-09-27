//
//  NSObject+LCAFRequest.h
//  PackageAFNetworking
//
//  Created by 金嗓子卡卡 on 2016/10/13.
//  Copyright © 2016年 LUC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCAFHttpRequestProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (LCAFRequest)

- (void)POSTWithHost:(NSString *)host
                path:(NSString *)path
               param:(NSDictionary *)param
               cache:(BOOL)isCache
           completed:(LCSuccessBlock)completed
               error:(LCFailBlock)errorBlock;

- (void)GETWithHost:(NSString *)host
               path:(NSString *)path
              param:(NSDictionary *)param
              cache:(BOOL)isCache
          completed:(LCSuccessBlock)completed
              error:(LCFailBlock)errorBlock;



//上传图片
- (void)upload:(NSString *)path parameters:(NSDictionary *)dic constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block progress:(void (^)(NSProgress * _Nonnull uploadProgress))progress success:(LCSuccessBlock)success failure:(LCFailBlock)failure;


@end
NS_ASSUME_NONNULL_END
