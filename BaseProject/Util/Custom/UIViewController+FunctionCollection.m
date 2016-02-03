//
//  UIViewController+FunctionCollection.m
//  市场监管
//
//  Created by 网新中研 on 16/1/11.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "UIViewController+FunctionCollection.h"

@implementation UIViewController (FunctionCollection)


-(void)popShow:(UIView *)view{
    //Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,
                                               KLCPopupVerticalLayoutCenter);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:view
                                            showType:KLCPopupShowTypeBounceInFromBottom
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
}

-(void)showFunctionGroup:(NSArray *)subFunctions{
    // Generate content view to present
    UIView* contentView = [[UIView alloc] init];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    contentView.backgroundColor = [UIColor blueColor];
    contentView.layer.cornerRadius = 12.0;
    contentView.frame = CGRectMake(0, 0, 100, 100);
    
    //弹出窗背景
    UIView *backGroundView = [UIView new];
    backGroundView.frame = CGRectMake(0, 0, kWindowH / 4 * 3, 100);
    
    //Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,
                                               KLCPopupVerticalLayoutCenter);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeBounceInFromBottom
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
}

@end
