//
//  CABasicAnimationVC.m
//  CAAnimation
//
//  Created by Rhino on 2017/7/14.
//  Copyright © 2017年 Rhino. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CABasicAnimationVC.h"

@interface CABasicAnimationVC()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation CABasicAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btn];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self positionAnimation];
    //    [self boundsAnimation];
    //    [self transfromAnimation];
}

- (void)positionAnimation{
    
    CABasicAnimation *basic = [CABasicAnimation animation];
//    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"position"];
    basic.keyPath = @"position";//bounds transform
    // fromValue | toValue 为id类型 不能接受结构体类型, 使用NSValue转化后进行使用
    //从哪里开始
    basic.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    //到指定的位置
    basic.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    //在当前指定的位置增加/减少
  //  basic.byValue = [NSValue valueWithCGPoint:CGPointMake(20, 20)];
    // 还可设置代理
    basic.delegate = self;
    // 动画所执行的时间
    basic.duration = 4.0;
    // 添加动画到layer层
    [self.btn.layer addAnimation:basic forKey:nil];
    // 这样做动画是可以完成很好的交互体验的, 但是此时btn的位置实际是没有放生变化的, 具体可以看图层
    NSLog(@"xxxx");//异步的
}


- (void)boundsAnimation{
    
    // 初始化
    CABasicAnimation *animate = [CABasicAnimation animation];
    // 执行位置动画
    animate.keyPath = @"bounds";
    animate.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 111, 111)];
    // 还可设置代理
    animate.delegate = self;
    // 动画所执行的时间
    animate.duration = 1.0;
    // 动画执行完毕之后不删除动画
    animate.removedOnCompletion = NO;
    // 设置保存动画的最新状态
    animate.fillMode = kCAFillModeForwards;
    // 添加动画到layer层
    [self.btn.layer addAnimation:animate forKey:nil];
}

- (void)transfromAnimation{
    
    CABasicAnimation *animate = [CABasicAnimation animation];
    // 以旋转的形式
    animate.keyPath = @"transform";
    animate.duration = 2.0;
    // CATransform3DMakeRotation这个方法会返回一个三维坐标的结构体
    // M_PI_2 == π / 2
    // CA_EXTERN CATransform3D CATransform3DMakeRotation (CGFloat angle, CGFloat x,CGFloat y, CGFloat z)
    // x, y, z angle为旋转角参数
    animate.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2 + M_PI_4, 1, 1, 1)];
    [self.btn.layer addAnimation:animate forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%f",self.btn.layer.bounds.size.width);
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 40, 40)];
        _btn.backgroundColor = [UIColor redColor];
    }
    return _btn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
