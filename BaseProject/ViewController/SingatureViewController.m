//
//  SingatureViewController.m
//  市场监管通
//
//  Created by 网新中研 on 16/1/27.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "SingatureViewController.h"

@interface SingatureViewController ()
/**
 *  签名视图对象
 */
@property (nonatomic, strong) PPSSignatureView *signatureView;
@property (nonatomic, strong) UIButton         *saveButton;
@property (nonatomic, strong) UIButton         *clearButton;
@property (nonatomic, strong) UIImageView      *saveBackgroundImageView;
@property (nonatomic, strong) UIImageView      *clearImageView;


@end

@implementation SingatureViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)init{
    if (self = [super init]) {
        self.isNavigationBarVisible = YES;
        self.isBackButtonVisible = YES;
        self.isRightBarButtonVisible = NO;
        [self.navigationController.navigationController setNavigationBarHidden:YES];
        
        self.label.text = @"手写签名";
    }
    return self;
}

-(void)layoutView{
    [super layoutView];
    
    WS(weakSelf);
    [self.view addSubview:self.signatureView];
    [self.signatureView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLine.mas_bottom);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
    }];
    
    //添加保存按钮；
    [self.view addSubview:self.saveButton];
    
    //添加清除按钮
    [self.view addSubview:self.clearButton];
    
    
}

/**
 *  点击保存
 */
-(void)onSaveSaveClick{
    NSLog(@"点击保存");
    
    //判断是否有签名
    if (!self.signatureView.hasSignature) {
        [SFToastView showWithSuperView:self.view title:@"请签名后再保存！"];
        return;
    }
    
    //上传图像
    NSString *imageName = [self getImageName:nil];
    NSData *data = [self rarImage:self.signatureView.snapshot];
    [self.viewModel uploadImageWithImageName:imageName data:data serverPath:SERVER_PATH gxdw:self.gxdw userid:self.userid czmk:self.czmk];
    
    //参数回传，出来返回结果
    NSString *imageUrl = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/", SERVER_PATH,
                          self.gxdw,
                          self.userid,
                          self.czmk,
                          [self getCurrentDateTime:@"yyyyMM"]];
    NSMutableDictionary *resultDic = [NSMutableDictionary new];
    [resultDic setObject:imageUrl forKey:@"imageUrl"];
    [resultDic setObject:imageName forKey:@"imageName"];
    [resultDic setObject:@"4" forKey:@"group"];
    [self.resultDelegate onResult:resultDic requestCoe:104 responseCode:RESULT_OK];
    
    //关闭当前界面
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  点击清空
 */
-(void)onClearClick{
    [self.signatureView erase];
}

- (PPSSignatureView *)signatureView {
	if(_signatureView == nil) {
		_signatureView = [[PPSSignatureView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) context:nil];
	}
	return _signatureView;
}



- (UIButton *)saveButton {
	if(_saveButton == nil) {

        float btn_width     = 0.0f;
        float btn_height    = 0.0f;
        float btn_orgheight = 0.0f;//30.0f;
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            btn_width     = 40;
            btn_height    = 30;
            btn_orgheight = 25;
        }else{
            btn_width     = 70;
            btn_height    = 50;
            btn_orgheight = 30;
        }
        
        _saveButton = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW - btn_width - 10, btn_orgheight, btn_width, btn_height)];
        [_saveButton addTarget:self action:@selector(onSaveSaveClick) forControlEvents:UIControlEventTouchUpInside];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
        _saveButton.titleLabel.font    = [UIFont flatFontOfSize:15];
        _saveButton.layer.cornerRadius = 5;
        _saveButton.layer.borderWidth  = 1;
        _saveButton.layer.borderColor  = [UIColor colorFromHexCode:@"#999999"].CGColor;
	}
	return _saveButton;
}

- (UIButton *)clearButton {
	if(_clearButton == nil) {

        float btn_width     = 0.0f;
        float btn_height    = 0.0f;
        float btn_orgheight = 0.0f;//30.0f;
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            btn_width     = 40;
            btn_height    = 30;
            btn_orgheight = 25;
        }else{
            btn_width     = 70;
            btn_height    = 50;
            btn_orgheight = 30;
        }
        
        _clearButton = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW - btn_width * 2 - 20, btn_orgheight, btn_width, btn_height)];
        [_clearButton addTarget:self action:@selector(onClearClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_clearButton setTitle:@"清除" forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
        _clearButton.titleLabel.font    = [UIFont flatFontOfSize:15];
        _clearButton.layer.cornerRadius = 5;
        _clearButton.layer.borderWidth  = 1;
        _clearButton.layer.borderColor  = [UIColor colorFromHexCode:@"#999999"].CGColor;
	}
	return _clearButton;
}

- (UIImageView *)saveBackgroundImageView {
	if(_saveBackgroundImageView == nil) {
		_saveBackgroundImageView = [[UIImageView alloc] init];
	}
	return _saveBackgroundImageView;
}

- (UIImageView *)clearImageView {
	if(_clearImageView == nil) {
		_clearImageView = [[UIImageView alloc] init];
	}
	return _clearImageView;
}

@end
