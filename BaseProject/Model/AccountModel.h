//
//  AccountModel.h
//  市场监管
//
//  Created by 网新中研 on 15/12/30.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import "BaseModel.h"

@interface AccountModel : BaseModel
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *phoneNo;
@end
