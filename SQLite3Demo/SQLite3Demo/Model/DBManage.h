//
//  DBManage.h
//  SQLite3Demo
//
//  Created by Rhino on 2017/7/16.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContactModel;


@interface DBManage : NSObject

//单例 //不是严谨的 alloc copy
+ (id)defaultDBManager;

//添加联系人
- (void)addUser:(ContactModel *)user;

//删除联系人
- (void)deleteUser:(ContactModel *)user;

//更新联系人信息
- (void)updateUser:(ContactModel *)user toUser:(ContactModel *)newUser;

//获取通讯录所有
- (NSArray *)searchAllUsers;

@end
