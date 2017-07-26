//
//  SegementViewController.m
//  HeaderNote
//
//  Created by Rhino on 2017/7/24.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "SegementViewController.h"

@interface SegementViewController ()
@property (nonatomic, strong) UISegmentedControl *control;
@property (nonatomic, strong) UISlider *slider;
@end

@implementation SegementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{

    self.control = [[UISegmentedControl alloc]initWithItems:@[@"新闻",@"大保健++",@"段子",@"火星撞地球"]];
    self.control.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 40);
    [self.view addSubview:self.control];
    
    //选中效果
//    self.control.momentary = YES;
    //自适应内容宽度
    self.control.apportionsSegmentWidthsByContent = YES;
    [self.control setDividerImage:[UIImage imageNamed:@"1"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    
    
    
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.control.frame) + 50, CGRectGetWidth(self.control.frame), 40)];
    [self.view addSubview:self.slider];
    
    
    
    [self.slider setMaximumTrackTintColor:[UIColor redColor]];
    [self.slider setMinimumTrackTintColor:[UIColor blueColor]];
    [self.slider setThumbTintColor:[UIColor greenColor]];
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
