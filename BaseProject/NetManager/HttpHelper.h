//
//  HttpHelper.h
//  市场监管
//
//  Created by 网新中研 on 15/12/31.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpHelper : NSObject

/**
 *  http请求：只需传值method
 *  请求格式 "http://" + this.serverip + ":" + this.serverport + "/" +this.serversuffix + "/scjgt.do?method=" + action
 *
 *  @param action   方法
 *  @param params   请求参数
 *  @param complete 请求返回处理
 */
+(void) sendData:(NSString *)action parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete;


/**
 *  http请求：只需传值method
 *  请求格式 "http://" + this.serverip + ":" + this.serverport + "/" +this.serversuffix + "/scjgt.do?method=" + action
 *
 *  @param action   方法
 *  @param params   请求参数
 *  @param complete 请求返回处理
 */
+(void) sendDataUrl:(NSString *)action parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete;

@end
