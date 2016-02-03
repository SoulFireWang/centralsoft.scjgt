//
//  BaseViewController.h
//  市场监管
//
//  Created by 网新中研 on 15/12/29.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import <UIKit/UIKit.h>


#define RESULT_OK 200
#define REQUEST_CODE_SCAN 100 //扫码

@protocol ResultDelegate <NSObject>

-(void)onResult:(NSDictionary *)responseParams requestCoe:(NSInteger)requestCode responseCode:(NSInteger)responseCode;

@end

@interface BaseViewController : UIViewController<ResultDelegate, UIActionSheetDelegate>


@property (nonatomic, strong) NSString *gxdw;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *czmk;

/**
 *  界面反向传值处理对象
 */
@property (nonatomic, weak) id<ResultDelegate> resultDelegate;

/**
 *  数据处理对象
 */
@property (nonatomic, strong) BaseViewModel *viewModel;

/**
 *  页面加载布局处理
 */
-(void)layoutView;

/**
 *  上下文信息
 */
@property (nonatomic, strong)NSMutableDictionary *contextDic;

/**
 *  扫码
 */
-(void)openCapture:(void (^)(NSString *resultString))completeHandler;

/**
 *  扫码
 *  此处带返回值处理
 */
-(void)openCaptureForReuslt;

/**
 *  push新界面，并带返回值回传
 *
 *  @param baseController 视图控制器
 */
-(void)openViewControllerForResult:(BaseViewController *)baseController;

/**
 *  打开浏览器页面
 *
 *  @param requestStr             请求地址
 *  @param title                  功能描述
 *  @param isNavigationBarVisible 导航条是否可见
 */
-(id)openWebViewControllerWithRequestString:(NSString *)requestStr
                                      title:(NSString *)title
                      isNavgationBarVisible:(BOOL)isNavigationBarVisible;

/**
 *  打开浏览器页面
 *
 *  @param requestStr             请求地址
 *  @param title                  功能描述
 *  @param isNavigationBarVisible 导航条是否可见
 *  @param image                  右边按钮图片
 *  @param clickHandler           右边按钮当点击处理
 *  @param resultHandler          界面返回处理
 *
 *  @return 返回浏览器对象
 */
-(id)openWebViewControllerWithRequestString:(NSString *)requestStr
                                      title:(NSString *)title
                      isNavgationBarVisible:(BOOL)isNavigationBarVisible
                        rightBarButtonImage:(UIImage *)image
                        rightBarButtonClick:(void(^)(UIWebView * webView))clickHandler;

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
-(id)openWebViewControllerWithRequestString:(NSString *)requestStr
                                      title:(NSString *)title
                              isRefreshable:isRefreshable
                      isNavgationBarVisible:(BOOL)isNavigationBarVisible
                        rightBarButtonImage:(UIImage *)image
                        rightBarButtonClick:(void(^)(UIWebView * webView))clickHandler;

/**
 *  打开数字签名页面
 *
 *  @param requestStr             请求地址
 *  @param title                  功能描述
 *  @param isNavigationBarVisible 导航条是否可见
 *  @param image                  右边按钮图片
 *  @param clickHandler           右边按钮当点击处理
 *
 *  @return 返回数字签名界面对象
 */
-(id)openSignatureViewControllerWithRequestString:(NSString *)requestStr
                                            title:(NSString *)title
                            isNavgationBarVisible:(BOOL)isNavigationBarVisible
                              rightBarButtonImage:(UIImage *)image
                              rightBarButtonClick:(void(^)(UIWebView * webView))clickHandler;

-(id)openSignatureViewCOntroller;

/**
 *  获取系统图片
 */
-(void)getSystemPicture:(void(^)(UIImage *pickedPicture, NSString *filePath))onGetPictureHandler;

#pragma mark --- 自定义导航条

typedef void(^RightBarButtonClick)(UIWebView *);

@property (nonatomic, copy) RightBarButtonClick rightClickHandler;

/**
 *  导航条是否可见
 */
@property (nonatomic, assign)BOOL isNavigationBarVisible;

/**
 *  返回按钮是否可见
 */
@property (nonatomic, assign)BOOL isBackButtonVisible;

/**
 *  搜索按钮是否可见
 */
@property (nonatomic, assign)BOOL isRightBarButtonVisible;

/**
 *  自定义导航条
 */
@property (nonatomic,retain) UILabel *label;//标题
@property (nonatomic,retain) UIView *titleLine;//导航栏分割线（用于布局）

/**
 *  右侧按钮图片
 */
@property (nonatomic,retain) UIImage *rightBarButtonImage;
/**
 *  左侧按钮图片
 */
@property (nonatomic,retain) UIImage *leftBarButtonImage;

/**
 *  导航条按钮右击
 */
-(void)onRightBarButtonClick;

/**
 *  导航条返回按钮点击
 */
-(void)onGoBackClick;

@end
