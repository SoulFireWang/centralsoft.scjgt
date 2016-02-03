//
//  FunctionItem.h
//  市场监管
//
//  Created by 网新中研 on 16/1/6.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseView.h"
#import "FunctionModel.h"

typedef void(^ClickBlock)(FunctionModel *functionModel);

@interface InstalledFunctionView : BaseView
@property (nonatomic, strong) FunctionModel *functionModel;

-(id)initWithFunction:(FunctionModel *)functionModel clickHandler:(ClickBlock)clickHandler;

@end
