//
//  HomeViewController.m
//  市场监管
//
//  Created by 网新中研 on 16/1/6.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "HomeViewController.h"
#import "InstalledFunctionGroupView.h"
#import "HomeViewModel.h"
#import "WebViewController.h"
#import "FunctionGoupPopView.h"
#import "CaptureViewController.h"
#import "SearchViewController.h"

@interface HomeViewController ()

@property (strong, nonatomic) IBOutlet UIView   *topView;
@property (strong, nonatomic) IBOutlet UIView   *top2View;
@property (strong, nonatomic) IBOutlet UIButton *captureBtn;
@property (nonatomic, strong) UIView   *currentGroupView;

@property (nonatomic, strong) UIScrollView  *functionScrollView;
@property (nonatomic, strong) HomeViewModel *homeViewModel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //KVO观察
    [self.accountDetailModel addObserver:self forKeyPath:HASFUNCTION options:NSKeyValueObservingOptionNew context:nil];
    self.userid = self.accountDetailModel.userid;
    self.gxdw = self.accountDetailModel.gxdw;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)dealloc{
    //移除KVO观察
    [self.accountDetailModel removeObserver:self forKeyPath:HASFUNCTION];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:HASFUNCTION]) {//安装功能项修改
        {
            [self layoutView];
        }
    }
}

-(void)layoutView{
    [self initFunctionScrollView];

    self.topView.backgroundColor  = [UIColor colorFromHexCode:@"#5ca5ed"];
    self.view.backgroundColor     = [UIColor colorFromHexCode:@"edf0f2"];
    self.top2View.backgroundColor = [UIColor colorFromHexCode:@"5ca5ed"];
    
    [self.view addSubview:self.functionScrollView];
    
    //信息查询
    [self addFunctionGroup:@"信息查询" functions:[self.homeViewModel getCXFunctions:self.accountDetailModel]];
    
    //执法监管
    [self addFunctionGroup:@"执法监管" functions:[self.homeViewModel getZFFunctions:self.accountDetailModel]];
    
    //办公辅助
    [self addFunctionGroup:@"办公辅助" functions:[self.homeViewModel getFZFunctions:self.accountDetailModel]];
}

#define GROUP_GAP 15

-(void)addFunctionGroup:(NSString *)titile functions:(NSArray *)functions{
    
    if (functions.count <= 0) {
        return;
    }
    InstalledFunctionGroupView *functionGroupView = [[InstalledFunctionGroupView alloc]initWithTitle:titile functions:functions clickHandler:^(FunctionModel *functionModel) {
        [self functionItemClick:functionModel];
    }];
    functionGroupView.frame = CGRectMake(0,self.functionScrollView.contentSize.height, _functionScrollView.frame.size.width, functionGroupView.height);
    self.functionScrollView.contentSize = CGSizeMake(self.functionScrollView.contentSize.width, functionGroupView.frame.size.height + self.functionScrollView.contentSize.height + GROUP_GAP);
    [self.functionScrollView addSubview:functionGroupView];
}

-(void)functionItemClick:(FunctionModel *)functionModel{
    
    [self.currentGroupView removeFromSuperview];

    AccountDetailModel *accountDetail = [self.homeViewModel getAccountDetail:self.contextDic];
    NSString *action = functionModel.functionaction;
    if ([functionModel.functionaction rangeOfString:@"Activity"].location != NSNotFound) {//一些纯客户端的东西
        
        //标注查询分区 地图版本
        if ([functionModel.functionid isEqualToString:@"33"]) {
            return;
        }
        
        //功能集合的处理
        NSArray *subFunctionsArray = [self.homeViewModel getSubFunctions:functionModel];
        if (subFunctionsArray != nil) {
            FunctionGoupPopView *functionGroupPopView = [[FunctionGoupPopView alloc]initWithFunction:functionModel subFunctions:subFunctionsArray clickHandler:^(FunctionModel *functionModel) {
                [self functionItemClick:functionModel];
            }];
            functionGroupPopView.frame = CGRectMake(0, 0, kWindowW / 4 * 3, functionGroupPopView.height);
            self.currentGroupView = [self popShow:functionGroupPopView];
            return;
        }
        
        //自定义界面的处理
        BaseViewController *baseViewController = [self.homeViewModel getViewController:functionModel];
        if (baseViewController !=nil) {
            [self.navigationController pushViewController:baseViewController animated:YES];
            return;
        }
        
        //无对应功能项，显示正在建设中
        [SFToastView showWithSuperView:self.view title:@"该功能正在建设中..."];
        
        return;
    }else if([functionModel.functionid isEqualToString:@"06"]){//12315
        
        if ([accountDetail.ssjbuserid isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您未开通权限！请到“设置”中开通用户权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            action = @"menu_enter.action?flag=ssjb";//12315执法
        }
    }else if([functionModel.functionid isEqualToString:@"12"]){//公文处理
        
        if ([accountDetail.oauserid isEqualToString:@""]) {
            [self showNoRightToast];
        }else{
            action = @"menu_enter.action?flag=gwcl";//公文处理
        }
    }else if([functionModel.functionid isEqualToString:@"11"]){//电子邮件
        if ([accountDetail.emailname isEqualToString:@""]) {
            [self showNoRightToast];
        }
    }
    
    //加载Web界面
    [super openWebViewControllerWithRequestString:GET_REQUEST(action) title:functionModel.functionname isNavgationBarVisible:YES];
}

/**
 *  提示用户权限未开通
 */
-(void)showNoRightToast{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您未开通权限！请到“设置”中开通用户权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark --- event
- (IBAction)captureClick:(id)sender {
    [self openCaptureForReuslt];
}

- (IBAction)searchClick:(id)sender {
    SearchViewController *searchViewController = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchViewController animated:YES];
}


#pragma mark --- lazy loading

#define HEIGHT 70
#define MARGIN_GAP 10

#define LAYOUT_MARGIN_TOP 2
#define LAYOUT_MARGIN_BOTTOM 5
#define LAYOUT_MARGIN_LEFT 10
#define LAYOUT_MARGIN_RIGHT 10

-(void)initFunctionScrollView{
    REMOVE_SUBVIEWS(self.functionScrollView);
    self.functionScrollView.frame = CGRectMake(LAYOUT_MARGIN_LEFT, LAYOUT_MARGIN_TOP + HEIGHT, kWindowW - 2 * LAYOUT_MARGIN_LEFT, kWindowH - HEIGHT - LAYOUT_MARGIN_BOTTOM - self.tabBarController.tabBar.frame.size.height);
    self.functionScrollView.contentSize = CGSizeMake(_functionScrollView.frame.size.width, 0);
    self.functionScrollView.backgroundColor                = [UIColor clearColor];
    self.functionScrollView.showsHorizontalScrollIndicator = NO;
    self.functionScrollView.showsVerticalScrollIndicator   = NO;
    self.functionScrollView.bounces                        = NO;
    self.functionScrollView.alwaysBounceVertical           = NO;
    self.functionScrollView.alwaysBounceHorizontal         = NO;
}

- (UIScrollView *)functionScrollView {
	if(_functionScrollView == nil) {
		_functionScrollView = [[UIScrollView alloc] init];
        [self initFunctionScrollView];
	}
	return _functionScrollView;
}

- (HomeViewModel *)homeViewModel {
	if(_homeViewModel == nil) {
		_homeViewModel = [[HomeViewModel alloc] init];
	}
	return _homeViewModel;
}

@end
