//
//  CaptureViewController.h
//  市场监管
//
//  Created by 网新中研 on 16/1/11.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "BaseViewController.h"

typedef void(^ScanFinishedBlock)(NSString *resultString);

@interface CaptureViewController : BaseViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic ) AVCaptureDevice            * device;
@property (strong,nonatomic ) AVCaptureDeviceInput       * input;
@property (strong,nonatomic ) AVCaptureMetadataOutput    * output;
@property (strong,nonatomic ) AVCaptureSession           * session;
@property (strong,nonatomic ) AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView                * line;

-(id)initCompleteHander:(ScanFinishedBlock) completeHandler;


@end
