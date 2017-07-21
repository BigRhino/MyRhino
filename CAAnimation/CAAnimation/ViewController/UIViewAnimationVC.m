//
//  UIViewAnimationVC.m
//  CAAnimation
//
//  Created by Rhino on 2017/7/14.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "UIViewAnimationVC.h"

@interface UIViewAnimationVC ()
@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation UIViewAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.view addSubview:self.testView];
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.contentView.backgroundColor = [UIColor blackColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [UIView animateWithDuration:3 delay:1 usingSpringWithDamping:0.1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.testView.frame  = CGRectMake(300,100, 50, 50);
//    } completion:^(BOOL finished) {
//
//    }];
    
//    [UIView transitionWithView:self.testView duration:2 options:UIViewAnimationOptionCurveLinear animations:^{
//
//        self.testView.backgroundColor = [UIColor redColor];
//        self.testView.frame = CGRectMake(100, 100, 100, 100);
//    } completion:^(BOOL finished) {
//
//    }];
//    NSLog(@"%@:::::\n",self.view.subviews);
//
//    [UIView transitionFromView:self.testView toView:self.contentView duration:2 options:UIViewAnimationOptionTransitionFlipFromBottom|UIViewAnimationOptionCurveEaseIn completion:^(BOOL finished) {
//        NSLog(@"%@",self.view.subviews);
//    }];
    
    [UIView performSystemAnimation:UISystemAnimationDelete onViews:self.view.subviews options:0 animations:^{
        
        self.testView.backgroundColor = [UIColor blueColor];
    } completion:^(BOOL finished) {
        
    }];
}

- (UIView *)testView{
    if (!_testView) {
        _testView = [[UIView alloc]initWithFrame:CGRectMake(20, 100, 50, 50)];
        _testView.backgroundColor = [UIColor greenColor];
        
    }
    return _testView;
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
