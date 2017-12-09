//
//  ViewController.m
//  RACDemo
//
//  Created by iMac on 2017/11/23.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSArray *viewControllers;
@property(nonatomic, strong) NSArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewControllers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSString *identifier = self.viewControllers[indexPath.row];
    BaseViewController *baseVc = [story instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:baseVc animated:YES];
}


#pragma mark - setter/getter

- (NSArray *)viewControllers{
    if(_viewControllers == nil){
        _viewControllers = @[@"RACSignalViewController",
                             @"RACSubjectViewController",
                             @"RACCommandViewController",
                             @"RACSequenceViewController",
                             @"RACDefineViewController",
                             @"RACBindViewController",
                             @"RACMapViewController",
                             @"RACIgnoreViewController",
                             @"RACConcatViewController",
                             @"RACMulticastConnectionVC",
                             @"NetWorkViewController"
                             ];
    }
    return _viewControllers;
}
- (NSArray *)titles{
    if (_titles == nil) {
        _titles = @[@"Signal",
                    @"Subject",
                    @"Command",
                    @"Sequence",
                    @"常用宏",
                    @"Bind",
                    @"映射",
                    @"过滤",
                    @"组合",
                    @"RACMulticastConnectionVC",
                    @"网络请求"
                    ];
    }
    return _titles;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
