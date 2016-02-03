//
//  BaseViewController.m
//  市场监管
//
//  Created by 网新中研 on 15/12/29.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import "BaseViewController.h"
#import "WebViewController.h"
#import "SingatureViewController.h"
#import "CaptureViewController.h"

//扫码
#import "SubLBXScanViewController.h"
#import "MyQRViewController.h"
#import "LBXScanView.h"
#import <objc/message.h>
#import "ScanResultViewController.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"

#define ACTION_SHEET_TYPE_GET_PICTURE 1

typedef void(^OnGetPirctureBlock)(UIImage *, NSString *);


@interface BaseViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,retain ) UIButton    *backButton;
@property (nonatomic,retain ) UIImageView *backButtonImageView;
@property (nonatomic,retain ) UILabel     *titleLable;
@property (nonatomic, strong) UIImageView *rightBarButtonImageView;
@property (nonatomic, strong) UIButton    *rightBarButton;

@property (nonatomic, copy) OnGetPirctureBlock onGetPictureHandler;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self layoutView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)layoutView{
    [self showViewWithNavigation];
}

-(void)openCapture:(ScanFinishedBlock)completeHandler{
    CaptureViewController *captureVC = [[CaptureViewController alloc]initCompleteHander:completeHandler];
    [self presentViewController:captureVC animated:YES completion:nil];
}

/**
 *  扫码
 */
-(void)openCaptureForReuslt{
    

    //设置扫码区域参数设置

    //创建参数对象
    LBXScanViewStyle *style      = [[LBXScanViewStyle alloc]init];

    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset         = 44;

    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle   = LBXScanViewPhotoframeAngleStyle_Outer;

    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW        = 6;

    //扫码框周围4个角的宽度
    style.photoframeAngleW       = 24;

    //扫码框周围4个角的高度
    style.photoframeAngleH       = 24;

    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle         = LBXScanViewAnimationStyle_LineMove;

    //线条上下移动图片
    style.animationImage         = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];

    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style                     = style;

    vc.isQQSimulator             = YES;
    
    vc.resultDelegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];

    
//    
//    CaptureViewController *captureVC = [[CaptureViewController alloc]init];
//
//    captureVC.resultDelegate         = self;
//    captureVC.gxdw                   = self.gxdw;
//    captureVC.userid                 = self.userid;
//    captureVC.czmk                   = self.czmk;
//    
//    [self presentViewController:captureVC animated:YES completion:nil];
    
}

-(void)openViewControllerForResult:(BaseViewController *)baseViewController{
    baseViewController.resultDelegate = self;
    baseViewController.gxdw           = self.gxdw;
    baseViewController.userid         = self.userid;
    baseViewController.czmk           = self.czmk;
    [self.navigationController pushViewController:baseViewController animated:YES];
}

-(id)openWebViewControllerWithRequestString:(NSString *)requestStr title:(NSString *)title isNavgationBarVisible:(BOOL)isNavigationBarVisible{
    //加载Web界面
    WebViewController *webViewController     = [[WebViewController alloc]init];
    webViewController.fistPageUrl            = requestStr;
    webViewController.isNavigationBarVisible = isNavigationBarVisible;
    webViewController.label.text             = title;
    [self.navigationController pushViewController:webViewController animated:YES];
    
    return webViewController;
}

-(id)openWebViewControllerWithRequestString:(NSString *)requestStr title:(NSString *)title isNavgationBarVisible:(BOOL)isNavigationBarVisible rightBarButtonImage:(UIImage *)image rightBarButtonClick:(void(^)(UIWebView * webView))clickHandler{
    //加载Web界面
    WebViewController *webViewController      = [[WebViewController alloc]init];
    webViewController.fistPageUrl             = requestStr;
    webViewController.isNavigationBarVisible  = isNavigationBarVisible;
    webViewController.isRightBarButtonVisible = YES;
    webViewController.rightBarButtonImage     = image;
    webViewController.label.text              = title;
    webViewController.resultDelegate          = self;
    webViewController.rightClickHandler       = clickHandler;
    [self.navigationController pushViewController:webViewController animated:YES];
    
    return webViewController;
}

