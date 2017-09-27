//
//  MainViewLogic.h
//  SingleChat
//
//  Created by weijieMac on 2017/3/2.
//  Copyright © 2017年 weijieMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ProvinceVC;
@class ReleaseHomeVC;
@class ReadHomeVC;
@class ContactHomeVC;

@interface MainViewLogic : NSObject

//全局获取当前使用的navi
@property (strong, nonatomic) UINavigationController    *selectedNav;

//全局获取当前主页面
@property (strong, nonatomic) ProvinceVC                    *provinceVC;
@property (strong, nonatomic) ReleaseHomeVC             *releaseHomeVC;
@property (strong, nonatomic) ReadHomeVC                *readHomeVC;
@property (strong, nonatomic) ContactHomeVC             *contactHomeVC;
//全局获取当前主页面所用navi
@property (strong, nonatomic) UINavigationController    *homeNav;
@property (strong, nonatomic) UINavigationController    *releaseNav;
@property (strong, nonatomic) UINavigationController    *readNav;
@property (strong, nonatomic) UINavigationController    *contactNav;

DEFINE_SINGLETON_FOR_HEADER(MainViewLogic)

/**
 *	@brief	呈现引导页
 */
+ (void)windowShowGuideView;

/**
 *	@brief	呈现登陆页
 */
+ (void)windowShowLoginView;

/**
 *	@brief	呈现内容主页面
 */
+ (void)windowShowHomeView;



/**
 *  @brief 全局获取当前选中tab的UINavigationController
 */
+ (UINavigationController *)selectedNav;

/**
 *  @brief 全局获取主页面的nav
 */
+ (UINavigationController *)homeNav;

/**
 *  @brief 全局获取聊天页面的nav
 */
+ (UINavigationController *)releaseNav;

/**
 *  @brief 全局获取用户中心的nav
 */
+ (UINavigationController *)readNav;

/**
 *  @brief 全局获取商城的nav
 */
+ (UINavigationController *)contactNav;

/**
 *  @brief 全局获取主页面的controller
 */
+ (ProvinceVC *)provinceVC;

/**
 *  @brief 全局获取聊天主页面的Controller
 */
+ (ReleaseHomeVC *)releaseHomeVC;

/**
 *  @brief 全局获取用户中心的Controller
 */
+ (ReadHomeVC *)readHomeVC;

/**
 *  @brief 全局获取商城的Controller
 */
+ (ContactHomeVC *)contactHomeVC;

@end
