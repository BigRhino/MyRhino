//
//  ViewController.m
//  SQLite3Demo
//
//  Created by Rhino on 2017/7/16.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "ViewController.h"
#import "AddUserViewController.h"
#import "SQLiteViewController.h"

#import "DBManage.h"
#import "ContactModel.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}


@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //从数据库中读取数据
    [self readDataFromDB];
}

- (void)readDataFromDB{
    //1.添加数据之前 先清空
    [_dataSource removeAllObjects];
    
    //2.添加数据
    DBManage *manage = [DBManage defaultDBManager];
    [_dataSource addObjectsFromArray:[manage searchAllUsers]];
    //3.刷新列表
    [_tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createDataSource];
    //1.设置导航
    [self setNavigationBar];
    
    //2.添加视图
    [self addUI];
}
- (void)createDataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
        
    }
}

- (void)setNavigationBar{
    
    self.title = @"通讯录";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [left addTarget:self action:@selector(leftbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    self.view.backgroundColor = [UIColor purpleColor];
}
- (void)leftbuttonClick:(UIButton *)button{
    SQLiteViewController *sql = [[SQLiteViewController alloc]init];
    [self.navigationController pushViewController:sql animated:YES];
}

- (void)buttonClick:(UIButton *)button{
    AddUserViewController *addUser = [[AddUserViewController alloc]init];
    [self.navigationController pushViewController:addUser animated:YES];
}

- (void)addUI{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    ContactModel *user = _dataSource[indexPath.row];
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = user.tel;
    cell.imageView.image= [UIImage imageNamed:user.head];
    
    return cell;
}
//打开编辑权限
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //从数据库中删除
    ContactModel *user = _dataSource[indexPath.row];
    
    DBManage *manage = [DBManage defaultDBManager];
    [manage deleteUser:user];
    
    [_dataSource removeObject:user];
    //从UI中删除
    [_tableView reloadData];
    
}

//编辑结束调用这个方法
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactModel *user = _dataSource[indexPath.row];
    AddUserViewController *addUser = [[AddUserViewController alloc]init];
    addUser.user = user;
    [self.navigationController pushViewController:addUser animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
