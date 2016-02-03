//
//  WebViewController.m
//  市场监管
//
//  Created by 网新中研 on 16/1/5.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "WebViewController.h"
#import "WebViewModel.h"
#import "QyhfViewController.h"
#import "SingatureViewController.h"
#import "SCRecorderViewController.h"

#define TITLE_LABEL_HEIGHT          60        //标题高度
#define TITLE_LINE_HEIGHT           1         //线条高度
#define JOB_TITLE_HEIGHT            20        //标题文本纵向距离
#define TITLE_LABEL_TEXT_COLOR      @"#333333"//导航栏标题颜色
#define TITLE_LABEL_BACKGROUD_COLOR @"#f9f9f9"//导航栏背景色
#define TITLE_LINE_COLOR            @"#b4b4b4"//线条颜色

//返回类型
#define RESULT_TYPE_RWGL 1//任务关联


@interface WebViewController ()<UIWebViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIWebView    *webView;
@property (nonatomic, assign) BOOL         isHideBackButton;
@property (nonatomic, strong) NSString     *currentRequest;
@property (nonatomic, retain) NSString     *alertType;
@property (nonatomic, strong) NSString     *seq;//请求参数
@property (nonatomic, strong) WebViewModel *webViewModel;

@end

@implementation WebViewController

-(instancetype)init{
    if (self = [super init]) {
        self.isBackButtonVisible     = YES;
        self.isNavigationBarVisible  = YES;
        self.isRightBarButtonVisible = NO;
    }
    return self;
}

-(instancetype)initWIthRequest:(NSString *)requestUrl rightBarButtonImage:(UIImage *)image title:(NSString *)title rightBarButtonClickHandler:(void(^)(UIWebView *webView))clickHandler{
    if (self = [self init]) {
        self.isRightBarButtonVisible = YES;
        self.fistPageUrl             = requestUrl;
        self.label.text              = title;
        self.rightBarButtonImage     = image;
        self.rightClickHandler       = clickHandler;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)layoutView{
    [super layoutView];
    
    WS(weakSelf);
    
    //页面布局
    [self.view addSubview:self.webView];
    if (self.isNavigationBarVisible) {
        [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.titleLine.mas_bottom);
            make.left.mas_equalTo(weakSelf.view.mas_left);
            make.right.mas_equalTo(weakSelf.view.mas_right);
            make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        }];
    }else{
        [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view.mas_top);
            make.left.mas_equalTo(weakSelf.view.mas_left);
            make.right.mas_equalTo(weakSelf.view.mas_right);
            make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)onRightBarButtonClick{
    self.rightClickHandler(self.webView);
}

#pragma mark --- ResultDelegate

-(void)onResult:(NSDictionary *)responseParams requestCoe:(NSInteger)requestCode responseCode:(NSInteger)responseCode{
    
    if (requestCode == 200) {

        if (responseCode == RESULT_OK) {
            NSString *code = [responseParams objectForKey:@"code"];
            NSString *rwxh = [responseParams objectForKey:@"rwxh"];
            if (code!=nil) {
                
            }else if(rwxh!=nil){
                NSString *rwxh = [responseParams objectForKey:@"rwxh"];
                NSLog(@"%@", [NSString stringWithFormat:@"_doreplay8(%@)", rwxh]);
                [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"_doreplay8('%@')", rwxh]];
            }
        }
    }else if(requestCode == 104){
        if (responseCode == RESULT_OK) {
            NSString *imgUrl  = [responseParams objectForKey:@"imageUrl"];
            NSString *imgName = [responseParams objectForKey:@"imageName"];
            NSString *group   = [responseParams objectForKey:@"group"];
            NSLog(@"%@, %@, %@", imgUrl, imgName, group);
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"_doHWr('%@','%@','%@')", imgUrl, imgName, group]];
        }
    }else if(requestCode == 10){
        if (responseCode == RESULT_OK) {
            NSString *imgUrl  = [responseParams objectForKey:@"imageUrl"];
            NSString *imgName = [responseParams objectForKey:@"imageName"];
            NSString *group   = [responseParams objectForKey:@"group"];
            NSLog(@"%@, %@, %@", imgUrl, imgName, group);
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"_doHWr('%@','%@','%@')", imgUrl, imgName, group]];
        }
    }else{
        [super onResult:responseParams requestCoe:requestCode responseCode:responseCode];
    }
    
}

