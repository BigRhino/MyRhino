//
//  CAAnimationViewController.m
//  CAAnimation
//
//  Created by Rhino on 2017/7/18.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CAAnimationViewController.h"


static NSString *const kidentifier = @"cells";


@interface CAAnimationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation CAAnimationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.dataSource = @[@{@"title":@"基本动画",@"class":@"CABasicAnimationVC"},
                        @{@"title":@"关键帧动画",@"class":@"CAKeyframeAnimationVC"},
                        @{@"title":@"转场动画",@"class":@"CATransitionVC"},
                        @{@"title":@"组动画",@"class":@"CAGroupAnimationVC"},
                        @{@"title":@"UIView动画",@"class":@"UIViewAnimationVC"},
                        @{@"title":@"CALayer",@"class":@"CALayerVC"},
                        @{@"title":@"粒子效果",@"class":@"CAEmiterLayerVC"}
                        ];
    [self.view addSubview:self.tableView];
    //    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 100, 100, 100)];
    //    view.backgroundColor = [UIColor greenColor];
    //    [self.view addSubview:view];
    //
    //    NSLog(@"%p",view.layer.backgroundColor);
    //    NSLog(@"%p",view.backgroundColor.CGColor);
    //
    //    CALayer *layer = [CALayer layer];
    //    layer.frame = CGRectMake(20, 220, 100, 100);
    //    layer.backgroundColor = [UIColor redColor].CGColor;
    //    [self.view.layer addSublayer:layer];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kidentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.dataSource[indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = [self.dataSource[indexPath.row] objectForKey:@"class"];
    Class class = NSClassFromString(className);
    UIViewController *vc = (UIViewController *)[[class alloc]init];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kidentifier];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
