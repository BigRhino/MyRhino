//
//  SQLiteHeader.h
//  SQLite3Demo
//
//  Created by Rhino on 2017/7/16.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef SQLiteHeader_h
#define SQLiteHeader_h

/**
 *  SQLite支持的数据类型
 *
 *  INTEGER  有符号整型
 *  REAL     浮点型
 *  TEXT     字符串类型,采用UTF-8,UTF-16编码
 *  BLOB     大二进制对象类型,能够存放任何二进制数据
 *  VARCHAR CHAR CLOB 转成为TEXT类型
 *  FLOAT DOUBLE 转换成REAL类型
 *  NUMERIC   转换成为INTEGER 或者REAL 类型
 */

/**
 *  SQL语句
 *  1.创建数据表
 *    指令:create table 表名(字段1,字段2,.....);
 *    示例:create table USER(uid,name);
 *
 *  2.条件创建:如果不存在则创建
 *    指令:create table if not exists 表名(字段1,字段2,....)
 *    示例:create table if not exists USER(uid,name);
 *
 *  3.删除表
 *    指令:drop table 表名;
 *    示例:drop table USER;
 *
 *  4.插入
 *    指令:insert into 表名(字段1,字段2.....) values(值1,值2....);
 *    示例:insert into USER(uid,name) values(0,'SQLite');
 *
 *  5.查询
 *    指令:select 字段 from 表明;
 *    示例:select * from USER;
 *
 *  6.修改
 *    指令:update 表名 set 字段 = '新值' where 条件
 *    示例:update USER set name = 'Rhino' where uid = 3;
 *
 */

/******************************************______API________***************************************************/



//sqlite3版本
int sqlite3_libversion_number(void);

//sqlite3线程读取是否安全 SQLITE_THREADSAFE
//0不安全
int sqlite3_threadsafe(void);

//关闭sqlite3所代表的数据连接,并释放底层数据库连接资源.调用函数之前,必须先调用sqlite3_finalize()函数结束所有的预编译statement,调用sqlite3_blob_close关闭所有BLOB处理器,否则该函数将会返回SQLITE_BUSY.
int sqlite3_close(sqlite3*)

//执行没有返回值的SQL语句
//参数1:数据库连接对象.
//参数2:SQL语句.
//参数3:回调函数.
//参数4:回调函数的调用参数(第一个),
//参数5:执行SQL语句出错后的错误信息
int sqlite3_exec(
                 sqlite3*,                                  /* An open database */
                 const char *sql,                           /* SQL to be evaluated */
                 int (*callback)(void*,int,char**,char**),  /* Callback function */
                 void *,                                    /* 1st argument to callback */
                 char **errmsg                              /* Error msg written here */
);


//返回sqlite3代表的数据库最后一次插入行的ID
sqlite3_int64 sqlite3_last_insert_rowid(sqlite3*);

//当执行某条DML语句之后,该函数用于返回受该条DML语句影响的记录条数
int sqlite3_changes(sqlite3*);

//返回受DML(delete update insert)语句影响的所有记录条数,该函数并非返回某条SQL语句影响的记录条数,而是返回本次数据库连接打开后,所有SQL语句影响的记录条数.
int sqlite3_total_changes(sqlite3*);

//中断一个长时间执行的查询语句
void sqlite3_interrupt(sqlite3*);

//用于判断SQL语句是否执行完成 适用UTF-8
int sqlite3_complete(const char *sql);
int sqlite3_complete16(const void *sql); //UTF-16

//打开与filename文件关联的数据库连接,并让ppDb参数应用被开始的数据库连接. (UTF-8)
//成功返回SQLITE_OK,失败ppDb为NULL,可以通过sqlite3_errmsg(sqlite3 *);或者sqlite3_errmsg16(sqlite3 *)查看错误信息
//:memory:代表建立一个私有的,临时的存储在内存中的数据库连接,关闭连接close()将会消失
int sqlite3_open(
                 const char *filename,   /* Database filename (UTF-8) */
                 sqlite3 **ppDb          /* OUT: SQLite db handle */
);
//UTF-16
int sqlite3_open16(
                   const void *filename,   /* Database filename (UTF-16) */
                   sqlite3 **ppDb          /* OUT: SQLite db handle */
);
//最新版本 flags可以配置只读[SQLITE_OPEN_READONLY],读写[SQLITE_OPEN_READWRITE]等选项
//zVfs是sqlite3_vfs的名字
int sqlite3_open_v2(
                    const char *filename,   /* Database filename (UTF-8) */
                    sqlite3 **ppDb,         /* OUT: SQLite db handle */
                    int flags,              /* Flags */
                    const char *zVfs        /* Name of VFS module to use */
);

