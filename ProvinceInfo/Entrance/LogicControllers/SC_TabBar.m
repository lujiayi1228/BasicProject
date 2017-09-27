//
//  SC_TabBar.m
//  SingleChat
//
//  Created by weijieMac on 2017/3/2.
//  Copyright © 2017年 weijieMac. All rights reserved.
//

#import "SC_TabBar.h"
#import "PI_RootVC.h"
#import "SC_NavigationController.h"

@interface SC_TabBar()
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) NSMutableArray *titlesArray;
@property (strong, nonatomic) NSMutableArray *viewsArray;
@property (strong, nonatomic) NSMutableArray *navsArray;
@property (strong, nonatomic) NSDictionary   *plistData;

@end

@implementation SC_TabBar
DEFINE_SINGLETON_FOR_CLASS(SC_TabBar)

#pragma mark --- 类方法
+ (void)showTabbar
{
    UIViewController *rootViewController = [[UIApplication sharedApplication].delegate window].rootViewController;
    [rootViewController.view addSubview:[SC_TabBar sharedSC_TabBar]];
}

+ (void)hideTabbar
{
    [[SC_TabBar sharedSC_TabBar] removeFromSuperview];
}

+ (NSInteger)selectedIndex
{
    return [[SC_TabBar sharedSC_TabBar] selectedIndex];
}

+ (UIViewController *)selectedController
{
    return [[SC_TabBar sharedSC_TabBar] selectedController];
}

+ (id)gotoPageIndex:(NSInteger)pageIndex
{
   return [[SC_TabBar sharedSC_TabBar] gotoPageIndex:pageIndex];
}

+ (void)reloadView
{
    [[SC_TabBar sharedSC_TabBar] reloadView];
}

#pragma mark --- 实例方法
- (instancetype)init
{
    if (self = [super init]) {
        [self configView];
    }
    return self;
}

- (void)configView
{
    self.backgroundColor = WHITECOLOR;
    self.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    self.itemsArray  = [[NSMutableArray alloc]init];
    self.viewsArray  = [[NSMutableArray alloc]init];
    self.navsArray   = [[NSMutableArray alloc]init];
    self.titlesArray = [[NSMutableArray alloc]init];
    self.selectedIndex = -1;
    [self createBtns];
    [self createViewControllers];
    
}

- (void)createBtns
{
    
    CGFloat kBtnWidth = SCREEN_WIDTH/self.plistData.allKeys.count;
    for (NSString *key in self.plistData.allKeys){
        
        NSDictionary *dic = [self.plistData objectForKey:key];
        NSDictionary *imageNames = [dic objectForKey:@"imageNames"];
        NSString *normalImageName = [imageNames objectForKey:@"normal"];
        NSString *selectedImageName = [imageNames objectForKey:@"selected"];
        NSString *itemName = dic[@"ItemName"];
        UIButton *kBtn = [self customItemBtn];
        if (normalImageName) {
            [kBtn setImage:[UIImage imageNamed:normalImageName]
                  forState:UIControlStateNormal];
        }
        if (selectedImageName) {
            [kBtn setImage:[UIImage imageNamed:selectedImageName]
                  forState:UIControlStateSelected];
            [kBtn setImage:[UIImage imageNamed:selectedImageName]
                  forState:UIControlStateHighlighted];
            [kBtn setImage:[UIImage imageNamed:selectedImageName]
                  forState:UIControlStateSelected | UIControlStateHighlighted];
        }
        
        kBtn.selected = (key.integerValue == 0);
        kBtn.tag = key.intValue;
        kBtn.frame = CGRectMake(kBtnWidth*kBtn.tag, 0, kBtnWidth, TABBAR_HEIGHT);
        [kBtn setImageEdgeInsets:UIEdgeInsetsMake(-8, 0, 8, 0)];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kBtn.left, kBtn.height-20, kBtnWidth, 20)];
        title.textColor = key.integerValue == 0 ? NAVTITLECOLOR : TABNORMALCOLOR;
        title.font = AutoFont(14);
        title.backgroundColor = CLEARCOLOR;
        title.textAlignment = NSTextAlignmentCenter;
        title.tag = key.integerValue;
        [self addSubview:title];
        if (itemName) {
            title.text = itemName;
        }
        
        [self addSubview:kBtn];
        [self.itemsArray addObject:kBtn];
        [self.titlesArray addObject:title];
    }
    
}

