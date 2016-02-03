//
//  HomeViewModel.h
//  市场监管
//
//  Created by 网新中研 on 16/1/6.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseViewModel.h"
#import "AccountDetailModel.h"
#import "FunctionModel.h"
#import "BaseViewController.h"

@interface HomeViewModel : BaseViewModel

/**
 *  获取查询功能项
 *
 *  @param contextDic json数据集合
 *
 *  @return 查询功能项集合
 */
-(NSArray *)getCXFunctionArrays:(NSDictionary *)contextDic;

/**
 *  获取执法功能项
 *
 *  @param contextDic json数据集合
 *
 *  @return 执法功能项集合
 */
-(NSArray *)getZFFunctionArrays:(NSDictionary *)contextDic;

/**
 *  获取辅助功能项
 *
 *  @param contextDic json数据集合
 *
 *  @return 辅助功能项集合
 */
-(NSArray *)getFZFunctionArrays:(NSDictionary *)contextDic;



/**
 *  获取查询功能项
 *
 *  @param 账号详情
 *
 *  @return 查询功能项集合
 */
-(NSArray *)getCXFunctions:(AccountDetailModel *)accountDetailDic;

/**
 *  获取执法功能项
 *
 *  @param 账号详情
 *
 *  @return 执法功能项集合
 */
-(NSArray *)getZFFunctions:(AccountDetailModel *)accountDetailDic;

/**
 *  获取辅助功能项
 *
 *  @param 账号详情
 *
 *  @return 辅助功能项集合
 */
-(NSArray *)getFZFunctions:(AccountDetailModel *)accountDetailDic;

/**
 *  获取用户详情
 *
 *  @param contextDic contextDic json数据集合
 *
 *  @return 用户详情
 */
-(AccountDetailModel *)getAccountDetail:(NSDictionary *)contextDic;

/**
 *  获取功能集合项的子项
 *
 *  @param 功能集合对象
 *
 *  @return 功能集合子项
 */
-(NSArray *)getSubFunctions:(FunctionModel *)functionModel;

/**
 *  获取功能项对应的界面
 *
 *  @param 功能项对象
 *
 *  @return 对象控制器
 */
-(BaseViewController *)getViewController:(FunctionModel *)functionModel;

@end
