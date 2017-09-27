//
//  PI_RootVC.m
//  SingleChat
//
//  Created by weijieMac on 2017/3/2.
//  Copyright © 2017年 weijieMac. All rights reserved.
//

#import "PI_RootVC.h"

@interface PI_RootVC ()
@property (strong, nonatomic) CALayer *naviLine;
@end

@implementation PI_RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self variableInit];
    [self configView];
    [self dataRequest];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkNetworkStatus];
    [self appearDataRequest];
    if (self.statusBarStyleIsDark)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }else
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



#pragma mark--
#pragma 视图设置--
- (void)setTextTitle:(NSString *)title
{
    self.titleLabel.text = title;
}
- (void)setTitleColor:(UIColor *)titleColor
{
    self.titleLabel.textColor = titleColor;
}
- (void)setTitleFont:(UIFont *)titleFont
{
    self.titleLabel.font = titleFont;
}

- (void)showNaviLine
{
    self.naviLine.hidden = NO;
}

- (void)hiddenNaviLine
{
    self.naviLine.hidden = YES;
}

- (void)configView
{
    
    self.view.backgroundColor = DEFAULTBACKGROUNDCOLOR;
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.navView.backgroundColor = WHITECOLOR;
    [self.view addSubview:self.navView];

    [self.navView.layer addSublayer:self.naviLine];
    
    [self.navView addSubview:self.titleLabel];
    [self.navView addSubview:self.leftBtn];
    
    [self.navView addSubview:self.rightBtn];
    
}

- (void)variableInit{
    
}
- (void)dataRequest{
    
}
- (void)appearDataRequest{
    
}
- (void)leftBtnClicked:(UIButton *)sender
{
    //子类实现
}

- (void)rightBtnClicked:(UIButton *)sender
{
    //子类实现
}

- (void)setPopGestureEabled:(BOOL)popGestureEabled{
    
    self.navigationController.interactivePopGestureRecognizer.enabled = popGestureEabled;
}

#pragma mark--
#pragma Rotation--
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


#pragma mark--
#pragma 网络监测
- (void)checkNetworkStatus
{
    //    MLNetworkStatusCheck *networkCheck = [MLNetworkStatusCheck sharedMLNetworkStatusCheck];
    //    [networkCheck startObserveNetwork];
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netStatusChangeNoti:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)netStatusChangeNoti:(NSNotification *)noti
{
    //    _networkStatus = [MLNetworkStatusCheck sharedMLNetworkStatusCheck].networkReachabilityStatus;
    //    if (_networkStatus==AFNetworkReachabilityStatusNotReachable) {
    //
    //    }else if (_networkStatus==AFNetworkReachabilityStatusReachableViaWWAN||_networkStatus==AFNetworkReachabilityStatusReachableViaWiFi){
    //        [[MLFailRequestManager sharedMLFailRequestManager]operateFailRequest];
    //    }
}

#pragma mark--
#pragma 内存警告

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

#pragma mark --- Getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-100, 22, 200, 40)];
        _titleLabel.backgroundColor = CLEARCOLOR;
        _titleLabel.textColor = NAVTITLECOLOR;
        _titleLabel.font = AutoFont(20);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, (SCREEN_WIDTH - self.titleLabel.width-10)/2, 44)];
        _leftBtn.backgroundColor = CLEARCOLOR;
        UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 4, 36, 36)];
        leftImg.image = [UIImage imageNamed:@"navi_left"];
        leftImg.contentMode = UIViewContentModeCenter;
        [_leftBtn addSubview:leftImg];
        
        [_leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:self.leftBtn.frame];
        _rightBtn.right = self.navView.right - 5;
        _rightBtn.backgroundColor = CLEARCOLOR;
        UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 4, 36, 36)];
        rightImg.left = _rightBtn.width - rightImg.width;
        rightImg.image = [UIImage imageNamed:@"navi_left"];
        rightImg.contentMode = UIViewContentModeCenter;
        [_rightBtn addSubview:rightImg];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (CALayer *)naviLine
{
    if (!_naviLine) {
        _naviLine = [[CALayer alloc]init];
        _naviLine.frame = CGRectMake(0, self.navView.height-0.5, self.navView.width, 0.5);
        _naviLine.backgroundColor = RGBA(222, 222, 222, 1).CGColor;
    }
    return _naviLine;
}

@end