-(void)openWebViewControllerWithRequestString:(NSString *)requestStr title:(NSString *)title rightBarButtonImage:(UIImage *)image rightBarButtonClick:(void(^)())clickHandler{
    //加载Web界面
    WebViewController *webViewController     = [[WebViewController alloc]init];
    webViewController.fistPageUrl            = requestStr;
    webViewController.isNavigationBarVisible = YES;
    webViewController.label.text             = title;
    webViewController.rightBarButtonImage    = image;
    webViewController.rightClickHandler      = clickHandler;
    webViewController.isRefreshButtonVisible = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

/**
 *  打开浏览器页面
 *
 *  @param requestStr             请求地址
 *  @param title                  功能描述
 *  @param isRefreshable          是否可向下刷新
 *  @param isNavigationBarVisible 导航条是否可见
 *  @param image                  右边按钮图片
 *  @param clickHandler           右边按钮当点击处理
 *  @param resultHandler          界面返回处理
 *
 *  @return 返回浏览器对象
 */
-(id)openWebViewControllerWithRequestString:(NSString *)requestStr title:(NSString *)title isRefreshable:isRefreshable isNavgationBarVisible:(BOOL)isNavigationBarVisible rightBarButtonImage:(UIImage *)image rightBarButtonClick:(void(^)(UIWebView * webView))clickHandler{
    //加载Web界面
    WebViewController *webViewController      = [[WebViewController alloc]init];
    webViewController.fistPageUrl             = requestStr;
    webViewController.isNavigationBarVisible  = isNavigationBarVisible;
    webViewController.isRightBarButtonVisible = YES;
    webViewController.rightBarButtonImage     = image;
    webViewController.label.text              = title;
    webViewController.resultDelegate          = self;
    webViewController.rightClickHandler       = clickHandler;
    [self.navigationController pushViewController:webViewController animated:YES];
    
    return webViewController;
}

-(void)getSystemPicture:(void(^)(UIImage *pickedPicture, NSString * filePath))onGetPictureHandler{
    
    self.onGetPictureHandler = onGetPictureHandler;
    
     //创建对象
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册获取",@"本地拍照", nil];
    actionSheet.tag = ACTION_SHEET_TYPE_GET_PICTURE;
    
    //在视图上展示
    [actionSheet showInView:self.view];
}

#pragma mark --- UIAlertViewDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (actionSheet.tag) {
        case ACTION_SHEET_TYPE_GET_PICTURE:
            if(buttonIndex == 0){
                //从相册中读取
                [self readImageFromAlbum];
            }else if(buttonIndex == 1){
                //拍照
                [self readImageFromCamera];
            }
        default:
            break;
    }
}

/**
 *  从相册中获取照片
 */
-(void)readImageFromAlbum{
    //创建对象
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //（选择类型）表示仅仅从相册中选取照片
    imagePicker.sourceType               = UIImagePickerControllerSourceTypePhotoLibrary;
    //指定代理，因此我们要实现UIImagePickerControllerDelegate, UINavigationControllerDelegate协议
    imagePicker.delegate                 = self;
    //设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    imagePicker.allowsEditing            = YES;
    //显示相册
    [self presentViewController:imagePicker animated:YES completion:nil];
}

/**
 *  拍照
 */
