//
//  SetFunctionGroupView.m
//  市场监管
//
//  Created by 网新中研 on 16/1/7.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "SetAppFunctionGroupView.h"
#import "SetAppFunctionView.h"

@interface SetAppFunctionGroupView()
@property (nonatomic, strong) ClickBlock installClickHandler;
@property (nonatomic, strong) ClickBlock uninstallClickHandler;
@end

@implementation SetAppFunctionGroupView

-(id)initWithFunctions:(NSArray *)functions installClickHandler:(ClickBlock)installClickHandler uninstallClickHandler:(ClickBlock)uninstallClickHandler;{
    if (self = [super init]) {
        self.functions = functions;
        self.installClickHandler = installClickHandler;
        self.uninstallClickHandler = uninstallClickHandler;
        [self layoutView];
    }
    return self;
}

#define GAP1 10
#define GAP_ROW 10
#define ITEM_HEIGHT 88
#define ITEM_WIDTH ((kWindowW - 20) / 4)
#define PRIMARY_Y 45

-(void)layoutView{
    
    self.backgroundColor     = [UIColor whiteColor];
    self.layer.cornerRadius  = 5;
    self.layer.shadowColor   = [UIColor grayColor].CGColor;
    self.layer.shadowRadius  = 2;
    self.layer.shadowOffset  = CGSizeMake(1, 2);
    self.layer.shadowOpacity = 0.9;
    
    self.height = GAP1;
    
    //显示项目
    for (int i = 0; i< self.functions.count; i++) {
        CGRect rect = CGRectMake(ITEM_WIDTH * (i%4), GAP1 + ((int)(i/4))*ITEM_HEIGHT + GAP_ROW * ((int)(i/4)), ITEM_WIDTH, ITEM_HEIGHT);
        SetAppFunctionView *functionItem = [[SetAppFunctionView alloc]initWithFunction:[self.functions objectAtIndex:i] installClickHandler:^BOOL(FunctionModel *functionModel) {
            return self.installClickHandler(functionModel);
        } uninstallClickHandler:^BOOL(FunctionModel *functionModel) {
            return self.uninstallClickHandler(functionModel);
        }];

        functionItem.frame = rect;
        [self addSubview:functionItem];
        
        if (i % 4 == 0) {
            self.height = self.height + ITEM_HEIGHT + GAP_ROW;
        }
    }
}


@end
