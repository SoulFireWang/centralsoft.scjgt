//
//  SingatureViewController.h
//  市场监管通
//
//  Created by 网新中研 on 16/1/27.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseViewController.h"
/**
 *  数字签名的视图控制器
 */
@interface SingatureViewController : BaseViewController

@property (nonatomic, strong) NSString *gxdw;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *czmk;

/**
 *  擦掉手写内容
 */
-(void)erase;

/**
 *  将手写图像保存成图片
 */
-(void)screenShot;

@end
