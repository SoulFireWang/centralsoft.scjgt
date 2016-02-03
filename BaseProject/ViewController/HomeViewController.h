//
//  HomeViewController.h
//  市场监管
//
//  Created by 网新中研 on 16/1/6.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountDetailModel.h"

@interface HomeViewController : BaseViewController
@property (nonatomic, strong) NSDictionary       *loginInfoDic;
@property (nonatomic, strong) AccountDetailModel *accountDetailModel;

@end
