//
//  FunctionModel.h
//  市场监管
//
//  Created by 网新中研 on 16/1/4.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseModel.h"

@interface FunctionModel : BaseModel

@property (nonatomic, strong) NSString *functionaction;
@property (nonatomic, strong) NSString *functionid;
@property (nonatomic, strong) NSString *functionlb;
@property (nonatomic, strong) NSString *functionname;

@property (nonatomic, strong) NSString *functionaction_zf;
@property (nonatomic, strong) NSString *functionid_zf;
@property (nonatomic, strong) NSString *functionlb_zf;
@property (nonatomic, strong) NSString *functionname_zf;

@property (nonatomic, strong) NSString *functionaction_cx;
@property (nonatomic, strong) NSString *functionid_cx;
@property (nonatomic, strong) NSString *functionlb_cx;
@property (nonatomic, strong) NSString *functionname_cx;

@property (nonatomic, strong) NSString *functionaction_fz;
@property (nonatomic, strong) NSString *functionid_fz;
@property (nonatomic, strong) NSString *functionlb_fz;
@property (nonatomic, strong) NSString *functionname_fz;

/**
 *  是否已经安装
 */
@property (nonatomic, assign) BOOL isInstalled;

@end
