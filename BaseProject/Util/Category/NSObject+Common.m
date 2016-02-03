//
//  NSObject+Common.m
//  FDPublic
//
//  Created by xf.wang on 15/6/19.
//  Copyright (c) 2015年 centralsoft. All rights reserved.
//

#import "NSObject+Common.h"

#define kToastDuration     1

@implementation NSObject (Common)

//显示失败提示
- (void)showErrorMsg:(NSObject *)msg{
    [self hideProgress];
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:[self currentView] animated:YES];
    progressHUD.mode = MBProgressHUDModeText;
    progressHUD.labelText = msg.description;
    [progressHUD hide:YES afterDelay:kToastDuration];
}

//显示成功提示
- (void)showSuccessMsg:(NSObject *)msg{
    [self hideProgress];
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:[self currentView] animated:YES];
    progressHUD.mode = MBProgressHUDModeText;
    progressHUD.labelText = msg.description;
    [progressHUD hide:YES afterDelay:kToastDuration];
}

//显示忙
- (void)showProgress{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:[self currentView] animated:YES];
    [progressHUD hide:YES afterDelay:kToastDuration];
}

//隐藏提示
- (void)hideProgress{
    [MBProgressHUD hideAllHUDsForView:[self currentView] animated:YES];
}

- (UIView *)currentView{
    UIViewController *controller = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    if ([controller isKindOfClass:[UITabBarController class]]) {
        controller = [(UITabBarController *)controller selectedViewController];
    }
    if([controller isKindOfClass:[UINavigationController class]]) {
        controller = [(UINavigationController *)controller visibleViewController];
    }
    if (!controller) {
        return [UIApplication sharedApplication].keyWindow;
    }
    return controller.view;
}

-(NSString *)getCurrentDateTime:(NSString *)stringFormat{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:stringFormat];
    //用[NSDate date]可以获取系统当前时间
    return [dateFormatter stringFromDate:[NSDate date]];
}

/**
 *  获取图片名称
 *
 *  @param filePath 图片路径
 *
 *  @return 图片名称
 */
-(NSString *)getImageName:(NSString *)filePath{
    NSString *fileName;
    if (filePath != nil) {
        fileName = [[filePath componentsSeparatedByString:@"?id="] lastObject];
    }else{
        fileName = [NSString stringWithFormat:@"%@", [self getCurrentDateTime:@"yyyyMMhhmmss"]];
        fileName = [fileName stringByReplacingOccurrencesOfString:@":" withString:@""];
        NSLog(@"%@", fileName);
    }
    
    fileName = [NSString stringWithFormat:@"iOSPicture-%@.jpg", fileName];
    
    return fileName;
}

/**
 *  转换图片为NSData并压缩
 *
 *  @param image 图片
 *
 *  @return 压缩过后的文件数据
 */
-(NSData *)rarImage:(UIImage *)image{
    NSData *data;
    //判断图片是不是png格式的文件
    data = UIImageJPEGRepresentation(image, 1.0);
    NSLog(@"%lu", (unsigned long)data.length);
    if (data.length > 100*1024) {
        
        data = UIImageJPEGRepresentation(image, 100*1024.0 / data.length);
        NSLog(@"%lu", (unsigned long)data.length);
    }
    return data;
}

-(NSString *)appendStringArray:(NSArray *)stringArray seperatorString:(NSString *)seperatorString{
    NSString *resultString = [NSString new];
    
    for (int i = 0; i<stringArray.count; i++) {
        if (i == (stringArray.count - 1)) {
            resultString = [resultString stringByAppendingString:stringArray[i]];
        }else{
            resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"%@%@", stringArray[i], seperatorString]];
        }
    }
    return resultString;
    
}


@end
