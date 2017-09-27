//
//  PI_RootVC.h
//  SingleChat
//
//  Created by weijieMac on 2017/3/2.
//  Copyright © 2017年 weijieMac. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *	@brief	所有的ViewController继承此类
 */
@interface PI_RootVC : UIViewController

/**
 *  @brief 获取当前网络状态
 */
//@property (nonatomic,assign,readonly) AFNetworkReachabilityStatus networkStatus;


/**
 *  @brief 自定义navBar
 */
@property (nonatomic,strong) UIView *navView;

/**
 *  @brief 自定义titleLabel
 */
@property (nonatomic,strong)  UILabel *titleLabel;

/**
 *  @brief navBar左上角的返回按钮，不适用的时候设置hidden = YES
 */
@property (nonatomic,strong) UIButton *leftBtn;

/**
 *  @brief navBar右上角button，不适用的时候设置hidden = YES
 */
@property (strong, nonatomic) UIButton *rightBtn;

/**
 *  @brief 设置状态栏颜色是否为深色
 */
@property (assign, nonatomic) BOOL statusBarStyleIsDark;

/**
 *  @brief 控制侧滑操作
 */
@property (nonatomic,assign) BOOL popGestureEabled;

/**
 *  @brief 设置NavBar的标题
 *
 *  @param title 标题
 */
- (void)setTextTitle:(NSString *)title;

/**
 *  @brief 设置NavBar标题颜色
 *
 *  @param titleColor 标题颜色
 */
- (void)setTitleColor:(UIColor *)titleColor;

/**
 *  @brief 设置NavBar标题字体
 *
 *  @param titleFont 标题字体
 */
- (void)setTitleFont:(UIFont *)titleFont;

/**
 *  @brief 视图配置
 */
- (void)configView;

/**
 *  @brief 变量初始化
 */
- (void)variableInit;

/**
 *  @brief viewDidLoad进行的数据请求
 */
- (void)dataRequest;

/**
 *  @brief viewDidAppear进行的数据请求
 */
- (void)appearDataRequest;

/**
 *  @brief 显示navi底部灰线
 */
- (void)showNaviLine;

/**
 *  @brief 隐藏navi底部灰线
 */
- (void)hiddenNaviLine;
@end
