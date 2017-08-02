//
//  ViewController.m
//  VideoToolBox
//
//  Created by Rhino on 2017/7/8.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "ViewController.h"
#import "VideoCaptuer.h"

@interface ViewController ()

@property (nonatomic, strong) VideoCaptuer *capture;
@property (nonatomic, strong) UILabel *mLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    
    self.mLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 100)];
    self.mLabel.textColor = [UIColor redColor];
    [self.view addSubview:self.mLabel];
    self.mLabel.text = @"测试H264硬编码";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 100, 100)];
    [button setTitle:@"play" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClick:(UIButton *)button {
    [self.capture startCapturing:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (VideoCaptuer *)capture {
    if (!_capture) {
        _capture = [[VideoCaptuer alloc]init];
    }
    return _capture;
}
@end