#pragma mark --- webView Delegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD *hud   = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode             = MBProgressHUDModeIndeterminate;
    hud.detailsLabelText = @"正在加载数据，请稍候...";
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    if (self.isRefreshButtonVisible) {
        
        //结束尾部进度条
        if (self.webView.scrollView.mj_footer) {
            [self.webView.scrollView.mj_footer endRefreshing];
        }else{
            
            //添加尾部进度条
            __unsafe_unretained UIScrollView *scrollView = self.webView.scrollView;
            
            // 添加下拉刷新控件
            scrollView.mj_footer= [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                
                //加载下一页
                [self getNextPage];
            }];
        }
    }
}

-(void)getNextPage{
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD showError:@"加载失败，请重试"];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL goOrStop = YES;
    NSString *urlString = [[request URL] absoluteString];
    urlString           = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    urlString           = [urlString stringByReplacingOccurrencesOfString:@"/opennewpage#tab_1" withString:@"#tab_1"];
    urlString           = [urlString stringByReplacingOccurrencesOfString:@"[object HTMLInputElement]" withString:@""];

    NSLog(@"%@", urlString);
    
    //请求为空，不进行判断
    if ([urlString isEqualToString:@""]
        || urlString == nil) {
        return NO;
    }
    
    //特殊请求拦截处理
    if ([self urlInterceptor:urlString]) {
        return NO;
    }

    //判断是否需要打开新页面
    if ([urlString containsString:@"/opennewpage"]) {
        [self openWebViewControllerWithRequestString:[urlString stringByReplacingOccurrencesOfString:@"/opennewpage" withString:@""]
                               title:self.label.text
                               isNavgationBarVisible:YES];
        return NO;
    }
    
    if (goOrStop) {
        self.currentRequest = urlString;
    }
    
    return goOrStop;
}

-(BOOL)isFistPageUrl:(NSString *)urlString{
    if ([urlString isEqualToString:self.fistPageUrl]
        ||[urlString isEqualToString:[NSString stringWithFormat:@"%@#tab_1", self.fistPageUrl]]) {
        return YES;
    }
    return NO;
}

/**
 *  请求拦截处理
 *
 *  @param urlString 请求地址
 *
 *  @return 是否被拦截
 */
-(BOOL)urlInterceptor:(NSString *)urlString{
    
    NSString *urlRequest = [urlString stringByReplacingOccurrencesOfString:@"/opennewpage" withString:@""];
   
    //是否被拦截
    BOOL isFiltered = NO;
    
    if ([self isFistPageUrl:urlRequest]) {//如果是首页，则不进行拦截
        isFiltered = NO;
    }else if ([urlRequest containsString:@"scjgtZt.do?method=appGy"]) {//关于
        [self openWebViewControllerWithRequestString:urlRequest
                                               title:@"关于"
                               isNavgationBarVisible:YES];
        isFiltered = YES;
    }else if ([urlRequest containsString:@"scjgt.do?method=setting_12315"]){//12315账号设置
         [self openWebViewControllerWithRequestString:urlRequest
                                                title:@"12315账号设置"
                                isNavgationBarVisible:YES];
        isFiltered = YES;
    }else if ([urlRequest containsString:@"scjgt.do?method=rcjcQy_gltask"]){//日常检查 关联任务

        [self openWebViewControllerWithRequestString:urlRequest
                               title:@"日常检查"
                               isNavgationBarVisible:YES
                               rightBarButtonImage:[UIImage imageNamed:@"yes"]
                               rightBarButtonClick:^(UIWebView *webView) {
            
            NSString *js = [NSString stringWithFormat:@"doQuery();"];
            [webView stringByEvaluatingJavaScriptFromString:js];
            
                               } ];
        isFiltered = YES;
    }else{//objc命令的处理
        NSArray *urlComps = [urlRequest componentsSeparatedByString:@":////"];
        if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"objc"])
        {
            NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:COMMAND_SEPERATOR];
            NSString *funcStr               = [arrFucnameAndParameter objectAtIndex:0];
            NSString* paramString           = [arrFucnameAndParameter objectAtIndex:1];
            [self dispatchAction:funcStr params:paramString];
            isFiltered = YES;
        }
    }
    return isFiltered;
}


#define ALERT_TYPE_QUIT_LOGIN @"0"
#define ALERT_TYPE_CONFIRM2 @"1"
#define ALERT_TYPE_CONFIRM1 @"2"

