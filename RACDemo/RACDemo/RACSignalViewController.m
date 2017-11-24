//
//  RACSignalViewController.m
//  RACDemo
//
//  Created by iMac on 2017/11/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACSignalViewController.h"

@interface RACSignalViewController ()

@property(nonatomic, assign) NSInteger count;
@property(nonatomic, strong) RACSignal *signals;
@property(nonatomic, strong) RACDisposable *disposable;


@end

@implementation RACSignalViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self test];
}

- (void)test{
    
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //副作用 多个订阅者这个block会多次调用
        [self add:__LINE__];
        
        [subscriber sendNext:@"NEXT"];
        
        [subscriber sendNext:@"YES"];
        
        //发送error complete只有一个,然后会执行取消订阅
       // [subscriber sendError:nil];
       // [subscriber sendCompleted];
       // [subscriber sendNext:@"🔍"];
        
        
        //当没有信号自动会取消,或者发送error,complete信号
        return [RACDisposable disposableWithBlock:^{
            
            NSLog(@"取消订阅~");
            
        }];
        
    }];
    
    //冷信号,只有当有订阅者才会调用,不能发送信号

    
    [signal subscribeNext:^(id  _Nullable x) {
        [self add:__LINE__];
        NSLog(@"%@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error");
    } completed:^{
        NSLog(@"complete");
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        [self add:__LINE__];
        NSLog(@"%@",x);
    }];
    
    
}

- (void)add:(int)line{
    self.count++;
    NSLog(@"%d:%ld",line,self.count);
}


/**
 *  RACSignal总结：
 一.核心：
 1.核心：信号类
 2.信号类的作用：只要有数据改变就会把数据包装成信号传递出去
 3.只要有数据改变就会有信号发出
 4.数据发出，并不是信号类发出，信号类不能发送数据
 一.使用方法：
 1.创建信号
 2.订阅信号
 二.实现思路：
 1.当一个信号被订阅，创建订阅者，并把nextBlock保存到订阅者里面。
 2.创建的时候会返回 [RACDynamicSignal createSignal:didSubscribe];
 3.调用RACDynamicSignal的didSubscribe
 4.发送信号[subscriber sendNext:value];
 5.拿到订阅者的nextBlock调用
 */




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
