//
//  RACSubjectViewController.m
//  RACDemo
//
//  Created by iMac on 2017/11/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACSubjectViewController.h"

@interface TestView:UIView

@property(nonatomic, strong) RACSubject *subject;

@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.subject sendNext:@"代替代理"];
}

- (RACSubject *)subject{
    if(_subject == nil){
        _subject = [RACSubject subject];
    }
    return _subject;
}

@end


/**
 *  总结：
 我们完全可以用RACSubject代替代理/通知，确实方便许多
 这里我们点击TwoViewController的pop的时候 将字符串"ws"传给了ViewController的button的title。
 步骤：
 // 1.创建信号
 RACSubject *subject = [RACSubject subject];
 
 // 2.订阅信号
 [subject subscribeNext:^(id x) {
 // block:当有数据发出的时候就会调用
 // block:处理数据
 NSLog(@"%@",x);
 }];
 
 // 3.发送信号
 [subject sendNext:value];
 **注意：~~**
 RACSubject和RACReplaySubject的区别
 RACSubject必须要先订阅信号之后才能发送信号， 而RACReplaySubject可以先发送信号后订阅.
 RACSubject 代码中体现为：先走TwoViewController的sendNext，后走ViewController的subscribeNext订阅
 RACReplaySubject 代码中体现为：先走ViewController的subscribeNext订阅，后走TwoViewController的sendNext
 可按实际情况各取所需。
 
 */

@interface RACSubjectViewController ()

@property(nonatomic, strong) TestView *test;

@end

@implementation RACSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestView *test = [[TestView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    test.center = self.view.center;

    test.backgroundColor = [UIColor redColor];
    [self.view addSubview:test];
    
    [test.subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"_____%@_______",x);
    }];
    self.test = test;
    
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