-(void)readImageFromCamera{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType               = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate                 = self;
        imagePicker.allowsEditing            = YES;
        //允许用户编辑
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        //弹出窗口响应点击事件
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"  message:@"未检测到摄像头" delegate:nil cancelButtonTitle:nil                                                 otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

#pragma mark --- UINavigationControllerDelegate, UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSURL *url = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    
    self.onGetPictureHandler([info objectForKey:@"UIImagePickerControllerEditedImage"], url.absoluteString);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- ResultDelegate
-(void)onResult:(NSDictionary *)responseParams requestCoe:(NSInteger)requestCode responseCode:(NSInteger)responseCode{
    
    NSLog(@"%@", self.userid);
    if (requestCode == REQUEST_CODE_SCAN) {
        NSString *resultString = [responseParams objectForKey:@"resultString"];
        
        if ([resultString containsString:@"注册号"]||
            [resultString containsString:@"统一社会信用代码"]) {
    
            //浙江地区处理
            if([VERAREA isEqualToString:@"zhejiang"]){
    
                //设置Web请求参数
                NSArray *keysArray      = [resultString componentsSeparatedByString:@";"];
                NSString *parameter     = [keysArray[0] stringByReplacingOccurrencesOfString:@"统一社会信用代码:" withString:@""];
                parameter               = [parameter stringByReplacingOccurrencesOfString:@"注册号:" withString:@""];

                NSString *requestString = [NSString stringWithFormat:@"%@%@", GET_REQUEST(@"scjgtZt.do?method=ztcx_detailByzch&_params="), parameter];

                //打开Web界面
                [self openWebViewControllerWithRequestString:requestString title:@"" isNavgationBarVisible:YES];
            }
        }else{
            
            
            
            NSDictionary *params = @{USERID:self.userid, @"key":resultString};
    
            [HttpHelper sendDataUrl:@"scjgtZt.do?method=ewmLogin_authCaUser" parameters:params completionHandler:^(id responseObj, NSError *error) {
                NSLog(@"%@", responseObj);
            }];
        }
    }
}

#pragma mark --- 自定义导航条

#define TITLE_LABEL_HEIGHT 60//标题高度
#define TITLE_LINE_HEIGHT 1//线条高度
#define JOB_TITLE_HEIGHT 20//标题文本纵向距离
#define TITLE_LABEL_TEXT_COLOR @"#333333"//导航栏标题颜色
#define TITLE_LABEL_BACKGROUD_COLOR @"#f9f9f9"//导航栏背景色
#define TITLE_LINE_COLOR @"#b4b4b4"//线条颜色

//显示视图并加上导航条
-(void)showViewWithNavigation{
    if(!self.isNavigationBarVisible)return;
    
    WS(weakSelf);
    
    //设置标题栏背景
    [self.view addSubview:self.titleLable];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view.mas_top);
            make.left.mas_equalTo(weakSelf.view.mas_left);
            make.right.mas_equalTo(weakSelf.view.mas_right);
            make.height.mas_equalTo(@TITLE_LABEL_HEIGHT);
        }];
    }else{
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view.mas_top);
            make.left.mas_equalTo(weakSelf.view.mas_left);
            make.right.mas_equalTo(weakSelf.view.mas_right);
            make.height.mas_equalTo(@(TITLE_LABEL_HEIGHT + 30));
        }];
    }
    
    //设置标题栏文字
    [self.view addSubview:self.label];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view.mas_top).offset(JOB_TITLE_HEIGHT);
            make.left.mas_equalTo(weakSelf.view.mas_left);
            make.right.mas_equalTo(weakSelf.view.mas_right);
            make.height.mas_equalTo(@(TITLE_LABEL_HEIGHT - JOB_TITLE_HEIGHT));
        }];
    }else{
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view.mas_top).offset((JOB_TITLE_HEIGHT-10));
            make.left.mas_equalTo(weakSelf.view.mas_left);
            make.right.mas_equalTo(weakSelf.view.mas_right);
            make.height.mas_equalTo(@(TITLE_LABEL_HEIGHT - JOB_TITLE_HEIGHT + 30));
        }];
    }
    
    //设置头部分隔线
    [self.view addSubview:self.titleLine];
    [self.titleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.label.mas_bottom);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        make.height.mas_equalTo(@(TITLE_LINE_HEIGHT));
    }];
    
    //设置返回按钮
    if (self.isBackButtonVisible) {
        [self.view addSubview:self.backButton];
        [self.view addSubview:self.backButtonImageView];
    }
    
    //设置搜索按钮
    if (self.isRightBarButtonVisible) {
        [self.view addSubview:self.rightBarButton];
        [self.view addSubview:self.rightBarButtonImageView];
    }
}

-(void)onRightBarButtonClick{
}

-(void)onGoBackClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 懒加载
-(UILabel *)label{
    if (_label == nil) {
        _label               = [[UILabel alloc]init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor     = [UIColor colorFromHexCode:TITLE_LABEL_TEXT_COLOR];
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            _label.font= [UIFont boldSystemFontOfSize:18.0f];
        }else{
            _label.font= [UIFont boldSystemFontOfSize:30.0f];
        }
    }
    return _label;
}

