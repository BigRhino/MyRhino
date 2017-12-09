//
//  NetWorkViewController.m
//  RACDemo
//
//  Created by iMac on 2017/11/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "NetWorkViewController.h"

@interface ImageModel:NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSString *image;

@end

@implementation ImageModel

@end


@interface LoginViewModel:NSObject

@property(nonatomic, strong) RACCommand *command;


@end


@implementation LoginViewModel

- (instancetype)init{
    if (self == [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
}

- (RACCommand *)command{
    if (!_command) {
        _command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
          
            NSLog(@"11");
            
            RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
                NSMutableArray *mutable = [NSMutableArray array];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSString *path = [[NSBundle mainBundle]pathForResource:@"flags.plist" ofType:nil];
                    NSArray *array = [NSArray arrayWithContentsOfFile:path];
                    
                    for (NSDictionary *dict in array) {
                        ImageModel *model = [[ImageModel alloc]init];
                        model.name = dict[@"name"];
                        model.image = dict[@"image"];
                        [mutable addObject:model];
                    }
                    
                    [subscriber sendNext:mutable];
                   // [subscriber sendCompleted];
                    [subscriber sendError:nil];
                    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
                });
                
                
                return nil;
            }];
            return signal;
        }];
    }
    return _command;
}

@end


@interface NetWorkViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) LoginViewModel *viewModel;
@property(nonatomic, strong) NSMutableArray *datasource;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) RACSignal *signal;
@property(nonatomic, strong) RACCommand *command;

@end

@implementation NetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
 //   [self.view addSubview:self.tableView];
#pragma mark - 方法1
   // RACSignal *signal= [self.viewModel.command execute:@"参数!!!!!!"];
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//        [self.datasource addObjectsFromArray:x];
//        [self.tableView reloadData];
//    } error:^(NSError * _Nullable error) {
//        NSLog(@"网络失败~");
//    } completed:^{
//        NSLog(@"请求完成~");
//    }];
    
    
#pragma mark - 方法2
    //1.executionSignals是信号中的信号
    
//    [self.viewModel.command.executionSignals subscribeNext:^(id  _Nullable x) {
//
//        //当执行command的时候会执行这个block,对信号进行订阅
//        NSLog(@"22%@",x);
//        [x subscribeNext:^(id  _Nullable x) {
//
//            //信号发出再调用这里
//            NSLog(@"%@",x);
//            [self.datasource addObjectsFromArray:x];
//            [self.tableView reloadData];
//        }];
//        [x subscribeError:^(NSError * _Nullable error) {
//            NSLog(@"网络失败~");
//        }];
//        [x subscribeCompleted:^{
//            NSLog(@"请求完成~");
//        }];
//
//    }];
//
//    [self.viewModel.command execute:nil];
    
#pragma mark - 方法3
    //1.是订阅不到error和complete的
    //2.先订阅后执行.
    //3.switchToLatest把其转换为信号
//    [self.viewModel.command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//        [self.datasource addObjectsFromArray:x];
//        [self.tableView reloadData];
//    } error:^(NSError * _Nullable error) {
//        NSLog(@"网络失败~");
//    } completed:^{
//        NSLog(@"请求完成~");
//    }];
//
//    [self.viewModel.command execute:nil];
   
#pragma mark - 方法4 订阅error
//    [self.viewModel.command.errors subscribeNext:^(NSError * _Nullable x) {
//        NSLog(@"error:%@",x);
//    }];
//
//    [self.viewModel.command execute:nil];
 
    [self test2];
    
}

- (void)test2{
    
    RACCommand *command = [[RACCommand alloc]initWithEnabled:self.signal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"12222"];
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束订阅~");
            }];
        }];
    }];
    self.command = command;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [[self.command execute:nil]subscribeNext:^(id  _Nullable x) {
        NSLog(@"next~");
    } error:^(NSError * _Nullable error) {
        NSLog(@"error~");
    } completed:^{
        NSLog(@"complete~");
    }];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ImageModel *model = self.datasource[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.image;
    return cell;
}

#pragma mark - setter/getter
- (RACSignal *)signal{
    if (!_signal) {
        _signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [subscriber sendNext:@(NO)]; -->>>>error
//            [subscriber sendError:nil];-->>>>>error
//            [subscriber sendCompleted];-->ok
            //必须是NSNumber
            //Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '-and must only be used on a signal of RACTuples of NSNumbers. Instead, tuple contains a non-NSNumber value: <RACTuple: 0x1c40138f0> ("<null>",1)'
            [subscriber sendNext:@(0)];
            return nil;
        }];
    }
    return _signal;
}


- (LoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc]init];
    }
    return _viewModel;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [[NSMutableArray alloc]init];
    }
    return  _datasource;
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
