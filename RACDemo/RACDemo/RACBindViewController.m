//
//  RACBindViewController.m
//  RACDemo
//
//  Created by iMac on 2017/11/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACBindViewController.h"
#import <RACReturnSignal.h>

@interface RACBindViewController ()

@end

@implementation RACBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindDemo];
}

//typedef RACSignal * _Nullable (^RACSignalBindBlock)(ValueType _Nullable value, BOOL *stop);
//可以用于处理字典转模型
//绑定信号,拦截信号的数据进行处理
- (void)bindDemo{

    //1.创建信号
    RACSubject *signal = [RACSubject subject];
    
    //2.绑定信号
    RACSignal *bindSignal = [signal bind:^RACSignalBindBlock _Nonnull{
        
        //当有订阅者订阅这个信号时执行这个block
        NSLog(@"__has subscribe this bindSignal!__");
        
        return ^RACSignal * (id value,BOOL *stop){
          
            //只要源信号发送数据,就会调用这个block,处理源信号发送的内容(value)
            NSLog(@"__bind's signal send data!__\n%@",value);
            //返回信号,不能返回nil
            //如果需要传空 可以返回空信号 [RACSignal empty] or [[RACSignal alloc]init]
            return [RACReturnSignal return:[NSString stringWithFormat:@"changed:%@",value]];
        };
    }];
    
    //3.订阅信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"__%@__",x);
    }];
    
    //4.发送信号
    [signal sendNext:@"json"];
    
//    [signal sendCompleted];
//
//    [signal sendNext:@"json"];
    
}

/*
 - (RACSignal *)bind:(RACSignalBindBlock (^)(void))block {
 NSCParameterAssert(block != NULL);
 

 * -bind: should:
 *
 * 1. Subscribe to the original signal of values.
 * 2. Any time the original signal sends a value, transform it using the binding block.
 * 3. If the binding block returns a signal, subscribe to it, and pass all of its values through to the subscriber as they're received.
 * 4. If the binding block asks the bind to terminate, complete the _original_ signal.
 * 5. When _all_ signals complete, send completed to the subscriber.
 *
 * If any signal sends an error at any point, send that to the subscriber.
 1.creat了一个新的signal。所有的操作都是在这个创建的过程中。
 2.是一个complete的block。 这里维护了一个锁（原子操作的互斥锁）。
 3.是一个addSignal的block。在block内部会订阅参数传进来的signal。
 4.在这个@autoreleasepool中，会订阅原始的signal。在订阅的过程中，如果bindingBlock返回了一个signal，进入（3）的addSignal的block。如果bindingBlock要stop绑定，则进入（2）complete的Block。
 

    return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
    
    //
    RACSignalBindBlock bindingBlock = block();
    
    __block volatile int32_t signalCount = 1;   // indicates self
    
    RACCompoundDisposable *compoundDisposable = [RACCompoundDisposable compoundDisposable];
    
    void (^completeSignal)(RACDisposable *) = ^(RACDisposable *finishedDisposable) {
        
        //锁
        if (OSAtomicDecrement32Barrier(&signalCount) == 0) {
            [subscriber sendCompleted];
            [compoundDisposable dispose];
        } else {
            [compoundDisposable removeDisposable:finishedDisposable];
        }
    };
    
    void (^addSignal)(RACSignal *) = ^(RACSignal *signal) {
        OSAtomicIncrement32Barrier(&signalCount);
        
        RACSerialDisposable *selfDisposable = [[RACSerialDisposable alloc] init];
        [compoundDisposable addDisposable:selfDisposable];
        //订阅传过来的signal
        RACDisposable *disposable = [signal subscribeNext:^(id x) {
            [subscriber sendNext:x];
        } error:^(NSError *error) {
            [compoundDisposable dispose];
            [subscriber sendError:error];
        } completed:^{
            @autoreleasepool {
                completeSignal(selfDisposable);
            }
        }];
        
        selfDisposable.disposable = disposable;
    };
    
    @autoreleasepool {
        RACSerialDisposable *selfDisposable = [[RACSerialDisposable alloc] init];
        [compoundDisposable addDisposable:selfDisposable];
        
        //订阅源信号,如果bindBlock返回了一个信号,执行addSignal,如果没有返回信号,或者stop = NO(终止订阅)则执行completeSignal
        RACDisposable *bindingDisposable = [self subscribeNext:^(id x) {
            // Manually check disposal to handle synchronous errors.
            if (compoundDisposable.disposed) return;
            
            BOOL stop = NO;
            //源信号发送的内容,执行bindingBlock生成中间信号
            id signal = bindingBlock(x, &stop);
            
            @autoreleasepool {
                //执行addSignal,对中间信号进行订阅
                if (signal != nil) addSignal(signal);
                if (signal == nil || stop) {
                    [selfDisposable dispose];
                    completeSignal(selfDisposable);
                }
            }
        } error:^(NSError *error) {
            [compoundDisposable dispose];
            [subscriber sendError:error];
        } completed:^{
            @autoreleasepool {
                completeSignal(selfDisposable);
            }
        }];
        
        selfDisposable.disposable = bindingDisposable;
    }
    
    return compoundDisposable;
}] setNameWithFormat:@"[%@] -bind:", self.name];

 }
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
