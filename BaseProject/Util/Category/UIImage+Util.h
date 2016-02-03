//
//  UIImage+Util.h
//  市场监管通
//
//  Created by 网新中研 on 16/1/25.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

+ (void)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath;

+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size;

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
