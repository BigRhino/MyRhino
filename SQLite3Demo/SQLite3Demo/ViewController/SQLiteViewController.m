//
//  SQLiteViewController.m
//  SQLite3Demo
//
//  Created by Rhino on 2017/7/16.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "SQLiteViewController.h"
#import <sqlite3.h>

#define KSQLITEFILENAME @"SqliteUser.sqlite"
@interface SQLiteViewController (){
    sqlite3 *db;
}

@end

@implementation SQLiteViewController

static const char *documentDirectory(){
   return  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:KSQLITEFILENAME].UTF8String;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"sqlite3";
    
    //建立连接
    [self openSqlite];
    [self dropTable];
    //建表
    [self createTable];
    //添加数据
    [self insertData];
    //查询
    [self queryData];
    [self queryLike];
    [self queryWhere];
    //删除
    [self deleteData];
    
    [self upateData];
    //关闭数据库
    [self closeSqlite];
}

//建立连接
- (void)openSqlite{
    //打开数据库
    //参数一:数据库文件所在的完整路径, const char *
    //参数二:数据库句柄 地址 &&sqlite3
   int result =  sqlite3_open(documentDirectory()?:":memory:", &db);
    if (result != SQLITE_OK) {
        //SQLITE_OK 代表打开成功
        NSLog(@"open sqlite3 connection falied!");
    }
}

//建表
- (void)createTable{
    char *sql = "create table if not exists users(id integer primary key autoincrement,name text,desc text)";
    
    char *error;
    //执行SQL语句 常用于执行没有返回值 参数的SQL 比如 DROP,CREATE,DELETE
    //参数一: 数据库对象
    //参数二: 数据库语句
    //参数三: 回调函数
    //参数四: 回调函数的引用(传递参数)
    //参数五: 错误信息
    int status = sqlite3_exec(db, sql, NULL, NULL, &error);
    if (status == SQLITE_OK) {
        NSLog(@"create table success~");
    }else{
        NSLog(@"error:%s",error);
    }
}
//删除表
- (void)dropTable{
    
    char *drop = "drop table users";
    char *error;
    int result = sqlite3_exec(db, drop, NULL, NULL, &error);
    if (result != SQLITE_OK) {
        if (error) {
            NSLog(@"drop table failed,error:%s",error);
        }
    }else{
        NSLog(@"drop table success!");
    }
}

//插入数据
- (void)insertData{
    
    [self insert:@"薛之谦" desc:@"你还要我怎样>"];
    [self insert:@"张三丰" desc:@"武当,~~~~~"];
    [self insert:@"小明" desc:@"明明就是你"];
    [self insert:@"lisi" desc:@"李思思"];
    [self insert:@"sex" desc:@"sex sex"];
    [self insert:@"allen" desc:@"Allen is me!"];
    [self insert:@"si" desc:@"思思思思"];
    
}

- (void)insert:(NSString *)name desc:(NSString *)desc{
    
    char *insertSQL = "insert into users values(null,?,?)";
    
    sqlite3_stmt *stmt;
    //预处理SQL语句
    //参数一: 数据库对象
    //参数二: SQL语句
    //参数三: 执行语句的长度,-1是指全部长度
    //参数四: 语句对象
    //参数五: 没有执行的语句部分 NULL
    int result = sqlite3_prepare_v2(db, insertSQL, -1, &stmt, NULL);
    
    //预编译成功
    if (result == SQLITE_OK) {
        //绑定参数
        //参数一: 语句对象
        //参数二: 参数开始执行的序号
        //参数三: 我们要绑定的值
        //参数四: 绑定的字符串长度
        //参数五: 指针 NULL
        
        //为第一个?绑定参数
        sqlite3_bind_text(stmt, 1, name.UTF8String, -1, NULL);
        //为第二个?绑定参数
        sqlite3_bind_text(stmt, 2, desc.UTF8String, -1, NULL);
        
        //执行SQL语句
        result = sqlite3_step(stmt);
        if (result == SQLITE_DONE) {
            NSLog(@"插入成功~");
        }
        //销毁sqlite3_stmt
        sqlite3_finalize(stmt);
    }
}

