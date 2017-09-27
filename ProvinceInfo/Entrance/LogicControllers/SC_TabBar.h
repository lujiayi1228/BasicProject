//
//  SC_TabBar.h
//  SingleChat
//
//  Created by weijieMac on 2017/3/2.
//  Copyright © 2017年 weijieMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SC_TabBar;

@protocol SCBottomBarDelegate <NSObject>

@optional

- (void)bottomBar:(SC_TabBar *)tabBar didSelectViewController:(UIViewController *)viewController;

@end

/**
 *  @brief 自定义tabbar
 */
@interface SC_TabBar : UIToolbar

@property (weak, nonatomic) id<SCBottomBarDelegate> barDelegate;


/**
 *  @brief tabbar选中的controller
 */
@property (strong, nonatomic) UIViewController *selectedController;


/**
 *  @brief tabbar选中的index 第一页为0
 */
@property (assign, nonatomic) NSInteger selectedIndex;

DEFINE_SINGLETON_FOR_HEADER(SC_TabBar)

/**
 *  @brief 显示自定义tabbar
 */
+ (void)showTabbar;

/**
 *  @brief 隐藏自定义tabbar
 */
+ (void)hideTabbar;

/**
 *	@brief	跳转到某个页面，从0开始 ...
 *
 *	@param 	pageIndex 	页码
 */
+ (id)gotoPageIndex:(NSInteger)pageIndex;

/**
 *  @brief 更新视图
 */
+ (void)reloadView;

/**
 *  @brief 类方法获取选中的controller
 */
+ (UIViewController *)selectedController;

/**
 *  @brief 类方法获取选中的索引
 */
+ (NSInteger)selectedIndex;


@end
