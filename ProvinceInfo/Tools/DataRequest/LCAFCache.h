//
//  LCAFCache.h
//  PackageAFNetworking
//
//  Created by 金嗓子卡卡 on 2016/10/13.
//  Copyright © 2016年 LUC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 基于AF的网络请求数据缓存,这里运用了LRU进行内存置换
 */
@interface LCAFCache : NSObject

/**
 *  @brief 初始化内存管理空间,单例
 *
 *  @param directoryName 缓存文件名称
 *  @param memoryCost    缓存开销，花费
 *
 *  @return 返回数据缓存类的实例
 */
+ (LCAFCache *)sharedWithDirectoryName:(NSString *)directoryName memoryCost:(NSInteger)memoryCost;

/**
 *  @brief 初始化内存管理空间
 *
 *  @param directoryName 缓存文件名称
 *  @param memoryCost    缓存开销，花费
 *
 *  @return 返回数据缓存类的实例
 */
- (id)initWithDirectoryName:(NSString *)directoryName
                 memoryCost:(NSInteger)memoryCost;

/**
 *  @brief 根据键值存储缓存
 *
 *  @param data 缓存内容
 *  @param key  键值
 */
- (void)setCacheData:(NSData *)data
              forKey:(NSString *)key;

/**
 *  @brief 根据键值获取缓存内容
 *
 *  @param key 键值
 *
 *  @return 缓存内容
 */
- (NSData *)cacheDataForKey:(NSString *)key;


@end
