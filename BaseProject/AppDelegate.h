//
//  AppDelegate.h
//  BaseProject
//
//  Created by xf.wang on 15/10/21.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,getter=isOnLine) BOOL onLine; //网络状态
@end

