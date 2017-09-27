//
//  SC_LeadingVC.m
//  SingleChat
//
//  Created by weijieMac on 2017/3/2.
//  Copyright © 2017年 weijieMac. All rights reserved.
//

#import "SC_LeadingVC.h"
#import "SC_TabBar.h"
@interface SC_LeadingVC ()

@end

@implementation SC_LeadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configView];
  
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable ) {
              [SVProgressHUD showErrorWithStatus:@"网络异常"];
            return ;
        }
    }];
}

- (void)configView
{
    self.view.backgroundColor = WHITECOLOR;
    [self addtabbar];
}

- (void)addtabbar
{
    [SC_TabBar showTabbar];
    [SC_TabBar gotoPageIndex:0];    
}

#pragma mark - Rotation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
