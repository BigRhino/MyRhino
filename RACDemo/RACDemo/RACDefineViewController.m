//
//  RACDefineViewController.m
//  RACDemo
//
//  Created by iMac on 2017/11/23.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "RACDefineViewController.h"


@interface RACDefineViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property(nonatomic, strong) RACSignal *signal;

@end

@implementation RACDefineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self racTest];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int r = arc4random()%256;
    int g = arc4random()%256;
    int b = arc4random()%256;
    self.view.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.f];
    
}

- (void)racTest{
    
    //把某个属性绑定一个信号
    RAC(self.textfield,text)  = self.textfield.rac_textSignal;
    [self.textfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //代替KVO 返回一个RACSignal
    [RACObserve(self, view.backgroundColor) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //循环引用 必须成对使用.
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //循环引用 self -> signal  signal.block -> self
        @strongify(self);
        NSLog(@"%@",self);
        [subscriber sendNext:@2];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号失效了~~");
        }];
    }];
    self.signal = signal;
    //冷信号 ,只有订阅才会执行
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    //元祖
    RACTuple *tuple = RACTuplePack(@1,@5,@78);
    NSLog(@"%@",tuple);
    
    //解包
    
    RACTupleUnpack_(NSNumber *n1,NSNumber *n2,NSNumber *n3) = tuple;
    NSLog(@"%@,%@,%@",n1,n2,n3);
    
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
