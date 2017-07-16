//
//  DBManage.m
//  SQLite3Demo
//
//  Created by Rhino on 2017/7/16.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "DBManage.h"
#import <FMDB.h>
#import "ContactModel.h"

@interface DBManage(){
    FMDatabase *_dataBase;
}

@end

@implementation DBManage


+ (id)defaultDBManager{
    static DBManage *manager = nil;
    if (manager == nil) {
        manager = [[DBManage alloc]init];
    }
    return manager;
}
/*
 对于Model而言，重写init方法目的在于，创建容器，创建对应的对象，调用成员方法之前的准备的工作
 对于View而言，重写init方法目的在于 添加控件，达到自定制页面的目的
 */
- (id)init{
    if (self = [super init]) {
        [self createDB];
    }
    return self;
}
- (void)createDB{
    
    NSString *dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user"];
    NSLog(@"%@",dbPath);
    if (_dataBase == nil) {
        _dataBase = [FMDatabase databaseWithPath:dbPath];
    }
    //操作数据库之前，一定要打开数据库，要不然所有的操作都无法执行
    [_dataBase open];
    
    [self createTable];
}

- (void)createTable{
    
    NSString *sql = @"create table if not exists Contact(ID integer primary key autoincrement,name varchar(128),remark text,tel text,email varchar(200),head text);";
    
    [_dataBase executeUpdate:sql];
}

- (void)addUser:(ContactModel *)user{
    
    NSString *sql = @"insert into Contact(name,head,email,tel,remark) values(?,?,?,?,?);";
    [_dataBase executeUpdate:sql,user.name,user.head,user.email,user.tel,user.remark];
}

- (void)deleteUser:(ContactModel *)user{
    //根据电话号码删除记录
    NSString *sql =@"delete from Contact where tel=?;";
    [_dataBase executeUpdate:sql,user.tel];
}

- (void)updateUser:(ContactModel *)user toUser:(ContactModel *)newUser{
    
    //1.找到对应的用户；
    NSString *sql = @"select ID from Contact where tel = ?;";
    FMResultSet *resultSet = [_dataBase executeQuery:sql,user.tel];
    NSString *ID = nil;
    if (resultSet.next) {
        ID =[resultSet stringForColumn:@"ID"];
    }
    //2.修改
    if (ID) {
        NSString *sql =@"update Contact set tel=?,name=?,email=?,head=?,remark=? where ID = ?;";
        [_dataBase executeUpdate:sql,newUser.tel,newUser.name,newUser.email,newUser.head,newUser.remark,ID];
    }
}

- (NSArray *)searchAllUsers{
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = @"select * from Contact;";
    FMResultSet *set = [_dataBase executeQuery:sql];
    
    while (set.next) {
        ContactModel *user = [[ContactModel alloc]init];
        user.name = [set stringForColumn:@"name"];
        user.tel = [set stringForColumn:@"tel"];
        user.email  = [set stringForColumn:@"email"];
        user.head = [set stringForColumn:@"head"];
        user.remark = [set stringForColumn:@"remark"];
        
        [array addObject:user];
    }
    return array;
}



@end
