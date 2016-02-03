//
//  QyhfViewController.m
//  市场监管通
//
//  Created by 网新中研 on 16/1/19.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "QyhfViewController.h"
#import "QyhfViewModel.h"

@interface QyhfViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TNRadioButtonGroup *upRadioGroup;
@property (nonatomic, strong) TNRadioButtonGroup *downRadioGroup;
@property (nonatomic, strong) QyhfViewModel *qyhfViewModel;
@property (nonatomic, strong) UIView *searchPanelView;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *goButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, assign) CGFloat jd84;//经度
@property (nonatomic, assign) CGFloat wd84;//纬度
@end

@implementation QyhfViewController

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
        self.isRightBarButtonVisible = YES;
    }
    return self;
}

-(void)layoutView{
    [super layoutView];
    self.label.text = @"主体回访";
}

#define MARGIN 5

-(void)onRightBarButtonClick{
    NSLog(@"点击搜索");
    if (self.searchPanelView.superview == nil) {
        
        WS(weakSelf);
        
        //搜索栏按钮
        [self.view addSubview:self.searchPanelView];
        [self.searchPanelView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.titleLine.mas_bottom);
            make.left.mas_equalTo(weakSelf.view.mas_left);
            make.right.mas_equalTo(weakSelf.view.mas_right);
            make.height.mas_equalTo(150);
        }];
        
        //输入框
        [self.searchPanelView addSubview:self.inputTextField];
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.searchPanelView.mas_top).offset(MARGIN);
            make.left.mas_equalTo(weakSelf.view.mas_left).offset(MARGIN);
            make.right.mas_equalTo(weakSelf.view.mas_right).offset(-MARGIN);
            make.height.mas_equalTo(35);
        }];
        
        //上部radio数组
        __weak UIView *weakInputTextField = self.inputTextField;
        [self.searchPanelView addSubview:self.upRadioGroup];
        [self.upRadioGroup mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakInputTextField.mas_bottom).offset(10);
            make.left.mas_equalTo(weakSelf.searchPanelView.mas_left).offset(MARGIN);
            make.right.mas_equalTo(weakSelf.searchPanelView.mas_right).offset(MARGIN);
            make.height.mas_equalTo(30);
        }];

        //分割线
        __weak TNRadioButtonGroup *weakUpRadioGroup = self.upRadioGroup;
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor colorFromHexCode:@"#b4b4b4"];
        [self.searchPanelView addSubview:lineView];
        [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakUpRadioGroup.mas_bottom);
            make.left.mas_equalTo(weakSelf.searchPanelView.mas_left).offset(MARGIN);
            make.right.mas_equalTo(weakSelf.searchPanelView.mas_right).offset(-MARGIN);
            make.height.mas_equalTo(1);
        }];

        //下部radio数组
        [self.searchPanelView addSubview:self.downRadioGroup];
        [self.downRadioGroup mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakUpRadioGroup.mas_bottom).offset(11);
            make.left.mas_equalTo(weakSelf.searchPanelView.mas_left).offset(MARGIN);
            make.right.mas_equalTo(weakSelf.searchPanelView.mas_right).offset(-MARGIN);
            make.height.mas_equalTo(20);
        }];
        
        //搜索按钮
        __weak TNRadioButtonGroup *weakDownRadioGroup = self.downRadioGroup;
        [self.searchPanelView addSubview:self.goButton];
        [self.goButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakDownRadioGroup.mas_bottom).offset(10);
            make.left.mas_equalTo(weakSelf.searchPanelView.mas_left).offset(MARGIN);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo((kWindowW-15)/2);
        }];

        //取消按钮
        [self.searchPanelView addSubview:self.cancelButton];
        [self.cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakDownRadioGroup.mas_bottom).offset(10);
            make.right.mas_equalTo(weakSelf.searchPanelView.mas_right).offset(-MARGIN);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(kWindowW/2 - 7.5);
        }];
        
        //分割线
        __weak UIButton *weakCancelButton = self.cancelButton;
        UIView *lineView2 = [UIView new];
        lineView2.backgroundColor = [UIColor colorFromHexCode:@"#b4b4b4"];
        [self.searchPanelView addSubview:lineView2];
        [lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakCancelButton.mas_bottom).offset(2);
            make.left.mas_equalTo(weakSelf.searchPanelView.mas_left);
            make.right.mas_equalTo(weakSelf.searchPanelView.mas_right);
            make.height.mas_equalTo(1);
        }];
        
        //列表
        __weak UIView *weakSearchPanel = self.searchPanelView;
        [self.view addSubview:self.tableView];
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSearchPanel.mas_bottom).offset(MARGIN);
            make.left.mas_equalTo(weakSelf.view.mas_left).offset(MARGIN);
            make.right.mas_equalTo(weakSelf.view.mas_right).offset(-MARGIN);
            make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        }];
    }else{
        [self removeSearchPanel];
    }
}

