//
//  ViewController.m
//  HeaderNote
//
//  Created by Rhino on 2017/7/18.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "ViewController.h"
#import "CGTranslateView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    

    CGTranslateView *ts = [[CGTranslateView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:ts];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)applicationEnterBackground:(NSNotification *)notification{
    
    UIApplication *app = [UIApplication sharedApplication];
    //后台任务标识
    __block UIBackgroundTaskIdentifier taskIdentifier;
    
    //申请额外后台执行任务 默认:180s
    //请求失败会执行后面的代码块,返回后台任务标识
    taskIdentifier = [app beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"在额外的申请后台执行时间内依然没有完成任务");
       //结束执行任务
        [app endBackgroundTask:taskIdentifier];
    }];
    
    if (taskIdentifier == UIBackgroundTaskInvalid) {
        NSLog(@"不支持后台执行任务,启动失败~~");
        return;
    }
    
    NSLog(@"额外申请的时间为:%f",app.backgroundTimeRemaining);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i= 0; i < 100; i ++) {
            NSLog(@"下载完成了%%%d",i);
            //暂停10s模拟正在进行后台下载
            [NSThread sleepForTimeInterval:10];
        }
        NSLog(@"剩余的后台任务时间为:%f",app.backgroundTimeRemaining);
        //结束后台任务
        [app endBackgroundTask:taskIdentifier];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
