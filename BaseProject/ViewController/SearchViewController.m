//
//  SearchViewController.m
//  市场监管通
//
//  Created by 网新中研 on 16/1/15.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchViewModel.h"

@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView          *leftBackView;
@property (strong, nonatomic) IBOutlet UITextField     *inputTextField;
@property (strong, nonatomic) IBOutlet UITableView     *tableView;
@property (strong, nonatomic) IBOutlet UIButton        *chooseTypeButton;
@property (strong, nonatomic) IBOutlet UILabel         *typeLabel;

@property (nonatomic, strong) NSMutableArray  *historySearchItems;
@property (nonatomic, strong) SearchViewModel *searchViewModel;
@property (nonatomic, strong) NSArray         *chooseTypes;
@property (nonatomic, assign) int             chooseType;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)layoutView{
    [super layoutView];
    self.leftBackView.backgroundColor    = [UIColor colorFromHexCode:@"#E5E5E5"];
    self.leftBackView.layer.cornerRadius = 3;
    self.tableView.dataSource            = self;
    self.tableView.delegate              = self;
    self.historySearchItems              = [NSMutableArray arrayWithArray:[self.searchViewModel getHistorySearchItems]];
    self.chooseTypeButton.frame          = CGRectMake(self.chooseTypeButton.frame.origin.x, self.chooseTypeButton.frame.origin.y, self.chooseTypeButton.frame.size.width, 30);
    self.chooseType                      = 0;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.inputTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)chooseType:(id)sender {
    
    CGRect rect = CGRectMake(self.chooseTypeButton.frame.origin.x, self.chooseTypeButton.frame.origin.y + self.chooseTypeButton.frame.size.height, self.chooseTypeButton.frame.size.width, self.chooseTypeButton.frame.size.height);
    [KxMenu showMenuInView:self.view fromRect:rect menuItems:self.chooseTypes];
}
- (IBAction)cancelClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)searchClick:(id)sender {
    
    //关键词为空则选历史记录第一项
    if ([self.inputTextField.text isEqualToString:@""]) {
        
        if(self.historySearchItems.count > 0) self.inputTextField.text = [self.historySearchItems objectAtIndex:(self.historySearchItems.count - 1)];
        return;
    }
    
    //如果没有重复关键词，则保存
    BOOL isSaveRequired = YES;
    for (NSString *keyWord in self.historySearchItems) {
        if ([self.inputTextField.text isEqualToString:keyWord]) {
            isSaveRequired = NO;
            break;
        }
    }
    if (isSaveRequired) {
        [self.historySearchItems addObject:self.inputTextField.text];
    }
    
    //最多保存10项记录
    if(self.historySearchItems.count > 10){
        [self.historySearchItems removeObjectAtIndex:0];
    }
    [self.searchViewModel saveHistorySearhItems:self.historySearchItems];
    [self.tableView reloadData];
    
    //执行查询命令
    NSString *queryString = @"";
    switch (self.chooseType) {
        case 0:
            queryString = [NSString stringWithFormat:@"scjgtZt.do?method=ztcx_list&cxtj=%@", [EncryptBase64 encryptTwice:self.inputTextField.text]];
            queryString = GET_REQUEST(queryString);
            [super openWebViewControllerWithRequestString:queryString title:@"主体查询" isNavgationBarVisible:YES];
            break;
        case 1:
            queryString = [NSString stringWithFormat:@"scjgt.do?method=hwggcx_list&cxtj=%@", [EncryptBase64 encryptTwice:self.inputTextField.text]];
            queryString = GET_REQUEST(queryString);
            [super openWebViewControllerWithRequestString:queryString title:@"广告查询" isNavgationBarVisible:YES];
            break;
        case 2:
            queryString = [NSString stringWithFormat:@"scjgt.do?method=sbcx_list&cxtj=%@", [EncryptBase64 encryptTwice:self.inputTextField.text]];
            queryString = GET_REQUEST(queryString);
            [super openWebViewControllerWithRequestString:queryString title:@"商标查询" isNavgationBarVisible:YES];
            break;
        case 3:
            queryString = [NSString stringWithFormat:@"scjgt.do?method=sccx_list&cxtj=%@", [EncryptBase64 encryptTwice:self.inputTextField.text]];
            queryString = GET_REQUEST(queryString);
            [super openWebViewControllerWithRequestString:queryString title:@"市场查询" isNavgationBarVisible:YES ];
            break;
    }
}

/**
 *  主体查询
 */
-(void)ztcx{
    self.chooseType = 0;
    self.typeLabel.text = @"主体查询";
}

/**
 *  广告查询
 */
-(void)ggcx{
    self.chooseType = 1;
    self.typeLabel.text = @"广告查询";
}

/**
 *  商标查询
 */
-(void)sbcx{
    self.chooseType = 2;
    self.typeLabel.text = @"商标查询";
}

/**
 *  市场查询
 */
-(void)sccx{
    self.chooseType = 3;
    self.typeLabel.text = @"市场查询";
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historySearchItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = (NSString *)[self.historySearchItems objectAtIndex:(self.historySearchItems.count- 1 - indexPath.row)];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.inputTextField.text = [self.historySearchItems objectAtIndex:self.historySearchItems.count - 1 - indexPath.row];
}

- (SearchViewModel *)searchViewModel {
	if(_searchViewModel == nil) {
		_searchViewModel = [[SearchViewModel alloc] init];
	}
	return _searchViewModel;
}

- (NSMutableArray *)historySearchItems {
	if(_historySearchItems == nil) {
		_historySearchItems = [[NSMutableArray alloc] init];
	}
	return _historySearchItems;
}

- (NSArray *)chooseTypes {
	if(_chooseTypes == nil) {
        _chooseTypes = @[[KxMenuItem menuItem:@"主体查询" image:nil target:self action:@selector(ztcx)],
                         [KxMenuItem menuItem:@"广告查询" image:nil target:self action:@selector(ggcx)],
                         [KxMenuItem menuItem:@"商标查询" image:nil target:self action:@selector(sbcx)],
                         [KxMenuItem menuItem:@"市场查询" image:nil target:self action:@selector(sccx)]];
	}
	return _chooseTypes;
}

@end
