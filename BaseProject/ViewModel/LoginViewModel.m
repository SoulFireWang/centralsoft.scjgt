//
//  LoginViewModel.m
//  市场监管
//
//  Created by 网新中研 on 15/12/30.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

-(AccountModel *)getAccountFromLocal{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    AccountModel *accountModel   = [AccountModel new];
    accountModel.username        = [userDefaults objectForKey:@"username"];
    accountModel.password        = [userDefaults objectForKey:@"password"];
    return accountModel;
}

-(void)saveAccount:(AccountModel *)account{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:account.username forKey:@"username"];
    [userDefaults setObject:account.password forKey:@"password"];
}




-(void)login:(AccountModel *)account completionHandler:(void(^)(id responseObj, NSError *error))complete{

    NSDictionary *params         = account.mj_keyValues;

    //用户名Base64加密
    [params setValue:[EncryptBase64 base64StringFromText:[EncryptBase64 base64StringFromText:account.username]] forKey:@"username"];

    [HttpHelper sendData:@"checkUser" parameters:params completionHandler:complete];
}

@end
