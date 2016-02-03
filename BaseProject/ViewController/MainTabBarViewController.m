//
//  MainTabBarViewController.m
//  市场监管
//
//  Created by 网新中研 on 16/1/5.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MainViewController.h"
#import "HomeViewController.h"
#import "SetAppViewController.h"
#import "WebViewController.h"

@interface MainTabBarViewController ()
@property (nonatomic, strong)NSString *area;
@property (nonatomic, strong)NSDictionary *loginInfoDic;
@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(UIImage *)getTabImage:(NSString *)imageName{
    
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAutomatic];
}

-(void)layoutView{
    
    NSMutableDictionary *contextMutableDic = [NSMutableDictionary dictionaryWithDictionary:self.loginInfoDic];
    AccountDetailModel *accountDetailModel = [AccountDetailModel mj_objectWithKeyValues:self.loginInfoDic];
    
    //首页
    HomeViewController *homeViewController = [HomeViewController new];
    [homeViewController.tabBarItem setImage:[self getTabImage:@"bottom_ic1"]];
    [homeViewController.tabBarItem setSelectedImage:[self getTabImage:@"bottom_ic1_p"]];
    homeViewController.title = @"首页";
    homeViewController.contextDic = contextMutableDic;
    homeViewController.accountDetailModel = accountDetailModel;
    
    //应用
    SetAppViewController *setAppViewController = [SetAppViewController new];
    [setAppViewController.tabBarItem setImage:[self getTabImage:@"bottom_ic2"]];
    [setAppViewController.tabBarItem setSelectedImage:[self getTabImage:@"bottom_ic2_p"]];
    setAppViewController.title = @"应用";
    setAppViewController.contextDic = contextMutableDic;
    setAppViewController.accountDetailModel = accountDetailModel;
    
    //设置
    WebViewController *configViewController = [WebViewController new];
    [configViewController.tabBarItem setImage:[self getTabImage:@"bottom_ic3"]];
    [configViewController.tabBarItem setSelectedImage:[self getTabImage:@"bottom_ic3_p"]];
    configViewController.isBackButtonVisible = NO;
    configViewController.label.text = @"设置";
    configViewController.title = @"设置";
    configViewController.fistPageUrl = GET_REQUEST(@"scjgt.do?method=shezhi");
    
    //我
    WebViewController *myViewController = [WebViewController new];
    [myViewController.tabBarItem setImage:[self getTabImage:@"bottom_ic4"]];
    [myViewController.tabBarItem setSelectedImage:[self getTabImage:@"bottom_ic4_p"]];
    myViewController.isBackButtonVisible = NO;
    myViewController.label.text = @"我";
    myViewController.title = @"我";
    myViewController.fistPageUrl = GET_REQUEST(@"scjgt.do?method=wode");
    self.viewControllers = @[homeViewController, setAppViewController, configViewController, myViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithLoginInfo:(id)loginInfo{
    if (self = [super init]) {
        self.loginInfoDic = loginInfo;
        [self layoutView];
    }
    return self;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