- (UIButton *)customItemBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:TABNORMALCOLOR forState:UIControlStateNormal];
    [btn setTitleColor:NAVTITLECOLOR forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)createViewControllers
{
    for (int i = 0; i < self.plistData.allKeys.count; i ++) {
        NSDictionary *dic = [self.plistData objectForKey:[NSString stringWithFormat:@"%d",i]];
        NSString *className = dic[@"ClassName"];
        PI_RootVC *rootVC = [(PI_RootVC *)[NSClassFromString(className) alloc]init];
        [self.viewsArray addObject:rootVC];
        
        SC_NavigationController *nav = [[SC_NavigationController alloc]initWithRootViewController:rootVC];
        [nav.navigationBar setBarTintColor:NAVTITLECOLOR];
        [self.navsArray addObject:nav];
        switch (i) {
            case 0:
            {
                [MainViewLogic sharedMainViewLogic].homeNav = nav;
                [MainViewLogic sharedMainViewLogic].provinceVC = (id)rootVC;
            }
                break;
            case 1:
            {
                [MainViewLogic sharedMainViewLogic].releaseNav = nav;
                [MainViewLogic sharedMainViewLogic].releaseHomeVC = (id)rootVC;
            }
                break;
            case 2:
            {
                [MainViewLogic sharedMainViewLogic].readNav = nav;
                [MainViewLogic sharedMainViewLogic].readHomeVC = (id)rootVC;
            }
                break;
            case 3:
            {
                [MainViewLogic sharedMainViewLogic].contactNav = nav;
                [MainViewLogic sharedMainViewLogic].contactHomeVC = (id)rootVC;
            }
                break;
            default:
                break;
        }
    }
}

- (void)btnAction:(UIButton *)btn
{
    [self gotoPageIndex:(NSInteger)btn.tag];
}

- (id)gotoPageIndex:(NSInteger)pageIndex
{
    if (self.selectedIndex == pageIndex) {
        return self.selectedController;
    }
    if (pageIndex >= self.plistData.count || pageIndex < 0) {
        return nil;
    }
    [self setCurrentSelectedIndex:pageIndex];
    
    UIWindow * window = [[[UIApplication sharedApplication]delegate]window];
    
    PI_RootVC *controller = self.viewsArray[pageIndex];
    UINavigationController *nav = self.navsArray[pageIndex];
    
    [MainViewLogic sharedMainViewLogic].selectedNav = nav;
    
    [window setRootViewController:nav];
    
    if (![controller.view.subviews containsObject:self]) {
        [controller.view addSubview:self];
    }
    if ([self.barDelegate respondsToSelector:@selector(bottomBar:didSelectViewController:)]) {
        [self.barDelegate bottomBar:self didSelectViewController:controller];
    }
    self.selectedController = controller;
    self.selectedIndex = pageIndex;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tabbardidselected" object:nil];
    
    return controller;
}

- (void)setCurrentSelectedIndex:(NSInteger)index
{
    for (UIButton *btn in self.itemsArray){
        if (btn.tag==index) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    for (UILabel *label in self.titlesArray) {
        if (label.tag==index) {
            label.textColor = NAVTITLECOLOR;
        }else{
            label.textColor = TABNORMALCOLOR;
        }
    }
}

- (void)reloadView
{
    [self cleanViews];
    [self configView];
}

- (void)cleanViews{
    for (UIView *view in self.subviews){
        [view removeFromSuperview];
    }
    self.plistData = nil;
    [self.navsArray removeAllObjects];
    [self.viewsArray removeAllObjects];
    
}

- (NSDictionary *)plistData
{
    if (!_plistData) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"ProvinceInfo" ofType:@"plist"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary: [NSDictionary dictionaryWithContentsOfFile:plistPath]];
        _plistData = [dic copy];
    }
    return _plistData;
}

@end
