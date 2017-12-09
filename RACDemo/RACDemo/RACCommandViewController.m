//
//  RACCommandViewController.m
//  RACDemo
//
//  Created by iMac on 2017/11/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACCommandViewController.h"

@interface RACCommandViewController ()

@end

@implementation RACCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test3];
//    [self test4];
    [self test5];
}

- (void)test{
    
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //执行命令的时候调用
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
           
            [subscriber sendNext:@"NEXT"];
            
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                
                NSLog(@"disposable~");
            }];
            
        }];
        
    }];
    
    RACSignal *signal = [command execute:@"123"];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error");
    } completed:^{
        NSLog(@"signal:complete!~~");
    }];
    
}
- (void)test1{
    
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //执行命令的时候调用
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"NEXT"];
                [subscriber sendCompleted];
            });
            
            
            return [RACDisposable disposableWithBlock:^{
                
                NSLog(@"disposable~");
            }];
            
        }];
        
    }];
    
    RACSignal *signal = [command execute:@"123"];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error");
    } completed:^{
        NSLog(@"signal:complete!~~");
    }];
    
    
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"c:::%@",x);
        //0 表示没有执行或者执行完成
        //1 表示正在执行
    } error:^(NSError * _Nullable error) {
        NSLog(@"c:::error");
    } completed:^{
        NSLog(@"c:::completed~");
    }];
    
}

// 高级做法
- (void)test3 {
    
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block调用：执行命令的时候就会调用
        NSLog(@"%@", input);
        // 这里的返回值不允许为nil
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"发送信号"];
            [subscriber sendNext:@"发送信号1"];
            return nil;
        }];
    }];
    

    // 方式三
    // switchToLatest获取最新发送的信号，只能用于信号中信号。
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"~%@", x);
    }];

    // 2.执行命令
    RACSignal *s = [command execute:@3];
    [s subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@**",x);
    }];
    
    
    
}

- (void)test4{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 30);
    btn.center = self.view.center;
    
    [btn setTitle:@"button" forState:UIControlStateNormal];
    [btn setTitle:@"ssssss" forState:UIControlStateHighlighted];
    [btn setTitle:@"******" forState:UIControlStateSelected];
    [btn setTitle:@"``````" forState:UIControlStateDisabled];
    
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    //当点击按钮时,按钮为disable状态,直至send Completed
    btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
      
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"ssss"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    [btn.rac_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"x:%@",x);
    }];
    
    
}

- (void)test5{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 30);
    btn.center = self.view.center;
    
    [btn setTitle:@"Normal" forState:UIControlStateNormal];
    [btn setTitle:@"Highlighted" forState:UIControlStateHighlighted];
    [btn setTitle:@"Selected" forState:UIControlStateSelected];
    [btn setTitle:@"Disabled" forState:UIControlStateDisabled];
    
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    
    RACSubject *enableSignal = [RACSubject subject];
    
    //当点击按钮时,按钮为disable状态,直至send Completed
    btn.rac_command = [[RACCommand alloc]initWithEnabled:enableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"QWW"];
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
    
    
    //第一次会执行
    [[btn.rac_command.executing skip:1]subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"####%@",x);
        BOOL executing = [x boolValue];
        [enableSignal sendNext:@(!executing)];
    }];
    
    
    [btn.rac_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"~~:%@",x);
    }];
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
