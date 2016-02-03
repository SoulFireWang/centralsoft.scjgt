//
//  FunctionItem.m
//  市场监管
//
//  Created by 网新中研 on 16/1/6.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "InstalledFunctionView.h"

@interface InstalledFunctionView ()
@property (nonatomic, copy)ClickBlock clickHandler;
@end

@implementation InstalledFunctionView

-(id)initWithFunction:(FunctionModel *)functionModel clickHandler:(ClickBlock)clickHandler{
    if (self = [super init]) {
        self.clickHandler = clickHandler;
        self.functionModel = functionModel;
        [self layoutView];
    }
    return self;
}

-(void)layoutView{
    
    self.backgroundColor = [UIColor whiteColor];
    WS(weakSelf);
    
    //图像
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(32);
    }];
    NSString *imageName = [NSString stringWithFormat:@"t%@.png",self.functionModel.functionid];
    imageView.image = [UIImage imageNamed:imageName];
    
    //文字
    __weak UIImageView *weakImageView = imageView;
    UILabel *label                    = [UILabel new];
    label.font                        = [UIFont systemFontOfSize:12];
    label.textColor                   = [UIColor blackColor];
    label.text                        = self.functionModel.functionname;
    label.textAlignment               = NSTextAlignmentCenter;
    [self addSubview:label];
    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakImageView.mas_bottom).offset(4);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    //按钮覆盖
    UIButton *button = [UIButton new];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
}

-(void)clickButton{
    self.clickHandler(self.functionModel);
}

@end
