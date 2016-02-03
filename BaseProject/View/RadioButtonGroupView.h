//
//  RadioButtonGroupView.h
//  市场监管通
//
//  Created by 网新中研 on 16/1/19.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseView.h"

@protocol RadioButtonGroupDelegate <NSObject>

-(void)itemSelected:(NSInteger)selectedIndex;

-(void)selectedItem:(NSInteger)selectIndex;

@end

@interface RadioButtonGroupView : BaseView

@property (nonatomic, weak, nullable) id <UITableViewDelegate> delegate;

@end
