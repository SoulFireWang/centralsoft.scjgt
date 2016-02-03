//
//  DashedLine.h
//  市场监管
//
//  Created by 网新中研 on 16/1/6.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "BaseView.h"

/**
 *  虚线
 */
@interface DashedLine : BaseView
@property(nonatomic)CGPoint startPoint;//虚线起点
@property(nonatomic)CGPoint endPoint;//虚线终点
@property(nonatomic,strong)UIColor* lineColor;//虚线颜色

+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end
