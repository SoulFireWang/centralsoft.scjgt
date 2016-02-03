//
//  DashedLine.m
//  市场监管
//
//  Created by 网新中研 on 16/1/6.
//  Copyright © 2016年 centralsoft. All rights reserved.
//

#import "DashedLine.h"

@interface DashedLine()

@end

@implementation DashedLine

+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    CGContextSetLineWidth(context,0.5);//线宽度
    
    CGContextSetStrokeColorWithColor(context,self.lineColor.CGColor);
    
    CGFloat lengths[] = {4,2};//先画4个点再画2个点
    
    CGContextSetLineDash(context,0, lengths,2);//注意2(count)的值等于lengths数组的长度
    
    CGContextMoveToPoint(context,self.startPoint.x,self.startPoint.y);
    
    CGContextAddLineToPoint(context,self.endPoint.x,self.endPoint.y);
    
    CGContextStrokePath(context);
    
    CGContextClosePath(context);
}

@end
