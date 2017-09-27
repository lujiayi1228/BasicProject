//
//  LCAFCache.m
//  PackageAFNetworking
//
//  Created by 金嗓子卡卡 on 2016/10/13.
//  Copyright © 2016年 LUC. All rights reserved.
//

#import "LCAFCache.h"
#import "LCAFHttpRequestProtocol.h"

NSString *const kAFCacheDefaultPathExtension = @"afcache";
NSUInteger const kAFCacheDefaultCost = 10;

@interface LCAFCache()

@property (nonatomic,strong) NSString *directoryPath;
@property (nonatomic,assign) NSUInteger cacheMemoryCost;
@property (nonatomic,strong) NSMutableDictionary *memoryCacheDic;
@property (nonatomic,strong) NSMutableArray *recentUsedKeys;
@property (nonatomic,strong) dispatch_queue_t queue;

@end

@implementation LCAFCache

+ (LCAFCache *)sharedWithDirectoryName:(NSString *)directoryName memoryCost:(NSInteger)memoryCost{
    static LCAFCache *lcafcache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lcafcache = [[LCAFCache alloc]initWithDirectoryName:directoryName memoryCost:memoryCost];
    });
    return lcafcache;
}

- (id)initWithDirectoryName:(NSString *)directoryName
                 memoryCost:(NSInteger)memoryCost
{
    NSParameterAssert(directoryName);
    self = [super init];
    if (self) {
        self.directoryPath = [CachePath stringByAppendingPathComponent:directoryName];
        self.cacheMemoryCost = memoryCost?memoryCost:kAFCacheDefaultCost;
        [self cacheConfig];
    }
    return self;
}
- (void)cacheConfig
{
    self.memoryCacheDic = [NSMutableDictionary dictionaryWithCapacity:self.cacheMemoryCost];
    self.recentUsedKeys = [NSMutableArray arrayWithCapacity:self.cacheMemoryCost];
    
    BOOL isDirectory = YES;
    BOOL directoryExists = [[NSFileManager defaultManager] fileExistsAtPath:self.directoryPath isDirectory:&isDirectory];
    
    if(!isDirectory) {
        NSError *error = nil;
        if(![[NSFileManager defaultManager] removeItemAtPath:self.directoryPath error:&error]) {
            NSLog(@"%@", error);
        }
        directoryExists = NO;
    }
    if(!directoryExists)
    {
        NSError *error = nil;
        if(![[NSFileManager defaultManager] createDirectoryAtPath:self.directoryPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error]) {
            NSLog(@"%@", error);
        }
    }
    self.queue = dispatch_queue_create("com.afcache.queue", NULL);
////    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(flush)
//                                                 name:UIApplicationDidReceiveMemoryWarningNotification
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flush)
//                                                 name:UIApplicationDidEnterBackgroundNotification
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flush)
//                                                 name:UIApplicationWillTerminateNotification
//                                               object:nil];
    
}

- (void)flush
{
    [self.memoryCacheDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString *stringKey = [NSString stringWithFormat:@"%@", key];
        NSString *filePath = [[self.directoryPath stringByAppendingPathComponent:stringKey]
                              stringByAppendingPathExtension:kAFCacheDefaultPathExtension];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            
            NSError *error = nil;
            if(![[NSFileManager defaultManager] removeItemAtPath:filePath error:&error]) {
                NSLog(@"%@", error);
            }
        }
        
        NSData *dataToBeWritten = nil;
        id objToBeWritten = self.memoryCacheDic[key];
        dataToBeWritten = [NSKeyedArchiver archivedDataWithRootObject:objToBeWritten];
        [dataToBeWritten writeToFile:filePath atomically:YES];
    }];
    
    [self.memoryCacheDic removeAllObjects];
    [self.recentUsedKeys removeAllObjects];
}
- (void)setCacheData:(NSData *)data
              forKey:(NSString *)key
{
    dispatch_async(self.queue, ^{
        
        self.memoryCacheDic[key] = data;
        // inserts the recently added item's key into the top of the queue.
        NSUInteger index = [self.recentUsedKeys indexOfObject:key];
        if(index != NSNotFound) {
            [self.recentUsedKeys removeObjectAtIndex:index];
        }
        [self.recentUsedKeys insertObject:key atIndex:0];
        
        if(self.recentUsedKeys.count > self.cacheMemoryCost) {
            //这里应用了LRU（Least Recently Used)内存置换算法，对超过内存限定的缓存内容进行删除
            id<NSCopying> lastUsedKey = self.recentUsedKeys.lastObject;
            id objectThatNeedsToBeWrittenToDisk = [NSKeyedArchiver archivedDataWithRootObject:self.memoryCacheDic[lastUsedKey]];
            [self.memoryCacheDic removeObjectForKey:lastUsedKey];
            
            NSString *stringKey = [NSString stringWithFormat:@"%@", lastUsedKey];
            NSString *filePath = [[self.directoryPath stringByAppendingPathComponent:stringKey] stringByAppendingPathExtension:kAFCacheDefaultPathExtension];
            if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                
                NSError *error = nil;
                if(![[NSFileManager defaultManager] removeItemAtPath:filePath error:&error]) {
                    NSLog(@"Cannot remove file: %@", error);
                }
            }
            [objectThatNeedsToBeWrittenToDisk writeToFile:filePath atomically:YES];
            [self.recentUsedKeys removeLastObject];
        }
    });

}
- (NSData *)cacheDataForKey:(NSString *)key
{
    NSData *cachedData = self.memoryCacheDic[key];
    if(cachedData) return cachedData;
    NSString *stringKey = [NSString stringWithFormat:@"%@", key];
    NSString *filePath = [[self.directoryPath stringByAppendingPathComponent:stringKey]
                          stringByAppendingPathExtension:kAFCacheDefaultPathExtension];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        cachedData = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:filePath]];
        self.memoryCacheDic[key] = cachedData;
        return cachedData;
    }
    return nil;
}
@end
