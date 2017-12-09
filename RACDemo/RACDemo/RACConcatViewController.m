//
//  RACConcatViewController.m
//  RACDemo
//
//  Created by iMac on 2017/12/9.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACConcatViewController.h"

@interface RACConcatViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation RACConcatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //reduceBlock参数:根据组合的信号关联的  必须 一一对应!!
    RACSignal *loginSignal = [RACSignal combineLatest:@[_accountTF.rac_textSignal,_passwordTF.rac_textSignal] reduce:^id _Nullable(NSString *account,NSString *password){
        return @(account.length >10 && password.length > 5);
    }];
    RAC(_loginBtn,enabled) = loginSignal;
    //订阅组合信号
//    [loginSignal subscribeNext:^(id  _Nullable x) {
//        _loginBtn.enabled = [x boolValue];
//    }];
}

//zipWith:把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元祖，才会触发压缩流的next事件。
- (IBAction)zipClick:(id)sender {
    
    //1.创建信号
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    //2.压缩信号
    //只有当两个信号同时发送信号的时候,将数据包装成元组发送给订阅者(A,B)
    RACSignal *zipSignal = [signalA zipWith:signalB];
    
    //和发送信号的顺序无关
    // **-zipWith-**: 当一个界面多个请求的时候，要等所有请求完成才更新UI
    // 等所有信号都发送内容的时候才会调用
    [zipSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    // 发送信号 交互顺序，元组内元素的顺序不会变，跟发送的顺序无关，而是跟压缩的顺序有关[signalA zipWith:signalB]---先是A后是B
    //(A,B)
    [signalA sendNext:@"A"];
    [signalB sendNext:@"B"];
    
    //(A1,B1)
    [signalB sendNext:@"B1"];
    [signalA sendNext:@"A1"];
    
    //(A2,B2)
    [signalB sendNext:@"B2"];
    [signalB sendNext:@"B3"];
    [signalA sendNext:@"A2"];
    [signalA sendNext:@"A3"]; //(A3,B3)
    
    [signalA sendNext:@"A4"];
    [signalB sendNext:@"B4"]; //(A4,B4)
}

//使用需求：有两部分数据：想让上部分先进行网络请求但是过滤掉数据，然后进行下部分的，拿到下部分数据
- (IBAction)thenClick:(id)sender {
    
    //创建信号!!
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求A");
        //发送数据
        [subscriber sendNext:@"数据A"];
        //必须发送完成
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求B");
        //发送数据
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    //then:忽略掉第一个信号所有的值!!
    RACSignal * thenSignal = [signalA then:^RACSignal * _Nonnull{
        return signalB;
    }];
    
    //订阅信号
    [thenSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

// 任何一个信号请求完成都会被订阅到
- (IBAction)mergeClick:(id)sender {
    //创建信号
    RACSubject * signalA = [RACSubject subject];
    RACSubject * signalB = [RACSubject subject];
    RACSubject * signalC = [RACSubject subject];
    
    
    //组合信号
    //    RACSignal * mergeSignal = [signalA merge:signalB];
    RACSignal * mergeSignal = [RACSignal merge:@[signalA,signalB,signalC]];
    
    //订阅 -- 根据发送的情况接受数据!!
    [mergeSignal subscribeNext:^(id  _Nullable x) {
        //任意一个信号发送内容就会来执行这个Block
        NSLog(@"%@",x);
    }];
    
    //发送数据
    [signalB sendNext:@"数据B"];
    [signalC sendNext:@"数据C"];
    [signalA sendNext:@"数据A"];
    
    
}

//按顺序执行,只有前一个signal发送完成,下一个信号才会收到信号
- (IBAction)Concat:(id)sender {
    //组合!! 按顺序去执行,可以用于串行执行任务
    //创建信号!!
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求A");
        //发送数据
        [subscriber sendNext:@"数据A"];
        //哥么结束了!!
        [subscriber sendCompleted];
        //        [subscriber sendError:nil]; 这哥么不行!
        
        return nil;
    }];
    
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求B");
        //发送数据
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal * signalC = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求C");
        //发送数据
        [subscriber sendNext:@"数据C"];
        
        return nil;
    }];
    
    //concat:按顺序组合!!
    //创建组合信号!!
    //    RACSignal * concatSignal = [[signalA concat:signalB] concat:signalC];
    
    RACSignal * concatSignal = [RACSignal concat:@[signalA,signalB,signalC]];
    
    //订阅组合信号
    [concatSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
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