/**
 *  移除搜索蓝
 */
-(void)removeSearchPanel{
    WS(weakSelf);
    [self.searchPanelView removeFromSuperview];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLine.mas_bottom);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
    }];
}

/**
 *  执行搜索
 */
-(void)doQuery:(NSString *)isbz{
    AccountDetailModel *accountDetailModel = [self.qyhfViewModel getAccountDetailFromLocal];
    NSMutableDictionary *paramsDic = [NSMutableDictionary new];
    [paramsDic setObject:accountDetailModel.userid forKey:USERID];
    [paramsDic setObject:@(self.jd84) forKey:JD84];
    [paramsDic setObject:@(self.wd84) forKey:WD84];
    [paramsDic setObject:self.inputTextField.text forKey:QYMCQUERY];
    [paramsDic setObject:isbz forKey:@"isbz"];
    [paramsDic setObject:@"0" forKey:@"rows"];
    
    [self.qyhfViewModel doQueryQy:nil completeHandler:^(id responseObj, NSError *error) {
        NSLog(@"%@", responseObj);
    }];
}

#pragma mark --- TNRadioButtonGroup

-(void)upGroupUpdate:(NSNotification *)notification {
    NSLog(@"[MainView] up group updated to %@", self.upRadioGroup.selectedRadioButton.data.identifier);
}

-(void)downGroupUpdate:(NSNotification *)notification {
    NSLog(@"[MainView] down group updated to %@", self.downRadioGroup.selectedRadioButton.data.identifier);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SELECTED_RADIO_BUTTON_CHANGED object:self.upRadioGroup];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SELECTED_RADIO_BUTTON_CHANGED object:self.downRadioGroup];
}


- (TNRadioButtonGroup *)upRadioGroup {
	if(_upRadioGroup == nil) {
        
        TNImageRadioButtonData *radioButtonData1 = [TNImageRadioButtonData new];
        radioButtonData1.labelText               = @"全部";
        radioButtonData1.identifier              = @"全部";
        radioButtonData1.selected                = YES;
        radioButtonData1.unselectedImage         = [UIImage imageNamed:@"radio_n"];
        radioButtonData1.selectedImage           = [UIImage imageNamed:@"radio_y"];

        TNImageRadioButtonData *radioButtonData2 = [TNImageRadioButtonData new];
        radioButtonData2.labelText               = @"已标注";
        radioButtonData2.identifier              = @"已标注";
        radioButtonData2.selected                = NO;
        radioButtonData2.unselectedImage         = [UIImage imageNamed:@"radio_n"];
        radioButtonData2.selectedImage           = [UIImage imageNamed:@"radio_y"];

        TNImageRadioButtonData *radioButtonData3 = [TNImageRadioButtonData new];
        radioButtonData3.labelText               = @"未标注";
        radioButtonData3.identifier              = @"未标注";
        radioButtonData3.selected                = NO;
        radioButtonData3.unselectedImage         = [UIImage imageNamed:@"radio_n"];
        radioButtonData3.selectedImage           = [UIImage imageNamed:@"radio_y"];

        TNImageRadioButtonData *radioButtonData4 = [TNImageRadioButtonData new];
        radioButtonData4.labelText               = @"附近企业";
        radioButtonData4.identifier              = @"附近企业";
        radioButtonData4.selected                = NO;
        radioButtonData4.unselectedImage         = [UIImage imageNamed:@"radio_n"];
        radioButtonData4.selectedImage           = [UIImage imageNamed:@"radio_y"];
        
        _upRadioGroup = [[TNRadioButtonGroup alloc] initWithRadioButtonData:@[radioButtonData1, radioButtonData2, radioButtonData3, radioButtonData4] layout:TNRadioButtonGroupLayoutHorizontal];
        _upRadioGroup.identifier = @"up group";
        _upRadioGroup.marginBetweenItems = 10;
        [_upRadioGroup create];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upGroupUpdate:) name:SELECTED_RADIO_BUTTON_CHANGED object:_upRadioGroup];
	}
	return _upRadioGroup;
}

