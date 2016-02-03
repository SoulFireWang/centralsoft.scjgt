//
//  FunctionGroupView.m
//  市场监管
//
//  Created by 网新中研 on 16/1/6.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "InstalledFunctionGroupView.h"
#import <QuartzCore/QuartzCore.h>
#import "DashedLine.h"


@interface InstalledFunctionGroupView()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, copy) ClickBlock clickHandler;
@end

@implementation InstalledFunctionGroupView

-(id)initWithTitle:(NSString *)title functions:(NSArray *)functions clickHandler:(ClickBlock)clickHandler{
    if (self = [super init]) {
        self.functions = functions;
        self.title = title;
        self.clickHandler = clickHandler;
        [self layoutView];
    }
    return self;
}

#define GAP1 10 
#define GAP_ROW 10
#define ITEM_HEIGHT 56
#define ITEM_WIDTH ((kWindowW - 20) / 4)
#define PRIMARY_Y 45

-(void)layoutView{
    self.backgroundColor     = [UIColor whiteColor];
    self.layer.cornerRadius  = 5;
    self.layer.shadowColor   = [UIColor grayColor].CGColor;
    self.layer.shadowRadius  = 2;
    self.layer.shadowOffset  = CGSizeMake(1, 2);
    self.layer.shadowOpacity = 0.9;
    
//    [self.layer insertSublayer:[self shadowAsInverse] atIndex:0];?
    
    //标题行
    UIView *rectangleView         = [UIView new];
    rectangleView.backgroundColor = [UIColor colorFromHexCode:@"#f70"];
    [self addSubview:rectangleView];
    WS(weakSelf);
    [rectangleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(10);
        make.left.mas_equalTo(weakSelf.mas_left).offset(10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(5);
    }];
    __weak UIView *weakRectangleView = rectangleView;
    UILabel *label = [UILabel new];
    label.text = self.title;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorFromHexCode:@"#333"];
    [self addSubview:label];
    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakRectangleView.mas_right).offset(10);
        make.top.mas_equalTo(weakSelf.mas_top).offset(10);
        make.right.mas_equalTo(weakSelf.mas_right).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    //虚线
    UIView *dashedView = [UIView new];
    [DashedLine drawDashLine:self lineLength:1 lineSpacing:3 lineColor:[UIColor colorFromHexCode:@"#b4b4b4"]];
    dashedView.backgroundColor = [UIColor colorFromHexCode:@"#b4b4b4"];
    [self addSubview:dashedView];
    [dashedView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakRectangleView.mas_bottom).offset(10);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    self.height = PRIMARY_Y + GAP1;
    
    //显示项目
    for (int i = 0; i< self.functions.count; i++) {
        CGRect rect = CGRectMake(ITEM_WIDTH * (i%4), PRIMARY_Y + GAP1 + ((int)(i/4))*ITEM_HEIGHT + GAP_ROW * ((int)(i/4)), ITEM_WIDTH, ITEM_HEIGHT);
        InstalledFunctionView *functionItem = [[InstalledFunctionView alloc]initWithFunction:[self.functions objectAtIndex:i] clickHandler:^(FunctionModel *function) {
            self.clickHandler(function);
        }];
        functionItem.frame = rect;
        [self addSubview:functionItem];
        
        if (i % 4 == 0) {
            self.height = self.height + ITEM_HEIGHT + GAP_ROW;
        }
    }
}




//设置背景色渐变
- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [CAGradientLayer layer];
    [newShadow setBounds:self.bounds];
    
    NSArray *colors = @[(id)[UIColor blueColor].CGColor
                        , (id)[UIColor redColor].CGColor];
    
    //添加渐变的颜色组合
    newShadow.colors = colors;
    return newShadow;
}

@end
