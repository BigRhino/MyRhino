//
//  CGTranslateView.m
//  HeaderNote
//
//  Created by Rhino on 2017/7/26.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CGTranslateView.h"
#import <CoreGraphics/CoreGraphics.h>


@implementation CGTranslateView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 0.3);
    //坐标系统平移
    CGContextTranslateCTM(ctx, -40, 200);
    
    for (int i = 0; i < 50; i++) {
        //平移
        CGContextTranslateCTM(ctx, 50, 50);
        //缩放
        CGContextScaleCTM(ctx, 0.93, 0.93);
        //旋转
        CGContextRotateCTM(ctx, -M_PI/10);
        CGContextFillRect(ctx, CGRectMake(0, 0, 150, 75));
    }
}



@end
