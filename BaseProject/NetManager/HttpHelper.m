//
//  HttpHelper.m
//  市场监管
//
//  Created by 网新中研 on 15/12/31.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import "HttpHelper.h"
#import "BaseNetManager.h"

@implementation HttpHelper

+(void) sendData:(NSString *)action parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    
    //配置请求参数并发送
    NSString *path = [NSString stringWithFormat:@"http://%@:%@/%@/scjgt.do?method=%@",SERVER_ID, SERVER_PORT, SERVER_SUFFIX, action];
    NSLog(@"%@", path);
    [BaseNetManager POST:path parameters:params completionHandler:complete];
}

+(void) sendDataUrl:(NSString *)action parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    
    //配置请求参数并发送
    NSString *path = GET_REQUEST(action);
    
    [BaseNetManager POST:path parameters:params completionHandler:complete];
}


@end
