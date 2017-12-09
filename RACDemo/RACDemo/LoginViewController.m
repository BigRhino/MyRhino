//
//  LoginViewController.m
//  RACDemo
//
//  Created by iMac on 2017/12/9.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewModels:NSObject

/** 账号&&密码  */
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *passord;
/**  处理登录按钮能否点击的信号 */
@property(nonatomic, strong) RACSignal *loginEnableSignal;
/** 登录按钮命令  */
@property(nonatomic, strong) RACCommand *loginCommand;

@end

@implementation LoginViewModels

- (instancetype)init{
    if(self = [super init]){
        [self setup];
    }
    return self;
}

- (void)setup{
    
    //登录按钮的信号
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, phone),RACObserve(self, passord)] reduce:^id _Nullable(NSString *mobile,NSString *pwd){
        return @(mobile.length > 10 && pwd.length > 6);
    }];
    
    //登录执行命令
    _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        //获取账号,密码
        NSLog(@"%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            //执行网络请求
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                [subscriber sendNext:@(YES)];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
   
    //获取命令中信号源
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"__%@",x);
    }];
    
    //监听命令执行过程!!
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        
        if ([x boolValue]) {
            //正在执行
            NSLog(@"显示菊花!!");
        }else{
            NSLog(@"干掉菊花!!");
        }
        
    }];
}

@end

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountFiled;

@property (weak, nonatomic) IBOutlet UITextField *pwdFiled;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

/** VM  */
@property(nonatomic,strong) LoginViewModels * loginVM;


@end

@implementation LoginViewController

-(LoginViewModels *)loginVM
{
    //有效避免出错!!
    if (nil == _loginVM) {
        _loginVM = [[LoginViewModels alloc]init];
        
    }
    return _loginVM;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.给模型的账号&&密码绑定信号!!
    RAC(self.loginVM,phone) = _accountFiled.rac_textSignal;
    RAC(self.loginVM,passord) = _pwdFiled.rac_textSignal;
    //2.设置按钮
    RAC(_loginBtn,enabled) = self.loginVM.loginEnableSignal;
    //3.监听登录按钮的点击
    [[_loginBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //处理登录事件
        [self.loginVM.loginCommand execute:@"账号密码"];
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
