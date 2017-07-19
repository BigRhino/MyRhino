//
//  CAKeyframeAnimationVC.m
//  CAAnimation
//
//  Created by Rhino on 2017/7/14.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CAKeyframeAnimationVC.h"

#define angle2Radian(angle) ((angle) /180.0 *M_PI)

@interface CAKeyframeAnimationVC ()<CAAnimationDelegate>
@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIImageView *plane;

@end

@implementation CAKeyframeAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.plane];

}

//UIView keyFrame
- (void)planeKeyAnimation{
    
    CGPoint originalCenter = self.plane.center;
    
    [UIView animateKeyframesWithDuration:1.5 delay:0 options:0 animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.25 animations:^{
            CGPoint center = self.plane.center;
            center.x += 80.0;
            center.y -= 10.0;
            self.plane.center = center;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.40 animations:^{
            self.plane.transform =  CGAffineTransformRotate(self.plane.transform, -M_PI/8);//CGAffineTransform(rotationAngle: -.pi / 8);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            CGPoint center = self.plane.center;
            center.x += 100.0;
            center.y -= 50.0;
            self.plane.center = center;
            self.plane.alpha = 0.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.51 relativeDuration:0.11 animations:^{
            self.plane.transform = CGAffineTransformIdentity;
            self.plane.center = CGPointMake(0.0, originalCenter.y);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.45 animations:^{
            self.plane.alpha = 1.0;
            self.plane.center = originalCenter;
        }];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//     [self keyAnimation];
    [self planeKeyAnimation];
}
//图标抖动
- (void)sharkAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    
    animation.values = @[@(-angle2Radian(4)),@(angle2Radian(4)),@(-angle2Radian(4))];
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.3;
    
    [self.btn.layer addAnimation:animation forKey:@"key"];
    
}
- (void)keyAnimation{
    //关键帧动画
    CAKeyframeAnimation *keyAnimate = [CAKeyframeAnimation animation];
    keyAnimate.keyPath = @"position";
    // 初始化
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(200, 0)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(255, 255)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(0, 255)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(300, 600)];
    // 每一帧的位置
    keyAnimate.values = @[value1, value2 , value3, value4, value5];
//    keyAnimate.keyTimes = []; 0- 1之间
    
//    kCAAnimationLinear  默认 first:0.0 last 1.0
//    kCAAnimationDiscrete  first:0.0 last 1.0
//    kCAAnimationPaced     忽略
//    kCAAnimationCubic    first:0.0 last 1.0
//    kCAAnimationCubicPaced  忽略
//    keyAnimate.calculationMode
    // Timing function names.
    keyAnimate.duration = 5.0;
    
    CAMediaTimingFunction *caMediaTime1 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CAMediaTimingFunction *caMediaTime2 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CAMediaTimingFunction *caMediaTime3 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    CAMediaTimingFunction *caMediaTime4 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAMediaTimingFunction *caMediaTime5 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    keyAnimate.timingFunctions = @[caMediaTime1, caMediaTime2 , caMediaTime3, caMediaTime4, caMediaTime5];
    // 每一帧的百分比 这个不设置的情况下, 那么就是等分时长的
    keyAnimate.keyTimes = @[[NSNumber numberWithFloat:0.2], [NSNumber numberWithFloat:0.4], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:0.8], [NSNumber numberWithFloat:1]];
    [self.btn.layer addAnimation:keyAnimate forKey:nil];
    
}

- (void)keyframeAnimation{
    CAKeyframeAnimation *keyAnimate = [CAKeyframeAnimation animation];
    keyAnimate.keyPath = @"position";
    
    // 创建一条路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 0, 300, 300));
    keyAnimate.path = path;
    // 释放path
    CGPathRelease(path);
    
    keyAnimate.duration = 4.0;
    keyAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    keyAnimate.rotationMode = kCAAnimationRotateAuto;
    [self.btn.layer addAnimation:keyAnimate forKey:@"path"];
    /* 这个需要手动remove*/
    // [btn.layer removeAnimationForKey:@"path"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 40, 40)];
        _btn.backgroundColor = [UIColor redColor];
    }
    return _btn;
}
- (UIImageView *)plane{
    if (!_plane) {
        UIImage *image = [UIImage imageNamed:@"plane"];
        _plane = [[UIImageView alloc]initWithImage:image];
        _plane.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _plane.center = self.view.center;
    }
    return _plane;
}


@end
