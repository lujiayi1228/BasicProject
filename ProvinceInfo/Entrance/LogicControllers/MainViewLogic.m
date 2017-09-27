//
//  MainViewLogic.m
//  SingleChat
//
//  Created by weijieMac on 2017/3/2.
//  Copyright © 2017年 weijieMac. All rights reserved.
//

#import "MainViewLogic.h"

@implementation MainViewLogic

DEFINE_SINGLETON_FOR_CLASS(MainViewLogic)

+ (void)windowShowHomeView
{
    [self showView:@"SC_LeadingVC"];
}

+ (void)windowShowLoginView
{
    [self showView:@"SC_NewloginMainVC"];
}

+ (void)windowShowGuideView
{
    [self showView:@"SC_GuideViewController"];
}

+ (void)showView:(NSString *)vcName
{
    UIWindow * window = [[[UIApplication sharedApplication]delegate]window];
    if ([window.rootViewController isKindOfClass:NSClassFromString(vcName)]) {
        return;
    }
    UIViewController *controller = [[NSClassFromString(vcName) alloc]init];
    [window setRootViewController:controller];
    [window makeKeyAndVisible];
}

//以下可用runtime 节省代码
+ (UINavigationController *)selectedNav
{
    return [MainViewLogic sharedMainViewLogic].selectedNav;
}

+ (UINavigationController *)homeNav
{
    return [MainViewLogic sharedMainViewLogic].homeNav;
}

+ (UINavigationController *)releaseNav
{
    return [MainViewLogic sharedMainViewLogic].releaseNav;
}

+ (UINavigationController *)readNav
{
    return [MainViewLogic sharedMainViewLogic].readNav;
}

+ (UINavigationController *)contactNav
{
    return [MainViewLogic sharedMainViewLogic].contactNav;
}

+ (ProvinceVC *)provinceVC
{
    return [MainViewLogic sharedMainViewLogic].provinceVC;
}

+ (ReleaseHomeVC *)releaseHomeVC
{
    return [MainViewLogic sharedMainViewLogic].releaseHomeVC;
}

+ (ReadHomeVC *)readHomeVC
{
    return [MainViewLogic sharedMainViewLogic].readHomeVC;
}

+ (ContactHomeVC *)contactHomeVC
{
    
    return [MainViewLogic sharedMainViewLogic].contactHomeVC;
}

@end
