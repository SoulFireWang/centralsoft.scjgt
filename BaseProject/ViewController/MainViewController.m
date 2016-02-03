//
//  MainViewController.m
//  市场监管
//
//  Created by 网新中研 on 16/1/4.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *butonLineImageView;
@property (strong, nonatomic) IBOutlet UIView      *topBarView;
@property (strong, nonatomic) IBOutlet UIView      *mainAreaView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layoutView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutView{
    
    self.butonLineImageView.backgroundColor = [UIColor colorFromHexCode:@"#b4b4b4"];
    self.topBarView.backgroundColor = [UIColor colorFromHexCode:@"#AE0911"];
    
}

@end
