//
//  NSObject+Common.h
//  FDPublic
//
//  Created by xf.wang on 15/6/19.
//  Copyright (c) 2015年 centralsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

//显示失败提示
- (void)showErrorMsg:(NSObject *)msg;

//显示成功提示
- (void)showSuccessMsg:(NSObject *)msg;

//显示忙
- (void)showProgress;

//隐藏提示
- (void)hideProgress;

/**
 *  获取指定格式系统时间
 *
 *  @param stringFormat 指定格式
 *
 *  @return 系统时间描述
 */
-(NSString *)getCurrentDateTime:(NSString *)stringFormat;

/**
 *  获取图片名称
 *
 *  @param filePath 图片路径
 *
 *  @return 图片名称
 */
-(NSString *)getImageName:(NSString *)filePath;

/**
 *  转换图片为NSData并压缩
 *
 *  @param image 图片
 *
 *  @return 压缩过后的文件数据
 */
-(NSData *)rarImage:(UIImage *)image;

/**
 *  拼接字符串数组
 *
 *  @param stringArray  字符串数组
 *  @param appendString 拼接字符
 *
 *  @return 拼接好的字符串
 */
-(NSString *)appendStringArray:(NSArray *)stringArray seperatorString:(NSString *)seperatorString;

@end
