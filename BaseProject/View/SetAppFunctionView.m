//
//  SetFunctionItem.m
//  市场监管
//
//  Created by 网新中研 on 16/1/7.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "SetAppFunctionView.h"

@interface SetAppFunctionView()

@property (nonatomic, copy  ) ClickBlock installClickHandler;
@property (nonatomic, copy  ) ClickBlock uninstallClickHandler;
@property (nonatomic, strong) UILabel    *buttonTextLabel;
@end

@implementation SetAppFunctionView

-(id)initWithFunction:(FunctionModel *)functionModel installClickHandler:(ClickBlock)installClickHandler uninstallClickHandler:(ClickBlock)uninstallClickHandler{
    if (self = [super init]) {
        self.installClickHandler   = installClickHandler;
        self.uninstallClickHandler = uninstallClickHandler;
        self.functionModel         = functionModel;
        [self layoutView];
    }
    return self;
}

#define IMAGE_WIDTH 32

/*
   安装按钮风格
 */
#define INSTALL_TEXT_COLOR [UIColor   colorFromHexCode:@"#666666"]
#define INSTALL_BACK_COLOR [UIColor   colorFromHexCode:@"#f6f6f6"]
#define INSTALL_BORDER_COLOR [UIColor colorFromHexCode:@"#d0d0d0"]
#define INSTALL_TEXT @"安装"

/*
   卸载按钮风格
 */
#define UNINSTALL_TEXT_COLOR [UIColor   colorFromHexCode:@"#ffffff"]
#define UNINSTALL_BACK_COLOR [UIColor   colorFromHexCode:@"#69aaed"]
#define UNINSTALL_BORDER_COLOR [UIColor colorFromHexCode:@"#69aaed"]
#define UNINSTALL_TEXT @"卸载"


/**
 *  安装按钮风格
 */
-(void)installCustom{
    self.buttonTextLabel.text              = INSTALL_TEXT;
    self.buttonTextLabel.textColor         = INSTALL_TEXT_COLOR;
    self.buttonTextLabel.backgroundColor   = INSTALL_BACK_COLOR;
    self.buttonTextLabel.layer.borderColor = INSTALL_BORDER_COLOR.CGColor;
}

/**
 *  卸载按钮风格
 */
-(void)uninstallCustom{
    self.buttonTextLabel.text              = UNINSTALL_TEXT;
    self.buttonTextLabel.textColor         = UNINSTALL_TEXT_COLOR;
    self.buttonTextLabel.backgroundColor   = UNINSTALL_BACK_COLOR;
    self.buttonTextLabel.layer.borderColor = UNINSTALL_BORDER_COLOR.CGColor;
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
        make.height.mas_equalTo(IMAGE_WIDTH);
        make.width.mas_equalTo(IMAGE_WIDTH);
    }];
    NSString *imageName = [NSString stringWithFormat:@"t%@.png",self.functionModel.functionid];
    imageView.image = [UIImage imageNamed:imageName];
    
    //文字
    __weak UIImageView *weakImageView = imageView;
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    label.text = self.functionModel.functionname;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakImageView.mas_bottom).offset(4);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    //安装按钮
    __weak UILabel *weakLabel                = label;
    self.buttonTextLabel                     = [UILabel new];
    self.buttonTextLabel.font                = [UIFont systemFontOfSize:15];
    self.buttonTextLabel.textAlignment       = NSTextAlignmentCenter;
    self.buttonTextLabel.textColor           = INSTALL_TEXT_COLOR;
    self.buttonTextLabel.text                = INSTALL_TEXT;
    self.buttonTextLabel.backgroundColor     = INSTALL_BACK_COLOR;
    self.buttonTextLabel.layer.cornerRadius  = 2;
    self.buttonTextLabel.layer.borderWidth   = 1;
    self.buttonTextLabel.layer.borderColor   = INSTALL_BACK_COLOR.CGColor;
    self.buttonTextLabel.layer.masksToBounds = YES;
    [self addSubview:self.buttonTextLabel];
    [self.buttonTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(IMAGE_WIDTH + 18);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    __weak UILabel *weakButtonTextLabel = self.buttonTextLabel;
    UIButton *button = [UIButton new];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakButtonTextLabel);
    }];
    
    //设置按钮风格
    if (self.functionModel.isInstalled) {
        [self uninstallCustom];
    }else{
        [self installCustom];
    }
}

-(void)clickButton{
    if ([self.buttonTextLabel.text isEqualToString:INSTALL_TEXT]) {//点击安装处理
        if (self.installClickHandler(self.functionModel)) {
            [self uninstallCustom];
        }
    }else{//点击卸载处理
        if (self.uninstallClickHandler(self.functionModel)) {
            [self installCustom];
        }
    }
}




@end
