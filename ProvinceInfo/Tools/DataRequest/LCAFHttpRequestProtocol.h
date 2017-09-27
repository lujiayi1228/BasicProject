//
//  LCAFHttpRequestProtocol.h
//  PackageAFNetworking
//
//  Created by 金嗓子卡卡 on 2016/10/13.
//  Copyright © 2016年 LUC. All rights reserved.
//

/**
 *  @brief 设置网络请求的的参数
 */
#ifndef LCAFHttpRequestProtocol_h
#define LCAFHttpRequestProtocol_h

#define DEFAULT_PAGE_SIZE 16

#define MaxOperationCount 5
#define TimeOut  10.f
#define kAFCacheDirectoryName @"com.luc.afcache"
#define kAFMemoryCost 10
#define kDownloadCount 1

typedef void(^LCSuccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^LCFailBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);


#endif /* LCAFHttpRequestProtocol_h */
