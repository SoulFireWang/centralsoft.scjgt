//
//  SearchViewModel.m
//  市场监管通
//
//  Created by 网新中研 on 16/1/15.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "SearchViewModel.h"

@implementation SearchViewModel
-(NSArray *)getHistorySearchItems{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arrays = (NSMutableArray *)[userDefaults objectForKey:@"historySearchItems"];
    
    return arrays;
}

-(void)saveHistorySearhItems:(NSArray *)historySearchItems{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:historySearchItems forKey:@"historySearchItems"];
}
@end
