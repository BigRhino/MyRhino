//
//  RACMulticastConnection.m
//  RACDemo
//
//  Created by iMac on 2017/11/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACMulticastConnectionVC.h"

@interface RACMulticastConnectionVC ()

@property(nonatomic, assign) NSInteger count;
@property(nonatomic, assign) NSInteger count1;


@end

@implementation RACMulticastConnectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
    [self test1];
}

- (void)test{
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%ld",++_count);
        
        [subscriber sendNext:@"``````````"];
        
        return nil;
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
}

- (void)test1{

    ///使用RACMulticastConnection，无论有多少个订阅者，无论订阅多少次，我只发送一个。
    // 1.发送请求，用一个信号内包装，不管有多少个订阅者，只想发一次请求
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%ld",++_count1);
        
        [subscriber sendNext:@"!!!!!!!!!!"];
        
        return nil;
    }];
    //创建连接
    RACMulticastConnection *oneSignal = [signal publish];
    
    [oneSignal.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [oneSignal.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [oneSignal.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    //!!!!链接
    [oneSignal connect];
    
    
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
