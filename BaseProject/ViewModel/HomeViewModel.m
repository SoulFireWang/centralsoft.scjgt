//
//  HomeViewModel.m
//  市场监管
//
//  Created by 网新中研 on 16/1/6.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "HomeViewModel.h"
#import "FunctionModel.h"

@implementation HomeViewModel

-(NSArray *)getCXFunctionArrays:(NSDictionary *)contextDic{
    NSMutableArray *functions = [NSMutableArray new];
    NSArray *functionArray = [contextDic objectForKey:FUNCTION];
    NSString *functionsString = [contextDic objectForKey:HASFUNCTION];
    NSArray<NSString *> *hasFunctionArray = [functionsString componentsSeparatedByString:@","];
    NSMutableDictionary *hasFunctionsDic = [NSMutableDictionary new];
    for (NSString *functionId in hasFunctionArray) {
        [hasFunctionsDic setValue:functionId forKey:functionId];
    }
    
    for (NSDictionary *dic in functionArray) {
        FunctionModel *model = [FunctionModel mj_objectWithKeyValues:dic];
        if(model.functionid_cx!=nil && ![model.functionid_cx isEqualToString:@""]){
            
            if ([hasFunctionsDic objectForKey:model.functionid] !=nil) {
                //查询功能项
                [functions addObject:model];
            }
        }
    }
    NSLog(@"%@", functions);
    return functions;
}

-(NSArray *)getZFFunctionArrays:(NSDictionary *)contextDic{
    NSMutableArray *functions = [NSMutableArray new];
    NSArray *functionArray = [contextDic objectForKey:FUNCTION];
    NSString *functionsString = [contextDic objectForKey:HASFUNCTION];
    NSArray<NSString *> *hasFunctionArray = [functionsString componentsSeparatedByString:@","];
    NSMutableDictionary *hasFunctionsDic = [NSMutableDictionary new];
    for (NSString *functionId in hasFunctionArray) {
        [hasFunctionsDic setValue:functionId forKey:functionId];
    }
    for (NSDictionary *dic in functionArray) {
        FunctionModel *model = [FunctionModel mj_objectWithKeyValues:dic];
        if(model.functionid_zf!=nil && ![model.functionid_zf isEqualToString:@""]){
            if ([hasFunctionsDic objectForKey:model.functionid] !=nil) {
                //执法功能项
                [functions addObject:model];
            }
        }
    }
    NSLog(@"%@", functions);
    return functions;
}

-(NSArray *)getFZFunctionArrays:(NSDictionary *)contextDic{
    NSMutableArray *functions = [NSMutableArray new];
    NSArray *functionArray = [contextDic objectForKey:FUNCTION];
    NSString *functionsString = [contextDic objectForKey:HASFUNCTION];
    NSArray<NSString *> *hasFunctionArray = [functionsString componentsSeparatedByString:@","];
    NSMutableDictionary *hasFunctionsDic = [NSMutableDictionary new];
    for (NSString *functionId in hasFunctionArray) {
        [hasFunctionsDic setValue:functionId forKey:functionId];
    }
    for (NSDictionary *dic in functionArray) {
        FunctionModel *model = [FunctionModel mj_objectWithKeyValues:dic];
        if(model.functionid_fz!=nil && ![model.functionid_fz isEqualToString:@""]){
            if ([hasFunctionsDic objectForKey:model.functionid] !=nil) {
                //辅助功能项
                [functions addObject:model];
            }
        }
    }
    NSLog(@"%@", functions);
    return functions;
}


/**
 *  获取查询功能项
 *
 *  @param 账号详情
 *
 *  @return 查询功能项集合
 */
-(NSArray *)getCXFunctions:(AccountDetailModel *)accountDetailDic{
    NSMutableArray *functions = [NSMutableArray new];
    NSArray *functionArray = accountDetailDic.function;
    NSString *functionsString = accountDetailDic.hasfunction;
    NSArray<NSString *> *hasFunctionArray = [functionsString componentsSeparatedByString:@","];
    NSMutableDictionary *hasFunctionsDic = [NSMutableDictionary new];
    for (NSString *functionId in hasFunctionArray) {
        [hasFunctionsDic setValue:functionId forKey:functionId];
    }
    for (NSDictionary *dic in functionArray) {
        FunctionModel *model = [FunctionModel mj_objectWithKeyValues:dic];
        if(model.functionid_cx!=nil && ![model.functionid_cx isEqualToString:@""]){
            if ([hasFunctionsDic objectForKey:model.functionid] !=nil) {
                //辅助功能项
                [functions addObject:model];
            }
        }
    }
    NSLog(@"%@", functions);
    return functions;
}

/**
 *  获取执法功能项
 *
 *  @param 账号详情
 *
 *  @return 执法功能项集合
 */
-(NSArray *)getZFFunctions:(AccountDetailModel *)accountDetailDic{
    NSMutableArray *functions = [NSMutableArray new];
    NSArray *functionArray = accountDetailDic.function;
    NSString *functionsString = accountDetailDic.hasfunction;
    NSArray<NSString *> *hasFunctionArray = [functionsString componentsSeparatedByString:@","];
    NSMutableDictionary *hasFunctionsDic = [NSMutableDictionary new];
    for (NSString *functionId in hasFunctionArray) {
        [hasFunctionsDic setValue:functionId forKey:functionId];
    }
    for (NSDictionary *dic in functionArray) {
        FunctionModel *model = [FunctionModel mj_objectWithKeyValues:dic];
        if(model.functionid_zf!=nil && ![model.functionid_zf isEqualToString:@""]){
            if ([hasFunctionsDic objectForKey:model.functionid] !=nil) {
                //辅助功能项
                [functions addObject:model];
            }
        }
    }
    NSLog(@"%@", functions);
    return functions;
}

