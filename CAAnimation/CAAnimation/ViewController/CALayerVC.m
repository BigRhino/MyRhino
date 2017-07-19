//
//  CALayerVC.m
//  CAAnimation
//
//  Created by Rhino on 2017/7/14.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CALayerVC.h"
//“ Presentation Layer 的属性会随着动画的进度实时改变，而 Model Layer 中对应的属性则并不会改变”

//Animatable 都可以作为 CAAnimation 的 keyPath

/**
kCAFillModeRemoved 这个是默认值，也就是说当动画开始前和动画结束后，动画对layer都没有影响，动画结束后，layer会恢复到之前的状态。
kCAFillModeForwards 当动画结束后，layer会一直保持着动画最后的状态。
kCAFillModeBackwards 这个和 kCAFillModeForwards 是相对的，就是在动画开始前，你只要将动画加入了一个layer，layer便立即进入动画的初始状态并等待动画开始。你可以这样设定测试代码，将一个动画加入一个layer的时候延迟5秒执行。然后就会发现在动画没有开始的时候，只要动画被加入了 layer , layer 便处于动画初始状态， 动画结束后，layer 也会恢复到之前的状态。
 kCAFillModeBoth 这个其实就是上面两个的合成。动画加入后立即开始，layer便处于动画初始状态，动画结束后layer保持动画最后的状态。
 */
@interface CALayerVC ()

@end

@implementation CALayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor greenColor].CGColor;
    layer.frame = CGRectMake(20, 100, 50, 50);
    [self.view.layer addSublayer:layer];
       
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
