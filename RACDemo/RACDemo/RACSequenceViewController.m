//
//  RACSequenceViewController.m
//  RACDemo
//
//  Created by iMac on 2017/11/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACSequenceViewController.h"

@interface RACSequenceViewController ()

@end

@implementation RACSequenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}

- (void)test{

    NSString *pathStr = [[NSBundle mainBundle]pathForResource:@"flags.plist" ofType:nil];
    NSArray *arrayList = [NSArray arrayWithContentsOfFile:pathStr];
   // NSLog(@"%@",arrayList);
    
    [arrayList.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error!");
    } completed:^{
        NSLog(@"completed!");
    }];
    
    NSDictionary *dict = @{@"key":@1, @"key2":@2};
    [dict.rac_sequence.signal subscribeNext:^(id x) {

        // RACTupleUnpack宏：专门用来解析元组
        // RACTupleUnpack 等会右边：需要解析的元组 宏的参数，填解析的什么样数据
        // 元组里面有几个值，宏的参数就必须填几个
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"%@ %@", key, value);
    } error:^(NSError *error) {
        NSLog(@"===error");
    } completed:^{
        NSLog(@"-----ok---完毕");
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
