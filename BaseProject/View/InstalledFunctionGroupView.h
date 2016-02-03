//
//  FunctionGroupView.h
//  市场监管
//
//  Created by 网新中研 on 16/1/6.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseView.h"
#import "InstalledFunctionView.h"


@interface InstalledFunctionGroupView : BaseView

@property (nonatomic, strong) NSArray *functions;
@property (nonatomic, strong) NSString *title;

-(id)initWithTitle:(NSString *)title functions:(NSArray *)functions clickHandler:(ClickBlock)clickHandler;

@end
