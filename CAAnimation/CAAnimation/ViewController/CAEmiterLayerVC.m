//
//  CAEmiterLayerVC.m
//  CAAnimation
//
//  Created by Rhino on 2017/7/15.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CAEmiterLayerVC.h"

@interface CAEmiterLayerVC ()

@end

/*
 CAEmitterLayer(iOS_5)是一个高性能的粒子引擎,用来创建复杂的粒子动画.如:烟雾,火,雨等效果,并且很好的控制了性能.
 是CAEmitterCell的容器,CAEmitterCell定义了粒子效果,其为不同的粒子效果定义一个或多个CAEmitterCell作为模板,同时负责基于这些模板实例化一个
 粒子流,一个CAEmitterCell类似于CAEmitterLayer类似于一个CALayer,他有一个contents属性,可以定义为一个CGImage,还有一些可以设置属性控制表现和行为.
 */
//发射源坐标,是一个空间坐标,是可以Animatable(CoreAnimation移动发射源位置(keyPath))
//@property CGPoint emitterPosition;
//@property CGFloat emitterZPosition;


//发射源大小,宽高,纵向深度,可能因为设置emitterShape属性而被忽略.
//@property CGPoint emitterPosition;
//@property CGFloat emitterZPosition;


@implementation CAEmiterLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLayer];
}



- (void)createLayer{
    
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    
    //发射源的坐标
    layer.emitterPosition = CGPointMake(self.view.bounds.size.width/2.0, -30);
    //发射源的大小
    layer.emitterSize = CGSizeMake(self.view.bounds.size.width/2.0, 0);
    //发射源的形状 kCAEmitterLayerLine从线上的每一个点发射 类似瀑布,下雪
    layer.emitterShape = kCAEmitterLayerLine;
    //发射源的发射模式 kCAEmitterLayerOutline表示向外围扩散
    layer.emitterMode = kCAEmitterLayerOutline;
    
    
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    snowflake.name = @"snow";
    //每秒生成多少个粒子
    snowflake.birthRate = 1.0;
    
    snowflake.lifetime = 120.0;
    
    snowflake.velocity = -10;
    snowflake.velocityRange = 10;
    
    snowflake.yAcceleration = 12;
    snowflake.emissionRange = 0.5 * M_PI;
    snowflake.spinRange = 0.25 * M_PI;
    
    snowflake.contents = (id)([UIImage imageNamed:@"snow"].CGImage);
    snowflake.color = [UIColor colorWithRed:0.6 green:0.658 blue:0.743 alpha:1].CGColor;
    
    
    layer.shadowOpacity = 1.0;
    layer.shadowRadius = 0.0;
    layer.shadowOffset = CGSizeMake(0.0, 1.0);
    layer.shadowColor = [UIColor whiteColor].CGColor;
    
    layer.emitterCells = @[snowflake];
    [self.view.layer insertSublayer:layer atIndex:0];
   
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

@end