/**
 *  获取辅助功能项
 *
 *  @param 账号详情
 *
 *  @return 辅助功能项集合
 */
-(NSArray *)getFZFunctions:(AccountDetailModel *)accountDetailDic{
    NSMutableArray *functions = [NSMutableArray new];
    NSArray *functionArray = accountDetailDic.function;
    NSString *functionsString = accountDetailDic.hasfunction;
    NSArray<NSString *> *hasFunctionArray = [functionsString componentsSeparatedByString:@","];
    NSMutableDictionary *hasFunctionsDic = [NSMutableDictionary new];
    for (NSString *functionId in hasFunctionArray) {
        [hasFunctionsDic setValue:functionId forKey:functionId];
    }
    for (NSDictionary *dic in functionArray) {
        FunctionModel *model = [FunctionModel mj_objectWithKeyValues:dic];
        if(model.functionid_fz!=nil && ![model.functionid_fz isEqualToString:@""]){
            if ([hasFunctionsDic objectForKey:model.functionid] !=nil) {
                //辅助功能项
                [functions addObject:model];
            }
        }
    }
    NSLog(@"%@", functions);
    return functions;
}


-(AccountDetailModel *)getAccountDetail:(NSDictionary *)contextDic{
    return [AccountDetailModel mj_objectWithKeyValues:contextDic];;
}

-(NSArray *)getSubFunctions:(FunctionModel *)functionModel{
    
    //餐饮监管
    if([functionModel.functionaction isEqualToString:@"CyjgActivity"]){
        
        FunctionModel *functionModel4 = [FunctionModel new];
        functionModel4.functionname   = @"餐饮企业管理";
        functionModel4.functionid     = @"34_4";
        functionModel4.functionaction = @"CyqyglActvity";

        FunctionModel *functionModel3 = [FunctionModel new];
        functionModel3.functionname   = @"餐饮标准";
        functionModel3.functionid     = @"34_3";
        functionModel3.functionaction = @"CyjcActivity";

        FunctionModel *functionModel1 = [FunctionModel new];
        functionModel1.functionname   = @"日常检查";
        functionModel1.functionid     = @"34_1";
        functionModel1.functionaction = @"CybzAcitvity";

        FunctionModel *functionModel2 = [FunctionModel new];
        functionModel2.functionname   = @"许可证查询";
        functionModel2.functionid     = @"34_2";
        functionModel2.functionaction = @"CyxkzcxAcitvity";

        FunctionModel *functionModel5 = [FunctionModel new];
        functionModel5.functionname   = @"法律法规查询";
        functionModel5.functionid     = @"34_5";
        functionModel5.functionaction = @"CyflfgAcitvity";
        
        return @[functionModel1, functionModel2, functionModel3, functionModel4, functionModel5];
    }
    
    //餐饮监管
    if([functionModel.functionaction isEqualToString:@"AjglActivity"]){
        
        FunctionModel *functionModel26 = [FunctionModel new];
        functionModel26.functionname   = @"案源录入";
        functionModel26.functionid     = @"26";
        functionModel26.functionaction = @"scjgt.do?method=aylr_aylrEnter";

        FunctionModel *functionModel27 = [FunctionModel new];
        functionModel27.functionname   = @"案件处罚";
        functionModel27.functionid     = @"27";
        functionModel27.functionaction = @"scjgt.do?method=jycf_jycfEnter";

        FunctionModel *functionModel30 = [FunctionModel new];
        functionModel30.functionname   = @"文书打印";
        functionModel30.functionid     = @"30";
        functionModel30.functionaction = @"CybzAcitvity";

        FunctionModel *functionModel33 = [FunctionModel new];
        functionModel33.functionname   = @"文书查询";
        functionModel33.functionid     = @"33";
        functionModel33.functionaction = @"scjgtZt.do?method=wscxList";

        FunctionModel *functionModel07 = [FunctionModel new];
        functionModel07.functionname   = @"案件查询";
        functionModel07.functionid     = @"07";
        functionModel07.functionaction = @"scjgt.do?method=aj_enterLacx";

        FunctionModel *functionModel34 = [FunctionModel new];
        functionModel34.functionname   = @"办案查询";
        functionModel34.functionid     = @"34";
        functionModel34.functionaction = @"scjgtZt.do?method=aj_bacx";
        
        return @[functionModel26, functionModel27, functionModel30, functionModel33, functionModel07, functionModel34];
    }
    
    //保化监管
    if([functionModel.functionaction isEqualToString:@"BhjgActivity"]){
        
        FunctionModel *functionModel1 = [FunctionModel new];
        functionModel1.functionname   = @"";
        functionModel1.functionid     = @"37_1";
        functionModel1.functionaction = @"BhjcActivity";

        FunctionModel *functionModel2 = [FunctionModel new];
        functionModel2.functionname   = @"";
        functionModel2.functionid     = @"37_2";
        functionModel2.functionaction = @"BhjcjgActivity";
        
        return @[functionModel1, functionModel2];
    }
    
    return nil;
}

-(BaseViewController *)getViewController:(FunctionModel *)functionModel{
    return nil;
}

@end
