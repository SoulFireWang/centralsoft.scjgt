//
//  SetAppViewModel.m
//  市场监管
//
//  Created by 网新中研 on 16/1/7.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "SetAppViewModel.h"
#import "FunctionModel.h"

@implementation SetAppViewModel

/**
 *  获取查询功能集合
 *
 *  @param contextDic json数据集合
 *
 *  @return 查询功能集合
 */
-(NSArray *)getCXFunctions:(AccountDetailModel *)accountDetailModel{
    
    NSMutableArray *functions             = [NSMutableArray new];
    NSArray *functionArray                = accountDetailModel.function;
    NSString *functionsString             = accountDetailModel.hasfunction;
    NSArray<NSString *> *hasFunctionArray = [functionsString componentsSeparatedByString:@","];
    NSMutableDictionary *hasFunctionsDic  = [NSMutableDictionary new];
    for (NSString *functionId in hasFunctionArray) {
        [hasFunctionsDic setValue:functionId forKey:functionId];
    }
    
    for (NSDictionary *dic in functionArray) {
        
        FunctionModel *model = [FunctionModel mj_objectWithKeyValues:dic];
        if(model.functionid_cx!=nil && ![model.functionid_cx isEqualToString:@""]){
            
            if ([hasFunctionsDic objectForKey:model.functionid] !=nil) {
                model.isInstalled = YES;
            }else{
                model.isInstalled = NO;
            }
            
            //查询功能项
            [functions addObject:model];
        }
    }
    NSLog(@"%@", functions);
    return functions;
}

/**
 *  获取执法功能集合
 *
 *  @param contextDic json数据集合
 *
 *  @return 执法功能集合
 */
-(NSArray *)getZFFunctions:(AccountDetailModel *)accountDetailModel{
    NSMutableArray *functions             = [NSMutableArray new];
    NSArray *functionArray                = accountDetailModel.function;
    NSString *functionsString             = accountDetailModel.hasfunction;
    NSArray<NSString *> *hasFunctionArray = [functionsString componentsSeparatedByString:@","];
    NSMutableDictionary *hasFunctionsDic  = [NSMutableDictionary new];
    for (NSString *functionId in hasFunctionArray) {
        [hasFunctionsDic setValue:functionId forKey:functionId];
    }
    
    for (NSDictionary *dic in functionArray) {
        
        FunctionModel *model = [FunctionModel mj_objectWithKeyValues:dic];
        if(model.functionid_zf!=nil && ![model.functionid_zf isEqualToString:@""]){
            
            if ([hasFunctionsDic objectForKey:model.functionid] !=nil) {
                model.isInstalled = YES;
            }else{
                model.isInstalled = NO;
            }
            
            //查询功能项
            [functions addObject:model];
        }
    }
    NSLog(@"%@", functions);
    return functions;
}

/**
 *  获取辅助功能集合
 *
 *  @param contextDic json数据集合
 *
 *  @return 辅助功能集合
 */
-(NSArray *)getFZFunctions:(AccountDetailModel *)accountDetailModel{
    NSMutableArray *functions             = [NSMutableArray new];
    NSArray *functionArray                = accountDetailModel.function;
    NSString *functionsString             = accountDetailModel.hasfunction;
    NSArray<NSString *> *hasFunctionArray = [functionsString componentsSeparatedByString:@","];
    NSMutableDictionary *hasFunctionsDic  = [NSMutableDictionary new];
    for (NSString *functionId in hasFunctionArray) {
        [hasFunctionsDic setValue:functionId forKey:functionId];
    }
    
    for (NSDictionary *dic in functionArray) {
        
        FunctionModel *model = [FunctionModel mj_objectWithKeyValues:dic];
        if(model.functionid_fz!=nil && ![model.functionid_fz isEqualToString:@""]){
            
            if ([hasFunctionsDic objectForKey:model.functionid] !=nil) {
                model.isInstalled = YES;
            }else{
                model.isInstalled = NO;
            }
            
            //查询功能项
            [functions addObject:model];
        }
    }
    NSLog(@"%@", functions);
    return functions;
}

//保存功能项修改
-(void)saveFunction:(AccountDetailModel *)accountDetailModel completionHandler:(void(^)(id responseObj, NSError *error))completeHandler{
    
    [HttpHelper sendData:@"saveFuncitons" parameters:@{@"fids":accountDetailModel.hasfunction, @"userid":accountDetailModel.userid} completionHandler:completeHandler];
}

@end
