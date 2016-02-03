//
//  AppDelegate.m
//  BaseProject
//
//  Created by xf.wang on 15/10/21.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Category.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "SingatureViewController.h"
#import "SCRecorderViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initializeWithApplication:application];
    [self test];

    return YES;
}

-(void)test{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *navigationController = [UINavigationController new];
    navigationController.viewControllers = @[[LoginViewController new]];
    
    
    self.window.rootViewController = navigationController;
}



@end