-(UIView *)titleLine{
    if (_titleLine == nil) {
        _titleLine                 = [[UIView alloc]init];
        _titleLine.backgroundColor = [UIColor colorFromHexCode:TITLE_LINE_COLOR];
    }
    return _titleLine;
}

-(UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable                 = [[UILabel alloc]init];
        _titleLable.backgroundColor = [UIColor colorFromHexCode:TITLE_LABEL_BACKGROUD_COLOR];
    }
    return _titleLable;
}

-(UIButton *)backButton{
    if (_backButton == nil) {
        float back_btn_width=0.0f;
        float back_btn_height=0.0f;
        float back_btn_orgheight=0.0f;//30.0f;
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            back_btn_width     = 50;
            back_btn_height    = 60;
            back_btn_orgheight = 30;
            
        }else{
            back_btn_width     = 65;
            back_btn_height    = 65;
            back_btn_orgheight = 38;
        }
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, back_btn_orgheight, back_btn_width, back_btn_height)];
        [_backButton addTarget:self action:@selector(onGoBackClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _backButton;
}

-(UIImageView *)backButtonImageView{
    if (_backButtonImageView == nil ) {
        
        float back_btn_width     = 0.0f;
        float back_btn_height    = 0.0f;
        float back_btn_orgheight = 30.0f;
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            back_btn_width     = 20;
            back_btn_height    = 20;
            back_btn_orgheight = 30;
        }else{
            back_btn_width     = 35;
            back_btn_height    = 35;
            back_btn_orgheight = 38;
        }
        
        _backButtonImageView       = [[UIImageView alloc]initWithImage:self.leftBarButtonImage];
        _backButtonImageView.frame = CGRectMake(10, back_btn_orgheight, back_btn_width, back_btn_height);
    }
    return _backButtonImageView;
}

- (UIButton *)rightBarButton {
	if(_rightBarButton == nil) {
        _rightBarButton     = [[UIButton alloc] init];
        float btn_width     = 0.0f;
        float btn_height    = 0.0f;
        float btn_orgheight = 0.0f;//30.0f;
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            btn_width     = 50;
            btn_height    = 60;
            btn_orgheight = 30;
            
        }else{
            btn_width     = 65;
            btn_height    = 65;
            btn_orgheight = 38;
        }
        _rightBarButton = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW - btn_width - 10, btn_orgheight, btn_width, btn_height)];
        [_rightBarButton addTarget:self action:@selector(onRightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _rightBarButton;
}

- (UIImageView *)rightBarButtonImageView {
    if(_rightBarButtonImageView == nil) {
        _rightBarButtonImageView = [[UIImageView alloc] init];

        float btn_width=0.0f;
        float btn_height=0.0f;
        float btn_orgheight=30.0f;
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            btn_width = 20;
            btn_height = 20;
            btn_orgheight=30;
        }else{
            btn_width = 35;
            btn_height = 35;
            btn_orgheight=38;
        }
        
        _rightBarButtonImageView = [[UIImageView alloc]initWithImage:self.rightBarButtonImage];
        _rightBarButtonImageView.frame = CGRectMake(kWindowW - btn_width - 10, btn_orgheight, btn_width, btn_height);
    }
    return _rightBarButtonImageView;
}

- (UIImage *)rightBarButtonImage {
    if(_rightBarButtonImage == nil) {
        _rightBarButtonImage = [UIImage imageNamed:@"tab_cx.png"];
    }
    return _rightBarButtonImage;
}

- (UIImage *)leftBarButtonImage {
    if(_leftBarButtonImage == nil) {
        _leftBarButtonImage = [UIImage imageNamed:@"back.png"];
    }
    return _leftBarButtonImage;
}

- (BaseViewModel *)viewModel {
    if(_viewModel == nil) {
        _viewModel = [[BaseViewModel alloc] init];
    }
    return _viewModel;
}

- (NSString *)userid {
    if(_userid == nil) {
        _userid = [self.viewModel getAccountDetailFromLocal].userid;
    }
    return _userid;
}

@end

