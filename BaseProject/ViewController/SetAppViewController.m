//
//  SetAppViewController.m
//  市场监管
//
//  Created by 网新中研 on 16/1/7.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "SetAppViewController.h"
#import "SetAppViewModel.h"
#import "FunctionModel.h"
#import "SetAppFunctionGroupView.h"
#import "AccountDetailModel.h"

@interface SetAppViewController ()
@property (strong, nonatomic) IBOutlet UIView   *topVIew;
@property (strong, nonatomic) IBOutlet UIView   *top2View;
@property (strong, nonatomic) IBOutlet UIButton *cxButton;
@property (strong, nonatomic) IBOutlet UIButton *zfButton;
@property (strong, nonatomic) IBOutlet UIButton *fzButton;
@property (strong, nonatomic) IBOutlet UIView   *radioBackView;
@property (strong, nonatomic) IBOutlet UILabel  *cxLabel;
@property (strong, nonatomic) IBOutlet UILabel  *zfLabel;
@property (strong, nonatomic) IBOutlet UILabel  *fzLabel;

@property (nonatomic, strong) SetAppViewModel *setAppViewModel;
@property (nonatomic, strong) UIScrollView    *functionScrollView;

@end

@implementation SetAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.setAppViewModel saveFunction:self.accountDetailModel completionHandler:^(id responseObj, NSError *error) {
        if (error != nil) {
            NSLog(@"保存失败");
        }else{
            NSLog(@"保存成功");
        }
    }];
    
    [super viewWillDisappear:animated];
}

#define SELECT_TEXT_COLOR [UIColor colorFromHexCode:@"#5ba3eb"]
#define UNSELECT_TEXT_COLOR [UIColor colorFromHexCode:@"#666666"]
#define LAYOUT_MARGIN_LEFT 10

-(void)layoutView{
    self.view.backgroundColor     = [UIColor colorFromHexCode:@"#edf0f2"];
    self.topVIew.backgroundColor  = [UIColor colorFromHexCode:@"#5ca5ed"];
    self.top2View.backgroundColor = [UIColor colorFromHexCode:@"#5ca5ed"];
    
    self.cxLabel.textColor = UNSELECT_TEXT_COLOR;
    self.zfLabel.textColor = UNSELECT_TEXT_COLOR;
    self.fzLabel.textColor = UNSELECT_TEXT_COLOR;
    
    self.radioBackView.backgroundColor = [UIColor colorFromHexCode:@"#f7f7f7"];
    
    WS(weakSelf);
    [self.view addSubview:self.functionScrollView];
    [self.functionScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.radioBackView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-weakSelf.tabBarController.tabBar.frame.size.height);
        make.width.mas_equalTo(kWindowW - 2 * LAYOUT_MARGIN_LEFT);
    }];
    self.functionScrollView.contentSize = CGSizeMake(self.functionScrollView.frame.size.width, 0);
    
    //加载系统程序
    [self cxClick:nil];
}

-(void)setContextDic:(NSMutableDictionary *)contextDic{
    [super setContextDic:contextDic];
    
    self.accountDetailModel = [AccountDetailModel mj_objectWithKeyValues:contextDic];
    NSLog(@"%@", self.accountDetailModel);
}

- (IBAction)cxClick:(id)sender {
    [self resetColor];
    self.cxLabel.textColor = SELECT_TEXT_COLOR;
    [self addFunctionGroup:[self.setAppViewModel getCXFunctions:self.accountDetailModel]];
}

- (IBAction)zfClick:(id)sender {
    [self resetColor];
    self.zfLabel.textColor = SELECT_TEXT_COLOR;
    [self addFunctionGroup:[self.setAppViewModel getZFFunctions:self.accountDetailModel]];
}

- (IBAction)fzClick:(id)sender {
    [self resetColor];
    self.fzLabel.textColor = SELECT_TEXT_COLOR;
    [self addFunctionGroup:[self.setAppViewModel getFZFunctions:self.accountDetailModel]];
}

#define GROUP_GAP 15

