//
//  RACIgnoreViewController.m
//  RACDemo
//
//  Created by iMac on 2017/12/9.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACIgnoreViewController.h"

@interface RACIgnoreViewController ()

@end

@implementation RACIgnoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self skipDemo];
//    [self distinctUntilDemo];
    
//    [self ignoreDemo];
//    [self takeDemo];

//    [self takeLastDemo];
    
//    [self takeUntilDemo];
    [self fifterDemo];
    
}

//跳跃信号
- (void)skipDemo{
    //跳跃几个值
    
    //1.创建信号
    RACSubject *signal = [RACSubject subject];
    
    //2.跳过一个信号,订阅信号
    [[signal skip:1]subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //3.发送数据
    [signal sendNext:@(1)];
    [signal sendNext:@(2)];
    [signal sendNext:@(3)];
    
}

//忽略重复信号
- (void)distinctUntilDemo{
    
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    //2.忽略掉重复的信号 进行订阅
    [[subject distinctUntilChanged]subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //3.发送数据
    [subject sendNext:@(1)];
    [subject sendNext:@(1)];
    [subject sendNext:@(2)];
    [subject sendNext:@(1)];
    [subject sendNext:@(2)];
    [subject sendNext:@(3)];
    
}

//忽略指定的数据
- (void)ignoreDemo{
    
    //1.创建信号
    RACSubject *signal = [RACSubject subject];
    
    //2.指定忽略的数据 并进行订阅
    RACSignal *ignoreSignal = [[signal ignore:@(2)] ignore:@(3)];
    [ignoreSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //3.发送数据
    [signal sendNext:@(2)];
    [signal sendNext:@(5)];
    [signal sendNext:@(4)];
    [signal sendNext:@(3)];

}

//获取前几条数据
- (void)takeDemo{
    
    //1.创建信号
    RACSubject *signal = [RACSubject subject];
    
    //2.订阅信号 获取前面三次的数据
    [[signal take:3] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //3.发送数据
    [signal sendNext:@(1)];
    [signal sendNext:@(2)];
    [signal sendNext:@(3)];
    [signal sendNext:@(4)];
    [signal sendNext:@(5)];
    
}

//获取后几条数据
- (void)takeLastDemo{
    //1.创建信号
    RACSubject *signal = [RACSubject subject];
    
    //2.订阅信号 获取后面两条的数据
    [[signal takeLast:2]subscribeNext:^(id  _Nullable x) {
         NSLog(@"%@",x);
    }];
    
    //3.发送数据
    [signal sendNext:@(1)];
    [signal sendNext:@(2)];
    [signal sendNext:@(3)];
    [signal sendNext:@(4)];
    [signal sendNext:@(5)];
    //必须发送完成
    [signal sendCompleted];
    
}

//标记信号 takeUntil:---给takeUntil传的是哪个信号，那么当这个信号发送信号或sendCompleted，就不能再接受源信号的内容了。
- (void)takeUntilDemo{
    //1.创建信号
    RACSubject *signal = [RACSubject subject];
    //标记信号
    RACSubject *enableSignal = [RACSubject subject];
    
    //2.订阅信号 直到标记信号发送数据的时候结束
    [[signal takeUntil:enableSignal]subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //3.发送数据
    [signal sendNext:@(1)];
    [signal sendNext:@(2)];
    
    [enableSignal sendNext:@(9)];
    
    [signal sendNext:@(4)];
    [signal sendNext:@(5)];
}

//过滤信号
- (void)fifterDemo{
    
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    //2.对信号进行过滤,只有满足条件的才会被订阅者收到
    [[subject filter:^BOOL(id  _Nullable value) {
      
        NSString *string = value;
        return string.length > 5;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    //3.发送信号
    [subject sendNext:@"1232"];
    [subject sendNext:@"121212121"];
    
    
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
