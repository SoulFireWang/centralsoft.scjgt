//
//  SearchViewModel.h
//  市场监管通
//
//  Created by 网新中研 on 16/1/15.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseViewModel.h"

@interface SearchViewModel : BaseViewModel

-(NSArray *)getHistorySearchItems;

-(void)saveHistorySearhItems:(NSArray *)historySearchItems;

@end
