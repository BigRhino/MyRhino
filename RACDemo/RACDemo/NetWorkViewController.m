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
                  //  [subscriber sendCompleted];
                    
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

@end

@implementation NetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.tableView];
    
    RACSignal *signal= [self.viewModel.command execute:@"参数!!!!!!"];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        [self.datasource addObjectsFromArray:x];
        [self.tableView reloadData];
    } error:^(NSError * _Nullable error) {
        NSLog(@"网络失败~");
    } completed:^{
        NSLog(@"请求完成~");
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
