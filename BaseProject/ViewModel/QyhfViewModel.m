//
//  QyhfViewModel.m
//  市场监管通
//
//  Created by 网新中研 on 16/1/19.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "QyhfViewModel.h"

@implementation QyhfViewModel

-(NSArray *)doQueryQy:(NSDictionary *)paramsDic completeHandler:(void(^)(id responseObj, NSError *error))complete{
    [HttpHelper sendData:@"getRcxcQyList" parameters:paramsDic completionHandler:^(id responseObj, NSError *error) {
        complete(responseObj, error);
    }];
    return nil;
}
@end
