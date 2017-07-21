//
//  NSThread.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/21.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef NSThread_h
#define NSThread_h


#import <Foundation/NSObject.h>
#import <Foundation/NSDate.h>
#import <Foundation/NSNotification.h>

@class NSArray<ObjectType>, NSMutableDictionary, NSDate, NSNumber, NSString;

NS_ASSUME_NONNULL_BEGIN
//线程
//线程与进程
/**
1.进程是一个处于运行状态的程序,具有一定独立的功能,系统进行资源分配和调度的独立单位
 特点:
 独立性:进程是系统中独立存在的实体,他可以拥有自己独立的资源,每一个进程都有自己私有的地址和空间.在没有经过进程本身允许的情况下,一个用户进程不可以直接访问其他进程的地址空间.
 动态性:进程和程序的区别在于,程序是一个静态的指令集合,而进程是一个正在系统中活动的指令集合.在进程中添加了时间的概念,进程具有自己生命周期和各个不同的状态,这些是程序不具备的.
 并发性:多个进程可以在单个处理器上并发执行,多个进程间不会互相影响.
 并发性与并行性:并行是在同一时刻,有多个指令在多个处理器上同时执行.并发是同一时刻只有一个指令执行,但多个进程指令被快速轮换执行,使得在宏观上具有多个进程同时执行的效果.
2.线程:轻量级进程,是进程的执行单元.一个进程可以有多个线程,但只能有一个主线程,主线程在进程初始化后被创建.一个线程必须有一个父进程,线程之间是独立的,拥有自己的堆栈,自己的程序计数器,自己的局部变量,但不拥有系统资源,它与父进程的其它线程共享该进程所拥有的全部资源.
 特点:1.独立运行的,不知道其它线程的存在
     2.执行是抢占式的,运行的线程任何时候都有可能被挂起,以便另外的线程运行
 
 **/
//线程的声明周期: 创建->就绪(调用start,交由CPU调度,创建方法调用栈,程序计数器)->运行->结束
//                                                                     ->就绪->...



//线程同步
/**
 @synchronized (obj) {
 
 }
 obj:同步监视器
 线程开始执行同步代码块之前, 必须先获得对同步监视器的锁定,因为任何时刻都只能有一个线程可以获得对同步监视器的锁定,当同步代码块执行完成后,
该线程会释放对同步监视器的锁定. ->组织多个线程对同一资源进行并发访问.
 **/
NSLock
@interface NSThread : NSObject  {
@private
    id _private;
    uint8_t _bytes[44];
}

@property (class, readonly, strong) NSThread *currentThread;

//创建并启动一个线程对象,block(线程执行任务内容)
+ (void)detachNewThreadWithBlock:(void (^)(void))block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0));
//创建并启动一个线程对象,目标方法(线程执行体) 目标 目标参数(方法接受的参数)
+ (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(nullable id)argument;

//是否是多线程
+ (BOOL)isMultiThreaded;

//线程字典
@property (readonly, retain) NSMutableDictionary *threadDictionary;

//休眠到指点时间 休眠是将当前执行的线程暂停一段时间,并进入阻塞状态
+ (void)sleepUntilDate:(NSDate *)date;
//休眠一定时间单位(s)
+ (void)sleepForTimeInterval:(NSTimeInterval)ti;
//退出
+ (void)exit;

//优先级较高的线程获得较多的执行机会,反之,优先级较低的线程获得较少的执行机会,子线程的默认优先级为0.5
//获取当前正在执行的线程的优先级
+ (double)threadPriority;
//设置当前正在执行的线程的优先级
+ (BOOL)setThreadPriority:(double)p;

//对象方法,线程优先级 失效->qualityOfService代替
@property double threadPriority API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0)); // To be deprecated; use qualityOfService below

//枚举
@property NSQualityOfService qualityOfService API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0)); // read-only after the thread is started

@property (class, readonly, copy) NSArray<NSNumber *> *callStackReturnAddresses API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
@property (class, readonly, copy) NSArray<NSString *> *callStackSymbols API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));

//线程名字
@property (nullable, copy) NSString *name API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

//栈大小
@property NSUInteger stackSize API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

//是否是主线程
@property (readonly) BOOL isMainThread API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
@property (class, readonly) BOOL isMainThread API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0)); // reports whether current thread is main
//主线程对象
@property (class, readonly, strong) NSThread *mainThread API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

//构造函数 需要执行start方法开始任务
- (instancetype)init API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0)) NS_DESIGNATED_INITIALIZER;
//构造函数 目标对象 目标执行方法 目标参数
- (instancetype)initWithTarget:(id)target selector:(SEL)selector object:(nullable id)argument API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
//Block类型
- (instancetype)initWithBlock:(void (^)(void))block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0));

//是否正在执行
@property (readonly, getter=isExecuting) BOOL executing API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
//是否执行完毕
@property (readonly, getter=isFinished) BOOL finished API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
//是否已经取消
@property (readonly, getter=isCancelled) BOOL cancelled API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

//取消 并没有终止线程,只是将属性isCancel设置成为YES
- (void)cancel API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
//开始
- (void)start API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
//main 任务的主要内容
- (void)main API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));    // thread body method

@end

//将要变成多线程通知
FOUNDATION_EXPORT NSNotificationName const NSWillBecomeMultiThreadedNotification;
//将要变成单线程通知
FOUNDATION_EXPORT NSNotificationName const NSDidBecomeSingleThreadedNotification;
//线程将要退出通知
FOUNDATION_EXPORT NSNotificationName const NSThreadWillExitNotification;

@interface NSObject (NSThreadPerformAdditions)

//在主线程中执行一个任务
- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait modes:(nullable NSArray<NSString *> *)array;
//和上个方法相同,modes:kCFRunLoopCommonModes
- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait;
// equivalent to the first method with kCFRunLoopCommonModes

//在某个线程对象中执行一个任务
- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait modes:(nullable NSArray<NSString *> *)array API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
//modes:kCFRunLoopCommonModes
- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
// equivalent to the first method with kCFRunLoopCommonModes

//在后台执行一个任务
- (void)performSelectorInBackground:(SEL)aSelector withObject:(nullable id)arg API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

@end

NS_ASSUME_NONNULL_END


#endif /* NSThread_h */