//查询所有数据
- (void)queryData{
    
    NSLog(@"query:all______________");
    //sqlite3_exec()一般执行无须返回值的语句 DDL DML
    //如果需要执行查询语句,则先调用sqlite3_prepare_v2预处理查询语句,然后循环调用sqlite3_step()取出查询结果集.
    char *querySQL = "SELECT * FROM users";
    
    sqlite3_stmt *statement;
    
    //v2代表新版本
    //预编译SQL语句,sqlite3_stmt保存了预编译结果的引用
    int result =  sqlite3_prepare_v2(db, querySQL, -1, &statement, nil);
    //预编译成功
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //提取数据
            //参数一:语句对象
            //参数二:字段的索引
            int idKey = sqlite3_column_int(statement, 0);
            const unsigned char *name = sqlite3_column_text(statement, 1);
            const unsigned char *desc = sqlite3_column_text(statement, 2);
            NSLog(@"**************%d,%s,%s",idKey,name,desc);
        }
    }
    sqlite3_finalize(statement);
}
//模糊查询
- (void)queryLike{
    
    NSLog(@"query:name like si______________");
    char *querySQL = "SELECT * FROM users where name like ?";
    
    sqlite3_stmt *statement;
    
    int result =  sqlite3_prepare_v2(db, querySQL, -1, &statement, nil);
    //预编译成功
    if (result == SQLITE_OK) {
        
        //%代表通配符  //这里模糊匹配 si
        NSString *keys = [NSString stringWithFormat:@"%%%@%%",@"si"];
        sqlite3_bind_text(statement, 1, keys.UTF8String, -1, NULL);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int idKey = sqlite3_column_int(statement, 0);
            const unsigned char *name = sqlite3_column_text(statement, 1);
            const unsigned char *desc = sqlite3_column_text(statement, 2);
            NSLog(@"###################%d,%s,%s",idKey,name,desc);
        }
    }
    sqlite3_finalize(statement);
}

//条件
- (void)queryWhere{
    NSLog(@"query:name = '薛之谦'______________");
    
    char *querySQL = "SELECT * FROM users where name = '薛之谦'";
    
    sqlite3_stmt *statement;
    
    int result =  sqlite3_prepare_v2(db, querySQL, -1, &statement, nil);
    //预编译成功
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int idKey = sqlite3_column_int(statement, 0);
            const unsigned char *name = sqlite3_column_text(statement, 1);
            const unsigned char *desc = sqlite3_column_text(statement, 2);
            NSLog(@"$$$$$$$$$$$$$$$$%d,%s,%s",idKey,name,desc);
        }
    }
    sqlite3_finalize(statement);
}

//删除数据
- (void)deleteData{
    char *sql = "delete from users where name = 'sex'";
    
    char *error;
    int result = sqlite3_exec(db, sql, NULL, NULL, &error);
    if (result != SQLITE_OK) {
        if (error) {
            printf("delete:%s\n",error);
        }
    }else{
        NSLog(@"delete success!");
    }
    NSLog(@"new data:~~~~~~~~~`");
    [self queryData];
}
//修改数据
- (void)upateData{
    
    char *sql = "update users set desc=? where name = '薛之谦'";
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(db, sql, -1, &statement, NULL);
    if (result == SQLITE_OK) {
        //预处理成功
        sqlite3_bind_text(statement, 1, "qian'qian,段子手,逗逼,演员", -1, NULL);
        int statu = sqlite3_step(statement);
        if (statu == SQLITE_DONE) {
            NSLog(@"update success!");
        }else{
            NSLog(@"☹️update failed!");
        }
        
    }
    NSLog(@"new data:~~~~~~~~~`");
    [self queryData];
}

- (void)closeSqlite{
    if (db) {
        sqlite3_close(db);
    }
    db = nil;
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