-(void)addFunctionGroup:(NSArray *)functions{
    
    REMOVE_SUBVIEWS(self.functionScrollView);
    
    SetAppFunctionGroupView *functionGroupView = [[SetAppFunctionGroupView alloc]initWithFunctions:functions installClickHandler:^BOOL(FunctionModel *functionModel) {
        //安装处理
        return [self install:functionModel];
    } uninstallClickHandler:^BOOL(FunctionModel *functionModel) {
        //卸载处理
        return [self uninstall:functionModel];
    }];
    
    functionGroupView.frame             = CGRectMake(0,0, self.functionScrollView.frame.size.width, functionGroupView.frame.size.height);
    self.functionScrollView.contentSize = CGSizeMake(0, functionGroupView.frame.size.height + GROUP_GAP);
    [self.functionScrollView addSubview:functionGroupView];
    
    NSLog(@"frame width: %lf, content width: %lf", self.functionScrollView.frame.size.width, self.functionScrollView.contentSize.width);
    
}

-(BOOL)uninstall:(FunctionModel *)functionModel{
    
    if ([functionModel.functionid isEqualToString:@"13"]) {//主体查询限制
        [SFToastView showWithSuperView:self.view title:@"\"主体查询\"为默认应用，无法卸载"];
        return NO;
    }
    
    NSString *hasFunctions = [self.accountDetailModel.hasfunction stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@",%@", functionModel.functionid] withString:@""];
    hasFunctions = [hasFunctions stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@,", functionModel.functionid] withString:@""];
    //保存进上下文
    [self.contextDic setValue:hasFunctions forKey:HASFUNCTION];
    self.accountDetailModel.hasfunction = hasFunctions;
    
    [SFToastView showWithSuperView:self.view title:@"卸载成功"];
    
    NSLog(@"卸载功能项为：%@", functionModel.functionid);
    NSLog(@"卸载后所拥有功能：%@", self.accountDetailModel.hasfunction);
    
    return YES;
}

-(BOOL)install:(FunctionModel *)functionModel{
    
    NSString *hasFunctions =[self.accountDetailModel.hasfunction stringByAppendingString:[NSString stringWithFormat:@",%@", functionModel.functionid]];
    //保存进上下文
    [self.contextDic setValue:hasFunctions forKey:HASFUNCTION];
    self.accountDetailModel.hasfunction = hasFunctions;
    
    [SFToastView showWithSuperView:self.view title:@"安装成功"];
    
    NSLog(@"安装功能项为：%@", functionModel.functionid);
    NSLog(@"安装后所拥有功能：%@", self.accountDetailModel.hasfunction);
    
    return YES;
}

-(void)resetColor{
    self.cxLabel.textColor = UNSELECT_TEXT_COLOR;
    self.fzLabel.textColor = UNSELECT_TEXT_COLOR;
    self.zfLabel.textColor = UNSELECT_TEXT_COLOR;
}

- (UIScrollView *)functionScrollView {
	if(_functionScrollView == nil) {
        _functionScrollView                                = [[UIScrollView alloc] init];
        _functionScrollView.frame                          = CGRectMake(LAYOUT_MARGIN_LEFT, 0, kWindowW - 2 * LAYOUT_MARGIN_LEFT, 0);
        _functionScrollView.contentSize                    = CGSizeMake(_functionScrollView.frame.size.width, 0);
        _functionScrollView.backgroundColor                = [UIColor clearColor];
        _functionScrollView.showsHorizontalScrollIndicator = NO;
        _functionScrollView.showsVerticalScrollIndicator   = NO;
        _functionScrollView.bounces                        = NO;
        _functionScrollView.alwaysBounceVertical           = NO;
        _functionScrollView.alwaysBounceHorizontal         = NO;
	}
	return _functionScrollView;
}

- (SetAppViewModel *)setAppViewModel {
	if(_setAppViewModel == nil) {
		_setAppViewModel = [[SetAppViewModel alloc] init];
	}
	return _setAppViewModel;
}

- (AccountDetailModel *)accountDetailModel {
	if(_accountDetailModel == nil) {
		_accountDetailModel = [[AccountDetailModel alloc] init];
	}
	return _accountDetailModel;
}

@end
