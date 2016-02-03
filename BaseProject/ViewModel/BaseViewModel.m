//
//  BaseViewModel.m
//  BaseProject
//
//  Created by xf.wang on 15/10/21.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (void)cancelTask{
    [self.dataTask cancel];
}

- (void)suspendTask{
    [self.dataTask suspend];
}

- (void)resumeTask{
    [self.dataTask resume];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

-(void)saveAccountDetail:(NSDictionary *)accountDetailDic{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:accountDetailDic forKey:@"accountDetail"];
}

-(AccountDetailModel *)getAccountDetailFromLocal{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *accountDetailDic = [userDefaults objectForKey:@"accountDetail"];
    AccountDetailModel *accountDetail = [AccountDetailModel mj_objectWithKeyValues:accountDetailDic];
    return accountDetail;
}

-(void)uploadImageWithUrl:(NSString *)imagePath serverPath:(NSString *)serverPath gxdw:(NSString *)gxdw userid:(NSString *)userid czmk:(NSString *)czmk{
    
    NSString *urlString = [NSString stringWithFormat:@"%@/androidUpload?gxdw=%@&userid=%@&czmk=%@", serverPath, gxdw, userid, czmk];
    NSLog(@"%@", imagePath);
    NSString *fileName = [[imagePath componentsSeparatedByString:@"?id="] lastObject];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {                   
//        [formData appendPartWithFileURL:[NSURL URLWithString:imagePath] name:@"file1" fileName:fileName mimeType:@"image/jpeg" error:nil];
        
        [formData appendPartWithFileData:nil name:@"file1"
                                fileName:[NSString stringWithFormat:@"%@.png", fileName]
                                        mimeType:@"image/jpeg" ];
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                  }];
    [uploadTask resume];
    
}

-(void)uploadImageWithUrl:(NSString *)imagePath data:(NSData *)data serverPath:(NSString *)serverPath gxdw:(NSString *)gxdw userid:(NSString *)userid czmk:(NSString *)czmk{
    NSString *urlString = [NSString stringWithFormat:@"%@/androidUpload?gxdw=%@&userid=%@&czmk=%@", serverPath, gxdw, userid, czmk];
    NSLog(@"%@", urlString);
    NSString *fileName = [[imagePath componentsSeparatedByString:@"?id="] lastObject];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //        [formData appendPartWithFileURL:[NSURL URLWithString:imagePath] name:@"file1" fileName:fileName mimeType:@"image/jpeg" error:nil];
        
        [formData appendPartWithFileData:data name:@"file1"
                                fileName:[NSString stringWithFormat:@"%@.png", fileName]
                                mimeType:@"image/jpge,image/gif,image/jpeg,imagepeg,imagepeg" ];
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                  }];
    [uploadTask resume];
}


-(void)uploadImageWithImageName:(NSString *)imageName data:(NSData *)data serverPath:(NSString *)serverPath gxdw:(NSString *)gxdw userid:(NSString *)userid czmk:(NSString *)czmk{
    NSString *urlString = [NSString stringWithFormat:@"%@/androidUpload?gxdw=%@&userid=%@&czmk=%@", serverPath, gxdw, userid, czmk];
    NSLog(@"%@", urlString);
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //        [formData appendPartWithFileURL:[NSURL URLWithString:imagePath] name:@"file1" fileName:fileName mimeType:@"image/jpeg" error:nil];
        
        [formData appendPartWithFileData:data name:@"file1"
                                fileName:imageName
                                mimeType:@"image/jpge,image/gif,image/jpeg,imagepeg,imagepeg" ];
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                  }];
    [uploadTask resume];
}


@end
