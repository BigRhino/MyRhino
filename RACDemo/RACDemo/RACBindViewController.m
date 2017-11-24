//
//  RACBindViewController.m
//  RACDemo
//
//  Created by iMac on 2017/11/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACBindViewController.h"

@interface RACBindViewController ()

@end

@implementation RACBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)test{
    
    RACSubject *subject = [RACSubject subject];
    
//    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
//       
//        
//        return ^RACSignal *(id value,BOOL *stop){
//          
//            
////            return [racretu];
//        };
//        
//    }];
    
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
