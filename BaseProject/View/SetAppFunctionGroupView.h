//
//  SetFunctionGroupView.h
//  市场监管
//
//  Created by 网新中研 on 16/1/7.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseView.h"
#import "SetAppFunctionView.h"

@interface SetAppFunctionGroupView : BaseView

@property (nonatomic, strong) NSArray *functions;

-(id)initWithFunctions:(NSArray *)functions installClickHandler:(ClickBlock)installClickHandler uninstallClickHandler:(ClickBlock)uninstallClickHandler;;
@end
