//
//  CGBlendView.m
//  HeaderNote
//
//  Created by Rhino on 2017/7/26.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CGBlendView.h"

@implementation CGBlendView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _sourceColor = [UIColor whiteColor];
        _destinationColor = [UIColor blackColor];
        _blendMode = kCGBlendModeNormal;
    }
    return self;
}
//叠加的源颜色
- (void)setSourceColor:(UIColor *)sourceColor{
    if (_sourceColor != sourceColor) {
        _sourceColor = sourceColor;
        //重绘
        [self setNeedsDisplay];
    }
}
//叠加的目标颜色
- (void)setDestinationColor:(UIColor *)destinationColor{
    if (_destinationColor != destinationColor) {
        _destinationColor = destinationColor;
        [self setNeedsDisplay];
    }
}
- (void)setBlendMode:(CGBlendMode)blendMode{
    if (_blendMode != blendMode) {
        _blendMode = blendMode;
        [self setNeedsDisplay];
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置填充颜色
    CGContextSetGrayFillColor(ctx, 0.2, 1.0);
    //填充该控件的北京
    CGContextFillRect(ctx, self.bounds);
    
    //混合模式,表示直接将改颜色绘制在背景上,不使用任何混合模式
    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    
    //用叠加的目标颜色绘制矩形区域
    CGContextSetFillColorWithColor(ctx, self.destinationColor.CGColor);
    CGContextFillRect(ctx, CGRectMake(110, 20, 100, 100));
    //设置混合模式
    CGContextSetBlendMode(ctx, self.blendMode);
    
    //用叠加的源颜色绘制矩形区域
    CGContextSetFillColorWithColor(ctx, self.sourceColor.CGColor);
    CGContextFillRect(ctx, CGRectMake(60, 45, 200, 50));
    
}


@end
