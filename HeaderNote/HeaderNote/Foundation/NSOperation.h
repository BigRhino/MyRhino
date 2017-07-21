//
//  NSOperation.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/21.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef NSOperation_h
#define NSOperation_h

#import <Foundation/NSObject.h>
#import <Foundation/NSException.h>
#import <sys/qos.h>
#import <dispatch/dispatch.h>

@class NSArray<ObjectType>, NSSet;

NS_ASSUME_NONNULL_BEGIN

#define NSOperationQualityOfService NSQualityOfService
#define NSOperationQualityOfServiceUserInteractive NSQualityOfServiceUserInteractive
#define NSOperationQualityOfServiceUserInitiated NSQualityOfServiceUserInitiated
#define NSOperationQualityOfServiceUtility NSQualityOfServiceUtility
#define NSOperationQualityOfServiceBackground NSQualityOfServiceBackground


NS_CLASS_AVAILABLE(10_5, 2_0)
//一个多线程任务:抽象类,,类似于JAVA的Runnable接口
//一般使用其子类,1:自定义 继承NSOperation,重写main 2.NSBlockOperation,NSInvocationOperation,

@interface NSOperation : NSObject {
@private
    id _private;
    int32_t _private1;
#if __LP64__
    int32_t _private1b;
#endif
}

//开始
- (void)start;
//任务块
- (void)main;

//是否取消
@property (readonly, getter=isCancelled) BOOL cancelled;
//设置取消 ->不会结束正在执行的任务,只是将属性isCancelled设置为YES
- (void)cancel;

//是否在执行
@property (readonly, getter=isExecuting) BOOL executing;
//是否已经结束
@property (readonly, getter=isFinished) BOOL finished;
//是否并发
@property (readonly, getter=isConcurrent) BOOL concurrent; // To be deprecated; use and override 'asynchronous' below
@property (readonly, getter=isAsynchronous) BOOL asynchronous API_AVAILABLE(macos(10.8), ios(7.0), watchos(2.0), tvos(9.0));
@property (readonly, getter=isReady) BOOL ready;

//添加依赖任务
- (void)addDependency:(NSOperation *)op;
//删除依赖
- (void)removeDependency:(NSOperation *)op;

//所有依赖的任务列表
@property (readonly, copy) NSArray<NSOperation *> *dependencies;

//任务优先级
typedef NS_ENUM(NSInteger, NSOperationQueuePriority) {
    NSOperationQueuePriorityVeryLow = -8L,//最低
    NSOperationQueuePriorityLow = -4L, //低
    NSOperationQueuePriorityNormal = 0, //正常
    NSOperationQueuePriorityHigh = 4,  //高
    NSOperationQueuePriorityVeryHigh = 8 //最高
};

@property NSOperationQueuePriority queuePriority;

@property (nullable, copy) void (^completionBlock)(void) API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));

- (void)waitUntilFinished API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));

@property double threadPriority API_DEPRECATED("Not supported", macos(10.6,10.10), ios(4.0,8.0), watchos(2.0,2.0), tvos(9.0,9.0));

@property NSQualityOfService qualityOfService API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0));

@property (nullable, copy) NSString *name API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0));

@end



NS_CLASS_AVAILABLE(10_6, 4_0)
@interface NSBlockOperation : NSOperation {
@private
    id _private2;
    void *_reserved2;
}

//构建一个任务 block为任务内容
+ (instancetype)blockOperationWithBlock:(void (^)(void))block;

- (void)addExecutionBlock:(void (^)(void))block;
@property (readonly, copy) NSArray<void (^)(void)> *executionBlocks;

@end


NS_CLASS_AVAILABLE(10_5, 2_0)
NS_SWIFT_UNAVAILABLE("NSInvocation and related APIs not available")
@interface NSInvocationOperation : NSOperation {
@private
    id _inv;
    id _exception;
    void *_reserved2;
}

- (nullable instancetype)initWithTarget:(id)target selector:(SEL)sel object:(nullable id)arg;
- (instancetype)initWithInvocation:(NSInvocation *)inv NS_DESIGNATED_INITIALIZER;

@property (readonly, retain) NSInvocation *invocation;

@property (nullable, readonly, retain) id result;

@end

//异常名字 结果异常
FOUNDATION_EXPORT NSExceptionName const NSInvocationOperationVoidResultException API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
//任务取消异常
FOUNDATION_EXPORT NSExceptionName const NSInvocationOperationCancelledException API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

static const NSInteger NSOperationQueueDefaultMaxConcurrentOperationCount = -1;

NS_CLASS_AVAILABLE(10_5, 2_0)
//一个FIFO队列,负责管理添加的多个NSOperation对象,底层维护着一个线程池,会按顺序启动线程来执行任务.
@interface NSOperationQueue : NSObject {
@private
    id _private;
    void *_reserved;
}

//添加一个任务
- (void)addOperation:(NSOperation *)op;
//添加一个任务,是否等待其执行完成(即YES 阻塞线程)
- (void)addOperations:(NSArray<NSOperation *> *)ops waitUntilFinished:(BOOL)wait API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//添加一个任务块
- (void)addOperationWithBlock:(void (^)(void))block API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));

//所有的任务NSOperation
@property (readonly, copy) NSArray<__kindof NSOperation *> *operations;
//NSOperation数量
@property (readonly) NSUInteger operationCount API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//最大并发数
@property NSInteger maxConcurrentOperationCount;
//挂起 暂停调度
@property (getter=isSuspended) BOOL suspended;

//队列名字
@property (nullable, copy) NSString *name API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));

@property NSQualityOfService qualityOfService API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0));

@property (nullable, assign /* actually retain */) dispatch_queue_t underlyingQueue API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0));

//取消所有任务
- (void)cancelAllOperations;
//阻塞当前线程,等待直到所有任务执行完毕
- (void)waitUntilAllOperationsAreFinished;

//类属性:返回当前正在执行的NSOperation的所属队列
@property (class, readonly, strong, nullable) NSOperationQueue *currentQueue API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//类属性 返回主队列
@property (class, readonly, strong) NSOperationQueue *mainQueue API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));

@end

NS_ASSUME_NONNULL_END



#endif /* NSOperation_h */
