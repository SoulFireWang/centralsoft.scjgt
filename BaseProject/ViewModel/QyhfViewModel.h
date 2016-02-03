//
//  QyhfViewModel.h
//  市场监管通
//
//  Created by 网新中研 on 16/1/19.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseViewModel.h"

@interface QyhfViewModel : BaseViewModel

-(NSArray *)doQueryQy:(NSDictionary *)paramsDic completeHandler:(void(^)(id responseObj, NSError *error))complete;

@end
