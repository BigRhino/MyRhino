//
//  TestFMDBViewController.m
//  SQLite3Demo
//
//  Created by Rhino on 2017/7/16.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "TestFMDBViewController.h"
#import <FMDB.h>

@interface TestFMDBViewController (){
    FMDatabase *_dataBase;
}

@end

@implementation TestFMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //0.
    [self createBase];
    
    //1.显式创建
    [self createBase1];
    
    //2.隐式创建
    [self createBase2];
}


- (void)createBase{
    
    NSString *homePath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *sql = [homePath1 stringByAppendingString:@"/test.db"];
    NSLog(@"%@",sql);
    
    if (_dataBase == nil) {
        _dataBase = [FMDatabase databaseWithPath:sql];
    }
    
}

- (void)createBase1{
    
    [_dataBase open];
    //创建表单
    NSString *sql = @"create table if not exists Student (id integer primary key autoincrement,name varchar(128),age integet,number integer);";
    
    BOOL succ = [_dataBase executeUpdate:sql];
    
    if (succ) {
        NSLog(@"创建成功");
    }
    
    NSDate *date = [NSDate date];
    //隐式使用事务 加1000条数据
    for (int i = 0; i < 1000; i ++) {
        
        [_dataBase executeUpdate:@"insert into Student(name,age,number) values('小明',17,2);"];
    }
    NSLog(@"第一次添加数据耗时：%f",[[NSDate date] timeIntervalSinceDate:date]);
    
    [_dataBase close];
}

- (void)createBase2{
    
    [_dataBase open];
    
    NSDate *date = [NSDate date];
    
    //显式使用事务，添加1000条数据，
    [_dataBase beginTransaction];
    for (int i = 0; i < 1000; i ++) {
        
        [_dataBase executeUpdate:@"insert into Student(name,age,number) values('小明',17,2);"];
        //NSLog(@"%d",is);
    }
    //提交此事务
    [_dataBase commit];
    
    NSLog(@"第二次添加数据耗时：%f",[[NSDate date] timeIntervalSinceDate:date]);
    
    [_dataBase close];
    
    //  相对隐式事务，明显提高效率
    
    //    第一次添加数据耗时：2.864694
    //    第二次添加数据耗时：0.617506
    
    //    第一次添加数据耗时：2.970274
    //    第二次添加数据耗时：0.009343
    
    //第一次添加数据耗时：3.181015
    //第二次添加数据耗时：0.008900
    
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
