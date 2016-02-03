//
//  SFToastView.m
//  市场监管
//
//  Created by 网新中研 on 15/12/31.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import "SFToastView.h"

@implementation SFToastView

+(void)showWithSuperView:(UIView *)superView title:(NSString *)titile{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    hud.mode           = MBProgressHUDModeCustomView;
    hud.labelText      = titile;
    hud.margin         = 10;
    hud.labelFont      = [hud.labelFont fontWithSize:15.0];
    hud.opacity        = 0.65;
    hud.cornerRadius   = 7;
    hud.animationType  = MBProgressHUDAnimationZoom;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:TOAST_SHOW_INTERVAL];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:superView animated:YES];
        });
    });
}



@end
