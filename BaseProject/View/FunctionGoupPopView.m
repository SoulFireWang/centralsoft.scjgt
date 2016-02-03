//
//  FunctionGoupPopView.m
//  市场监管
//
//  Created by 网新中研 on 16/1/11.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "FunctionGoupPopView.h"
#import "InstalledFunctionView.h"

@interface FunctionGoupPopView()
@property (nonatomic, strong) FunctionModel *function;
@property (nonatomic, strong) NSArray *subFunctions;
@property (nonatomic, copy) ClickBlock clickHandler;
@end

@implementation FunctionGoupPopView

-(id)initWithFunction:(FunctionModel *)functionModel subFunctions:(NSArray *)subFunctions clickHandler:(ClickBlock)clickHandler;{
    if (self = [super init]) {
        self.function = functionModel;
        self.subFunctions = subFunctions;
        self.clickHandler = clickHandler;
        [self layoutView];
    }
    return self;
}

#define GAP1        10
#define GAP_ROW     10
#define ITEM_HEIGHT 56
#define PRIMARY_Y   45
#define ITEM_WIDTH ((kWindowW/4.0*3.0 - 20) / 3)

-(void)layoutView{
    WS(weakSelf);
    
    //背景
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pub_pop_bg4"]];
    [self addSubview:backImageView];
    [backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
    
    //功能集合标题
    UILabel *titleLabel      = [[UILabel alloc]init];
    titleLabel.textColor     = [UIColor colorFromHexCode:@"#000"];
    titleLabel.text          = self.function.functionname;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font          = [UIFont flatFontOfSize:15];
    [self addSubview:titleLabel];
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(5);
        make.left.mas_equalTo(weakSelf.mas_left).offset(10);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    //加横线
    __weak UILabel *weakTitleLabel = titleLabel;
    UIView *lineView               = [UIView new];
    lineView.backgroundColor       = [UIColor colorFromHexCode:@"#b4b4b4"];
    [self addSubview:lineView];
    
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakTitleLabel.mas_bottom);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(weakSelf.mas_left).offset(4);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-4);
    }];
    
    self.height = PRIMARY_Y + GAP1 + GAP_ROW;
    
    //显示项目
    for (int i = 0; i< self.subFunctions.count; i++) {
        CGRect rect = CGRectMake(ITEM_WIDTH * (i%3) + GAP1, PRIMARY_Y + GAP1 + ((int)(i/3))*ITEM_HEIGHT + GAP_ROW * ((int)(i/3)), ITEM_WIDTH, ITEM_HEIGHT);
        InstalledFunctionView *functionItem = [[InstalledFunctionView alloc]initWithFunction:[self.subFunctions objectAtIndex:i] clickHandler:^(FunctionModel *function) {
            self.clickHandler(function);
        }];
        functionItem.frame = rect;
        [self addSubview:functionItem];
        
        if (i % 3 == 0) {
            self.height = self.height + ITEM_HEIGHT + GAP_ROW;
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