//获取该数据库连接执行SQL语句的错误代码
int sqlite3_errcode(sqlite3 *db);
//获取该数据库连接执行SQL语句额外的错误代码
int sqlite3_extended_errcode(sqlite3 *db);

//获取该数据库连接执行SQL语句的错误提示
const char *sqlite3_errmsg(sqlite3*);
const void *sqlite3_errmsg16(sqlite3*); //UTF-16


//对SQL语句执行预编译
//参数1:数据库连接对象
//参数2:SQL语句
//参数3:SQL语句的最大长度
//参数4:传出参数,指向预编译SQL语句产生的sqlite3_stmt
//参数5:指向SQL语句中未使用的部分
int sqlite3_prepare(
                    sqlite3 *db,            /* Database handle */
                    const char *zSql,       /* SQL statement, UTF-8 encoded */
                    int nByte,              /* Maximum length of zSql in bytes. */
                    sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
                    const char **pzTail     /* OUT: Pointer to unused portion of zSql */
);
int sqlite3_prepare_v2()//最新版本



//提取sqlite3_stmt(预编译SQL语句产生的结果)中包装的SQL语句.
const char *sqlite3_sql(sqlite3_stmt *pStmt);

//用于检测sqlite3_stmt是否为只读操作
int sqlite3_stmt_readonly(sqlite3_stmt *pStmt);

//用于检测sqlite3_stmt是否正在执行过程中
int sqlite3_stmt_busy(sqlite3_stmt*);

//为sqlit3_stmt中的占位符参数绑定参数值,其中第一个参数的索引为1,后面的参数逐个加1,根据绑定的参数类型不同,该函数的函数名有变化.
//参数1:sqlite3_stmt
//参数2:索引值
//参数3:参数的值
int sqlite3_bind_xxx(sqlite3_stmt*, int, xxx);


//返回查询结果的列数量
int sqlite3_column_count(sqlite3_stmt *pStmt);

//查询结果中指定列索引对应的列名
const char *sqlite3_column_name(sqlite3_stmt*, int N);

//查询结果中指定列索引对应的数据库名
const char *sqlite3_column_database_name(sqlite3_stmt*,int);
//查询结果中指定列索引对应的表名
const char *sqlite3_column_table_name(sqlite3_stmt*,int);
//查询结果中指定列索引对应的列类型
const char *sqlite3_column_decltype(sqlite3_stmt*,int);

//执行sqlite3_stmt(预编译SQL语句产生的结果)
//返回SQLITE_DONE 表示执行成功,除非调用sqlite3_reset()函数重设sqlite3_stmt,否则不应该再次调用sqlite_step()函数
//如果返回SQLITE_ROW,则表明sqlite_stmt正在逐行提取查询结果集,可以重复调用sqlite_step()函数,知道该函数不再返回SQLITE_ROW
int sqlite3_step(sqlite3_stmt*);


//当前提取数据行所包含的列数量
//与sqlite3_column_count()的区别:sqlite3_column_count()返回的是整个结果集的列数量,而sqlite3_data_count()返回的是当前提取的数据行的列数量
//比如当sqlite3_step()函数返回SQLITE_DONE时,sqlite3_data_count()函数返回的一定是0
int sqlite3_data_count(sqlite3_stmt *pStmt);

//返回当前行,指定列的数据
xxx sqlite3_column_xxx(sqlite3_stmt*, int iCol);

//销毁sqlite3_stmt,并回收资源
int sqlite3_finalize(sqlite3_stmt *pStmt);

//重设sqlite3_stmt,从而允许再次对改sqlite3_stmt执行sqlite3_step()函数
int sqlite3_reset(sqlite3_stmt *pStmt);

//获取数据库的临时文件的目录
char *sqlite3_temp_directory;

//获取数据库的数据文件的目录
char *sqlite3_data_directory;

//返回指定数据库是否为自动提交模式,如果是返回0,否则返回非零整数
int sqlite3_get_autocommit(sqlite3*);

//返回指定sqlite3_stmt对应的数据库连接
sqlite3 *sqlite3_db_handle(sqlite3_stmt*);

//返回指定数据库的数据库文件路径,该函数返回的总是数据库文件的绝对路径
const char *sqlite3_db_filename(sqlite3 *db, const char *zDbName);

//用于检测指定数据库是否为只读数据库
int sqlite3_db_readonly(sqlite3 *db, const char *zDbName);

//用于获取下一个sqlite3_stmt
sqlite3_stmt *sqlite3_next_stmt(sqlite3 *pDb, sqlite3_stmt *pStmt);




#endif /* SQLiteHeader_h */
