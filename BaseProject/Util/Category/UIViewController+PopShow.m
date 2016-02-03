//
//  UIViewController+FunctionCollection.m
//  市场监管
//
//  Created by 网新中研 on 16/1/11.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "UIViewController+PopShow.h"

@implementation UIViewController (PopShow)


-(KLCPopup *)popShow:(UIView *)view{
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
    
    return popup;
}

@end
