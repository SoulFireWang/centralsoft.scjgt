//
//  LoginViewModel.h
//  市场监管
//
//  Created by 网新中研 on 15/12/30.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import "BaseViewModel.h"
#import "AccountModel.h"
#import "AccountDetailModel.h"

@interface LoginViewModel : BaseViewModel



-(AccountModel *)getAccountFromLocal;
-(void)saveAccount:(AccountModel *)account;
-(void)login:(AccountModel *)account completionHandler:(void(^)(id responseObj, NSError *error))complete;

@end
