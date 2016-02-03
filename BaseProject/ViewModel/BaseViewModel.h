//
//  BaseViewModel.h
//  BaseProject
//
//  Created by xf.wang on 15/10/21.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountDetailModel.h"

typedef void(^CompletionHandle)(NSError *error);

@protocol BaseViewModelDelegate <NSObject>

@optional
//获取更多
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle;
//刷新
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle;
//获取数据
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle;

@end

@interface BaseViewModel : NSObject<BaseViewModelDelegate>

@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) NSURLSessionDataTask *dataTask;
- (void)cancelTask;  //取消任务
- (void)suspendTask; //暂停任务
- (void)resumeTask;  //继续任务

-(void)saveAccountDetail:(NSDictionary *)accountDetailDic;
-(AccountDetailModel *)getAccountDetailFromLocal;

-(void)uploadImageWithUrl:(NSString *)imagePath serverPath:(NSString *)serverPath gxdw:(NSString *)gxdw userid:(NSString *)userid czmk:(NSString *)czmk;

-(void)uploadImageWithUrl:(NSString *)imagePath data:(NSData *)data serverPath:(NSString *)serverPath gxdw:(NSString *)gxdw userid:(NSString *)userid czmk:(NSString *)czmk;

-(void)uploadImageWithImageName:(NSString *)imageName data:(NSData *)data serverPath:(NSString *)serverPath gxdw:(NSString *)gxdw userid:(NSString *)userid czmk:(NSString *)czmk;

@end