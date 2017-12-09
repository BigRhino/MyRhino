//
//  RACMapViewController.m
//  RACDemo
//
//  Created by iMac on 2017/12/9.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACMapViewController.h"
#import <RACReturnSignal.h>

@interface RACMapViewController ()

@end

@implementation RACMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self mapDemo];
    
//    [self flattenMapDemo];
    
    [self flattenMapDemo2];
}

- (void)mapDemo{
    
    //1.创建信号
    RACSubject *signal = [RACSubject subject];
    
    //2.创建过滤信号
    RACSignal *mapSignal = [signal map:^id _Nullable(id  _Nullable value) {
        
        NSInteger newValue = [value integerValue];
        //对数据进行过滤
        return @(newValue + 5);
    }];
    
    //3.订阅过滤信号
    [mapSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    //4.发送数据
    [signal sendNext:@(1)];
}

- (void)flattenMapDemo{
    
    //1.创建信号
    RACSubject *signal = [RACSubject subject];
    
    //2.绑定信号
    RACSignal *flattenSignal = [signal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        
        NSLog(@"只要发送数据 就会执行这个block~~~");
        return [RACReturnSignal return:[NSString stringWithFormat:@"处理后的数据:%@",value]];
    }];
    
    //3.订阅信号
    [flattenSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到数据:%@",x);
    }];
    
    //4.发送数据
    [signal sendNext:@"hello rac!"];
}

- (void)flattenMapDemo2{
 //信号中的信号
    //1.创建信号中的信号
    RACSubject *signalOfSignals = [RACSubject subject];
    //作为被发送的信号
    RACSubject *signal = [RACSubject subject];
    
    //订阅信号
//    [[signalOfSignals flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//        NSLog(@"flattenMap:%@",value);
//        return value;
//    }]subscribeNext:^(id  _Nullable x) {
//        NSLog(@"subscribeNext:%@",x);
//    }];
    
    [signalOfSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"x:%@",x);
    }];
    
    [signalOfSignals sendNext:signal];
    
    [signal sendNext:@"****"];
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