/**
 *  命令分发
 *
 *  @param funcStr                命令名称
 *  @param param1                 第一个参数
 *  @param arrFucnameAndParameter
 */
-(void)dispatchAction:(NSString *)funcStr params:(NSString *)params{
    
    //这里做过度处理
    NSArray *paramsArray                   = [params componentsSeparatedByString:@"/"];
    NSString *param1                       = [paramsArray objectAtIndex:0];
    NSMutableArray *arrFucnameAndParameter = [NSMutableArray arrayWithObject:funcStr];
    [arrFucnameAndParameter addObjectsFromArray:paramsArray];
    
    //对提示框进行操作，使用系统提示框
    if ([funcStr isEqualToString:@"showMessageQuit"]) {//退出当前用户
        
        self.alertType = ALERT_TYPE_QUIT_LOGIN;
        [self showCheckMessage:param1];

    }else if ([funcStr isEqualToString:@"tsConfirm1"]) {//

        self.alertType = ALERT_TYPE_CONFIRM1;
        [self showCheckMessage:param1];

    }else if ([funcStr isEqualToString:@"tsConfirm12"]) {//

        self.alertType = ALERT_TYPE_CONFIRM2;
        [self showCheckMessage:param1];
        
    }else if ([funcStr isEqualToString:@"_doShip"]) {//打开摄像功能
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [storyBoard instantiateInitialViewController];
//        vc.resultDelegate = self;
//        vc.gxdw = self.gxdw;
//        vc.czmk = self.czmk;
//        vc.userid = self.userid;
        [self presentViewController:vc animated:YES completion:nil];
        
    }else if ([funcStr isEqualToString:@"loadWeb"]) {//登录网页版
        
        [self loadWeb];
        
    }else if ([funcStr isEqualToString:@"toQyhfActivity"]) {//企业回访处理（待回访市场主体）
        
        [self toQyhfActivity];
        
    }else if ([funcStr isEqualToString:@"tsAlert"]) {
        
        [SFToastView showWithSuperView:self.view title:param1];
        
    }else if ([funcStr isEqualToString:@"callPhone"]) {
        NSLog(@"%@", params);
        NSURL *telURL = [NSURL URLWithString:params];
        [[UIApplication sharedApplication] openURL:telURL];
        
    }else if ([funcStr isEqualToString:@"txmxc"]) {
        
        [self openCaptureForReuslt];
        
    }else if ([funcStr isEqualToString:@"sfwifi"]) {//判断wifi
        
        if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self.webView stringByEvaluatingJavaScriptFromString:@"_checkWifi('wifi')"];
        }
 
    }else if ([funcStr isEqualToString:@"winFinish3"]) {//日常检查---关联任务点击确认处理
        
        NSString* param2               = [arrFucnameAndParameter objectAtIndex:2];
        NSMutableDictionary *resultDic = [NSMutableDictionary new];
        [resultDic setObject:param1 forKey:@"rwxh"];
        [resultDic setObject:param2 forKey:@"flag"];
        [self.resultDelegate onResult:resultDic requestCoe:200 responseCode:RESULT_OK];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if ([funcStr isEqualToString:@"HandwrittenSignature"]) {//手写签名
        
        SingatureViewController *signatureViewController = [SingatureViewController new];
        signatureViewController.gxdw   = [arrFucnameAndParameter objectAtIndex:1];
        signatureViewController.userid = [arrFucnameAndParameter objectAtIndex:2];
        signatureViewController.czmk   = [arrFucnameAndParameter objectAtIndex:3];
        
        [self openViewControllerForResult:signatureViewController];
        
    }else if ([funcStr isEqualToString:@"getBigImage"]) {//显示大图
        
        NSString *urlString = [self appendStringArray:paramsArray seperatorString:@"/"];
        NSLog(@"%@",urlString );
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kWindowW / 7 *5, kWindowH / 8 * 5)];

        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW / 7 * 5 + 20, kWindowH / 8 * 5 + 20)];

        backView.layer.cornerRadius = 10;
        backView.backgroundColor = [UIColor whiteColor];
        
        [backView addSubview:imageView];
        
        [self popShow:backView];
        
    }else if ([funcStr isEqualToString:@"__ZzCamera"]) {//获取照片
        
        //设置传入参数
        self.gxdw = [arrFucnameAndParameter objectAtIndex:1];
        self.userid = [arrFucnameAndParameter objectAtIndex:2];
        self.czmk = [arrFucnameAndParameter objectAtIndex:3];
        
        WS(weakSelf);
        
        [self getSystemPicture:^(UIImage *pickedPicture, NSString *filePath) {
            
            //获取文件名称
            NSString *fileName = [self getImageName:filePath];
            
            //上传图片
            [self.webViewModel uploadImageWithImageName:fileName
                                                   data:[self rarImage:pickedPicture]serverPath:SERVER_PATH
                                                   gxdw:weakSelf.gxdw
                                                 userid:weakSelf.userid
                                                   czmk:weakSelf.czmk];
            
            //刷新页面
            NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@", SERVER_PATH, self.gxdw, self.userid, self.czmk, [self getCurrentDateTime:@"yyyyMM"], fileName];
            NSString *jsString = [NSString stringWithFormat:@"_doPictureGroup('%@','%@')", urlString, [NSString stringWithFormat:@"%@.png", fileName]];
            [weakSelf.webView stringByEvaluatingJavaScriptFromString:jsString];
        }];
        
    }
}


