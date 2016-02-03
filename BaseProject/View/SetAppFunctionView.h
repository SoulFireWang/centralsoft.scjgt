//
//  SetFunctionItem.h
//  市场监管
//
//  Created by 网新中研 on 16/1/7.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseView.h"
#import "FunctionModel.h"

typedef BOOL(^ClickBlock)(FunctionModel *functionModel);

@interface SetAppFunctionView : BaseView

@property (nonatomic, strong) FunctionModel *functionModel;

-(id)initWithFunction:(FunctionModel *)functionModel installClickHandler:(ClickBlock)installClickHandler uninstallClickHandler:(ClickBlock)uninstallClickHandler;

@end
