//
//  LoginViewController.m
//  市场监管
//
//  Created by 网新中研 on 15/12/30.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "MainViewController.h"
#import "JinHuaMainViewController.h"
#import "MainTabBarViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton    *recordUserAndPasswordBtn;
@property (strong, nonatomic) IBOutlet UIButton    *loginButton;
@property (strong, nonatomic) IBOutlet UIButton    *recordUserAndPasswordCheckButton;
@property (strong, nonatomic) IBOutlet UILabel     *orgnizationLabel;
@property (strong, nonatomic) IBOutlet UIView      *messageArea;

@property (nonatomic, strong) LoginViewModel *loginViewModel;
@property (nonatomic, strong) AccountModel   *currentUser;
@property (nonatomic, assign) BOOL           isRecordAccountChecked;
@property (nonatomic, strong) NSString       *phoneNo;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- event
- (IBAction)loginClick:(UIButton *)sender {
    [self login];
}
- (IBAction)clickRecord:(id)sender {
    self.isRecordAccountChecked = !self.isRecordAccountChecked;
}

#pragma mark -- method

-(void)layoutView{
    
    self.view.backgroundColor = [UIColor colorFromHexCode:@"EEEEEE"];
    
    //设置登陆按钮样式
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.borderWidth  = 1;
    self.loginButton.layer.borderColor  = [UIColor colorFromHexCode:@"#69aaed"].CGColor;
    self.loginButton.backgroundColor    = [UIColor colorFromHexCode:@"#69aaed"];
    
    self.userTextField.delegate     = self;
    self.passwordTextField.delegate = self;
    
    //载入账号密码
    [self loadAccount];
    
    _isRecordAccountChecked = YES;
    
    [self.navigationController setNavigationBarHidden:YES];
}


-(void)loadAccount{
    
    NSLog(@"导入账号信息");
    
    self.currentUser = [self.loginViewModel getAccountFromLocal];
    
    if (self.currentUser.username!=nil
        && ![self.currentUser.username isEqual:@""]) {
        self.userTextField.text = self.currentUser.username;
    }
    if (self.currentUser.password!=nil
        && ![self.currentUser.password isEqual:@""]) {
        self.passwordTextField.text = self.currentUser.password;
    }
}

-(void)saveAccount{
    NSLog(@"保存账号信息");
    [self.loginViewModel saveAccount:self.currentUser];
}

-(BOOL)doCheck{
    if ([self.userTextField.text isEqualToString:@""]) {
        //请输入用户名
        [SFToastView showWithSuperView:self.view title:@"请输入用户名"];
        return NO;
    }
    
    if ([self.passwordTextField.text isEqualToString:@""]) {
        //请输入密码
        [SFToastView showWithSuperView:self.view title:@"请输入密码"];
        return NO;
    }

    self.currentUser.username = self.userTextField.text;
    self.currentUser.password = self.passwordTextField.text;
    self.currentUser.phoneNo  = @"";
    
    if (self.isRecordAccountChecked) {
        //保存登陆信息
        [self saveAccount];
    }
    
    return YES;
}

-(void)login{
    
    if(![self doCheck]){
        return;
    }
    
    MBProgressHUD *hud   = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode             = MBProgressHUDModeIndeterminate;
    hud.labelText        = @"请稍后";
    hud.detailsLabelText = @"连接服务器中...";
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        [self.loginViewModel login:self.currentUser completionHandler:^(id responseObj, NSError *error) {

            NSLog(@"%@", responseObj);
            if(error == nil){//请求成功
                NSString *loginFalg = [responseObj objectForKey:LOGIN_FLAG];
                if (![loginFalg isEqualToString:@"0"]) {
                    
                    NSString *area = [responseObj objectForKey:AREA];
                    if ([area isEqualToString:@"jinhua"]) {
                        
                        JinHuaMainViewController *jinhuaMainViewController = [JinHuaMainViewController new];
                        [self.navigationController showViewController:jinhuaMainViewController sender:nil];
                        
                    }else{
                        
                        //保存登录信息到缓存
                        [self.viewModel saveAccountDetail:responseObj];
                        
                        //登陆成功，显示主界面
                        MainTabBarViewController *mainTabBarViewController = [[MainTabBarViewController alloc]initWithLoginInfo:responseObj];
                        [self.navigationController showViewController:mainTabBarViewController sender:nil];
                        
                    }
                }else{
                    
                    //登陆失败
                    NSString *loginMessage = [responseObj objectForKey:LOGIN_MESSAGE];
                    [SFToastView showWithSuperView:self.messageArea title:loginMessage];
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
                
            }else{//请求失败
                    [SFToastView showWithSuperView:self.view title:[error.userInfo objectForKey:@"NSLocalizedDescription"]];
            }
            
        }];
    });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideKeyboard];
}

-(void)hideKeyboard{
    [self.userTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark --- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.userTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if(textField == self.passwordTextField){
        [self hideKeyboard];
    }
    return YES;
    
}

#pragma mark --- lazy loading

- (LoginViewModel *)loginViewModel {
	if(_loginViewModel == nil) {
		_loginViewModel = [[LoginViewModel alloc] init];
	}
	return _loginViewModel;
}

- (AccountModel *)currentUser {
	if(_currentUser == nil) {
		_currentUser = [[AccountModel alloc] init];
	} 
	return _currentUser;
}

-(void)setIsRecordAccountChecked:(BOOL)isRecordAccountChecked{
    
    if (isRecordAccountChecked) {
        [self.recordUserAndPasswordBtn setBackgroundImage:[UIImage imageNamed:@"check_y@2x.png"] forState:UIControlStateNormal];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"如果您遗失了手机，请及时到综合业务系统修改密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
    }else{
        [self.recordUserAndPasswordBtn setBackgroundImage:[UIImage imageNamed:@"check_n@2x.png"] forState:UIControlStateNormal];
    }
    
    _isRecordAccountChecked = isRecordAccountChecked;
}

@end
