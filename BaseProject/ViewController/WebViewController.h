//
//  WebViewController.h
//  市场监管
//
//  Created by 网新中研 on 16/1/5.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : BaseViewController

/**
 *  是否带有刷新按钮
 */
@property (nonatomic, assign) BOOL isRefreshButtonVisible;

/**
 *  首页地址
 */
@property (nonatomic, strong)NSString *fistPageUrl;

-(instancetype)initWIthRequest:(NSString *)requestUrl
           rightBarButtonImage:(UIImage *)image
                         title:(NSString *)title
    rightBarButtonClickHandler:(void(^)(UIWebView *webView))clickHandler;

@end
