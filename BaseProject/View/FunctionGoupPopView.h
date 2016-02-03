//
//  FunctionGoupPopView.h
//  市场监管
//
//  Created by 网新中研 on 16/1/11.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "FunctionModel.h"
#import "InstalledFunctionView.h"

@interface FunctionGoupPopView : BaseView

-(id)initWithFunction:(FunctionModel *)functionModel subFunctions:(NSArray *)subFunctions clickHandler:(ClickBlock)clickHandler;

@end
