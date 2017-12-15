//
//  NSLock.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/21.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef NSLock_h
#define NSLock_h
/**
 1.时间片轮转调度算法:目前操作系统中大量使用的线程管理方式,大致就是操作系统会给每个线程分配一段时间片(通常100ms左右),这些线程都被放在一个队列中,CPU只需要维护这个队列,当对首的线程时间片耗尽就会被强制放到队尾等待,然后提取下一个队首线程执行
 2.原子操作:"原子"一般指最小粒度,不可分割;原子操作也就是不可分割,不可中断的操作
 3.临界区:每个进城中访问临界资源的那段代码成为临界区(Critical Section)(临界资源是一次仅允许一个线程使用的共享资源),每次只准许一个进城进入临界区,进入后不允许其他进程进入,不管是硬件临界资源,还是软件临界资源,多个进程必须互斥的对它进行访问
 4.忙等:试图进入临界区的线程,占着CPU儿不释放的状态
 5.互斥锁:如果一个线程无法获取互斥量,该线程会被直接挂起,不再消耗CPU时间,当其他线程释放互斥量后,操作系统会激活被挂起的线程,互斥锁会使得线程阻塞,阻塞的过程又分为两个阶段,第一阶段是会先空转,可以理解成跑一个while循环,不断地去申请加锁,在空转一定时间之后,线程会进入waiting状态,此时线程就不占用CPU资源了,等锁可用的时候,这个线程会理解被唤醒
 6.自旋锁:如果一个线程需要获取自旋锁,该锁已经被其它线程占用,该线程不会被挂起,而是不断消耗CPU时间,一直试图获取自旋锁.

**/

#import <Foundation/NSObject.h>

@class NSDate;

NS_ASSUME_NONNULL_BEGIN

@protocol NSLocking

//获取锁
- (void)lock;
//释放锁
- (void)unlock;

@end

@interface NSLock : NSObject <NSLocking> {
@private
    void *_priv;
}
//如果在同一个线程上调用两次lock方法，将会对这个线程永久上锁。使用NSRecursiveLock类来才可以实现递归锁。
//解锁一个没有被锁定的锁,只对线程加锁不解锁是一个程序错误

//试图获取一个锁,获取成功返回YES
- (BOOL)tryLock;
//在指定的时间之前获取锁
- (BOOL)lockBeforeDate:(NSDate *)limit;

//锁的名字
@property (nullable, copy) NSString *name API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

@end
//条件锁
@interface NSConditionLock : NSObject <NSLocking> {
@private
    void *_priv;
}

- (instancetype)initWithCondition:(NSInteger)condition NS_DESIGNATED_INITIALIZER;

@property (readonly) NSInteger condition;
- (void)lockWhenCondition:(NSInteger)condition;
- (BOOL)tryLock;
- (BOOL)tryLockWhenCondition:(NSInteger)condition;
- (void)unlockWithCondition:(NSInteger)condition;
- (BOOL)lockBeforeDate:(NSDate *)limit;
- (BOOL)lockWhenCondition:(NSInteger)condition beforeDate:(NSDate *)limit;

@property (nullable, copy) NSString *name API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

@end

//递归锁
@interface NSRecursiveLock : NSObject <NSLocking> {
@private
    void *_priv;
}

- (BOOL)tryLock;
- (BOOL)lockBeforeDate:(NSDate *)limit;

@property (nullable, copy) NSString *name API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

@end



NS_CLASS_AVAILABLE(10_5, 2_0)
@interface NSCondition : NSObject <NSLocking> {
@private
    void *_priv;
}

//设置当前线程一直等待,直到其它线程调用signal或者broadcast方法.
- (void)wait;
//上面方法的变种,控制线程等待到指定时间,到指定时间,线程被自动唤醒
- (BOOL)waitUntilDate:(NSDate *)limit;
//唤醒NSCondition对象上等待的单个线程,如果所有线程都是在该NSCondition对象上锁定的,则会随机唤醒任意一个线程,
- (void)signal;
//唤醒NSCondition对象上等到的所有线程.
- (void)broadcast;

@property (nullable, copy) NSString *name API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

@end

NS_ASSUME_NONNULL_END



#endif /* NSLock_h */
