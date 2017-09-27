//
//  Defines.h
//  ProvinceInfo
//
//  Created by weijieMac on 2017/9/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

//单例模式宏模板
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

//系统
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
//获取设备唯一ID
#define DEVICEID [[UIDevice currentDevice].identifierForVendor UUIDString]

//Value
#define RealValue_W(value) ((value)/2.0/375.0f*[UIScreen mainScreen].bounds.size.width)
#define RealValue_H(value) ((value)/2.0/667.0f*[UIScreen mainScreen].bounds.size.height)

//Frame
#define SCREEN_SIZE [[UIScreen mainScreen]bounds].size
#define SCREEN_FRAME [[UIScreen mainScreen]bounds]
#define SCREEN_WIDTH SCREEN_SIZE.width
#define SCREEN_HEIGHT SCREEN_SIZE.height
#define SCREEN_CENTER_X SCREEN_SIZE.width/2
#define SCREEN_CENTER_Y SCREEN_SIZE.height/2
#define NAVI_HEIGHT 64
#define TABBAR_HEIGHT 50

//自定义颜色
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

//系统颜色
#define WHITECOLOR [UIColor whiteColor]
#define CLEARCOLOR [UIColor clearColor]
#define BLACKCOLOR [UIColor blackColor]
#define ORANGECOLOR [UIColor orangeColor]
#define DEFAULTBACKGROUNDCOLOR RGBA(240,240,240,1)
#define NAVTITLECOLOR RGBA(31,84,139,1)
#define TABNORMALCOLOR RGBA(111, 111, 111, 1)
//系统字体
#define SystemFont(size) [UIFont systemFontOfSize:(size)]
#define SystemBloFont(size) [UIFont boldSystemFontOfSize:(size)]
//* 适配字体  *//
#define AutoFont(size)     [UIFont systemFontOfSize:size * SCREEN_WIDTH/(375.0f)]
#define AutoBoldFont(size)     [UIFont boldSystemFontOfSize:size * SCREEN_WIDTH/(375.0f))]

//防止block里引用self造成循环引用
#define WeakObject(obj/*对象*/)  __weak __typeof(obj)weak##obj = obj;

//weakself
#define WeakSelf __weak __typeof__(self) weakSelf = self;

//strongself
#define StrongSelf __strong __typeof(self) strongSelf = weakSelf;

//沙盒路径
#define LibraryPath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//window
#define  kWindow   [[[UIApplication sharedApplication] delegate] window]

#endif /* Defines_h */
