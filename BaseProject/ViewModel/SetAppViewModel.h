//
//  SetAppViewModel.h
//  市场监管
//
//  Created by 网新中研 on 16/1/7.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseViewModel.h"
#import "AccountDetailModel.h"
#import "FunctionModel.h"

@interface SetAppViewModel : BaseViewModel

/**
 *  获取查询功能集合
 *
 *  @param contextDic json数据集合
 *
 *  @return 查询功能集合
 */
-(NSArray *)getCXFunctions:(AccountDetailModel *)accountDetailModel;

/**
 *  获取执法功能集合
 *
 *  @param contextDic json数据集合
 *
 *  @return 执法功能集合
 */
-(NSArray *)getZFFunctions:(AccountDetailModel *)accountDetailModel;

/**
 *  获取辅助功能集合
 *
 *  @param contextDic json数据集合
 *
 *  @return 辅助功能集合
 */
-(NSArray *)getFZFunctions:(AccountDetailModel *)accountDetailModel;

//保存功能项修改
-(void)saveFunction:(AccountDetailModel *)accountDetailModel completionHandler:(void(^)(id responseObj, NSError *error))completeHandler;

-(NSArray *)getSubFunctions:(FunctionModel *)functionModel;

@end