//-(void)dispatchAction2:(NSString *)funcStr params:(NSString *)params{
//    
//    [self performSelector:NSSelectorFromString(funcStr)];
//}


#pragma mark --- Show Message
//该方法用于JS中调用（显示提示信息）
-(BOOL)showMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:msg
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    [alert show];
    return NO;
}

-(BOOL)showCheckMessage:(NSString *)msg
{
    if([self.alertType isEqualToString:@"2"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"确定", nil];
        [alert show];
    }else if([self.alertType isEqualToString:ALERT_TYPE_QUIT_LOGIN]
             ||[self.alertType isEqualToString:ALERT_TYPE_CONFIRM2]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:@"取消", nil];
        [alert show];
    }else if([self.alertType isEqualToString:@"30"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle: @"确定"
                                             otherButtonTitles:@"取消", nil];
        [alert show];
    }
    return NO;
}

#pragma mark -- UIAlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([self.alertType isEqualToString:ALERT_TYPE_QUIT_LOGIN]) {//退出当前用户
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if ([self.alertType isEqualToString:ALERT_TYPE_CONFIRM2]) {//取消关联
        if (buttonIndex==0) {
            [self.webView stringByEvaluatingJavaScriptFromString:@"_doConfirm();"];
        }
    }else if ([self.alertType isEqualToString:ALERT_TYPE_CONFIRM1]) {
        if (buttonIndex==0) {
            [self.webView stringByEvaluatingJavaScriptFromString:@"_doConfirm1();"];
        }
    }
}


#pragma mark --- 本地业务集合

-(BOOL)loadWeb{
    [self openCapture:^(NSString *resultString) {
        NSLog(@"%@", resultString);
        
        [HttpHelper sendData:@"scjgtZt.do?method=ewmLogin_authCaUser" parameters:@{} completionHandler:^(id responseObj, NSError *error) {
            NSLog(@"%@", responseObj);
        }];
    }];
    
    return NO;
}


-(void)toQyhfActivity{
    QyhfViewController *qyhfViewController = [QyhfViewController new];
    [self.navigationController pushViewController:qyhfViewController animated:YES];
}

#pragma mark --- 懒加载

- (UIWebView *)webView {
	if(_webView == nil) {
        _webView=[[UIWebView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _webView.delegate        = self;
        _webView.backgroundColor = [UIColor whiteColor];
        NSURL *url               = [[NSURL alloc]initWithString:self.fistPageUrl];

        [_webView setScalesPageToFit:YES];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];

        //禁止webview背景内容显示
        UIScrollView *scroller   = [_webView.subviews objectAtIndex:0];
        if (scroller){
            scroller.bounces = NO;
            scroller.alwaysBounceHorizontal = NO;
        }
        
        //禁止滚动条显示
        [_webView.scrollView setShowsHorizontalScrollIndicator:NO];
	}
	return _webView;
}

- (NSString *)currentRequest {
	if(_currentRequest == nil) {
		_currentRequest = [[NSString alloc] init];
	}
	return _currentRequest;
}

- (WebViewModel *)webViewModel {
	if(_webViewModel == nil) {
		_webViewModel = [[WebViewModel alloc] init];
	}
	return _webViewModel;
}

@end