- (TNRadioButtonGroup *)downRadioGroup {
	if(_downRadioGroup == nil) {
        
        TNImageRadioButtonData *radioButtonData1 = [TNImageRadioButtonData new];
        radioButtonData1.labelText               = @"全部";
        radioButtonData1.identifier              = @"全部";
        radioButtonData1.selected                = YES;
        radioButtonData1.unselectedImage         = [UIImage imageNamed:@"radio_n"];
        radioButtonData1.selectedImage           = [UIImage imageNamed:@"radio_y"];

        TNImageRadioButtonData *radioButtonData2 = [TNImageRadioButtonData new];
        radioButtonData2.labelText               = @"已开业";
        radioButtonData2.identifier              = @"已开业";
        radioButtonData2.selected                = NO;
        radioButtonData2.unselectedImage         = [UIImage imageNamed:@"radio_n"];
        radioButtonData2.selectedImage           = [UIImage imageNamed:@"radio_y"];

        TNImageRadioButtonData *radioButtonData3 = [TNImageRadioButtonData new];
        radioButtonData3.labelText               = @"未开业";
        radioButtonData3.identifier              = @"未开业";
        radioButtonData3.selected                = NO;
        radioButtonData3.unselectedImage         = [UIImage imageNamed:@"radio_n"];
        radioButtonData3.selectedImage           = [UIImage imageNamed:@"radio_y"];
        
        _downRadioGroup = [[TNRadioButtonGroup alloc] initWithRadioButtonData:@[radioButtonData1, radioButtonData2, radioButtonData3] layout:TNRadioButtonGroupLayoutHorizontal];
        _downRadioGroup.identifier = @"down group";
        _downRadioGroup.marginBetweenItems = 10;
        [_downRadioGroup create];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downGroupUpdate:) name:SELECTED_RADIO_BUTTON_CHANGED object:_downRadioGroup];
        
	}
	return _downRadioGroup;
}

#pragma mark --- UITableViewDelegate/UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = @"1";
    return cell;
}

//移除分割线左侧边距
kRemoveCellSeparator

#pragma mark --- 懒加载

- (UIView *)searchPanelView {
	if(_searchPanelView == nil) {
		_searchPanelView = [[UIView alloc] init];
	}
	return _searchPanelView;
}

- (UITextField *)inputTextField {
	if(_inputTextField == nil) {
        _inputTextField                   = [[UITextField alloc] init];
        _inputTextField.textColor         = COLOR_DIMGGREY;
        _inputTextField.font              = [UIFont flatFontOfSize:18];
        _inputTextField.placeholder       = @"企业名臣、注册号或法定代表人";
        _inputTextField.borderStyle       = UITextBorderStyleNone;
        _inputTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _inputTextField.layer.borderWidth = 0.5;
	}
	return _inputTextField;
}

- (UIButton *)goButton {
	if(_goButton == nil) {
        _goButton                      = [[UIButton alloc] init];
        _goButton.backgroundColor      = [UIColor colorFromHexCode:@"#69aaed"];
        _goButton.titleLabel.font      = [UIFont flatFontOfSize:20];
        _goButton.layer.cornerRadius   = 5;
        _goButton.titleLabel.textColor = [UIColor whiteColor];
        [_goButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_goButton setTitle:@"搜索" forState:UIControlStateHighlighted];
	}
	return _goButton;
}

- (UIButton *)cancelButton {
	if(_cancelButton == nil) {
        _cancelButton                      = [[UIButton alloc] init];
        _cancelButton.backgroundColor      = [UIColor colorFromHexCode:@"#69aaed"];
        _cancelButton.titleLabel.font      = [UIFont flatFontOfSize:20];
        _cancelButton.layer.cornerRadius   = 5;
        _cancelButton.titleLabel.textColor = [UIColor whiteColor];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateHighlighted];
	}
	return _cancelButton;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView            = [[UITableView alloc] init];
        _tableView.delegate   = self;
        _tableView.dataSource = self;

    }
    return _tableView;
}


@end
