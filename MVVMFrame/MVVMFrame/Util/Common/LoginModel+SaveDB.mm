//
//  LoginModel+SaveDB.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/8/1.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "LoginModel+SaveDB.h"
#import <iostream>
#import <vector>
#import <objc/runtime.h>
#import <sqlite3.h>
#import <map>

@implementation LoginModel (SaveDB)

- (std::vector<std::string>)getIvarArray {
    
    std::vector<std::string> array;
    
    unsigned int outCount = 0;
    Ivar *ivar = class_copyIvarList(self.class, &outCount);//self.
    for (int i=1; i<outCount; i++) {
        Ivar oneIvar = ivar[i];
        const char *ivarName = ivar_getName(oneIvar);
        std::string str = ivarName;
        str = str.substr(1,str.size()-1);
        array.push_back(str);
    }
    
    return array;
}

static sqlite3 *db;

- (void)openDB {
    std::vector<std::string> array = [self getIvarArray];
    
    std::string sqlString("create table if not exists User()");
    
    std::string ivarString;
    ivarString.append("username varchar primary key,");
    for (auto &ivar :array) {
        ivarString.append(ivar);
        ivarString.append(" ");
        ivarString.append("varchar(255),");
    }
    
    ivarString = ivarString.substr(0,ivarString.length()-1);
    
    sqlString.insert(sqlString.length()-1, ivarString);
    
    
    std::string path = NSHomeDirectory().UTF8String;
    path.append("/Documents/User.db");
    
    int result = sqlite3_open(path.c_str(), &db);
    if (result == 0) {
        std::cout << "打开数据库成功" << std::endl;
    } else {
        std::cout << "打开数据库失败" << std::endl;
    }
    //
    sqlite3_stmt *stmt;
    result= sqlite3_prepare_v2(db, sqlString.c_str(), -1, &stmt, 0);
    result == 0? std::cout << "创建表成功" << std::endl:std::cout<<"创建表失败"<<std::endl;
    
    // 释放 vector 内存空间
    std::vector<std::string>().swap(array);
    
    std::map<std::string,void* > dictionary;
    
}

- (void)findUserData:(NSString *)username {
    using std::string;
    using std::cout;
    using std::endl;
    
    string sqlString("select * from User where username = ");
    sqlString.append(username.UTF8String);
    
    sqlite3_stmt *queryStmt;
    int result = sqlite3_prepare_v2(db, sqlString.c_str(), 0, &queryStmt, 0);
    if (result != 0) {
        cout << "事务操作失败 result =" << result << endl;
        return;
    }
    int column = sqlite3_column_count(queryStmt);
    for (int i=0; i<column; i++) {
        const char *key = sqlite3_column_name(queryStmt, i);
        sqlite3_value *value = sqlite3_column_value(queryStmt, i);
        if(sqlite3_value_type(value) == SQLITE_BLOB){
            
        }
    }
}

- (void)insertUserData {
    using std::string;
    using std::cout;
    using std::endl;
    
    string sqlString("insert into User ()");
    
    std::vector<std::string> array = [self getIvarArray];
    array.insert(array.begin(), "username");
    
    
    string valueString;
    for (auto& ivar : array) {
        string ivar_name(ivar);
        ivar_name.insert(0, "_");
        Ivar obj_ivar = class_getInstanceVariable(self.class, ivar_name.c_str());
        id value = object_getIvar(self, obj_ivar);
        NSString *value_string = [NSString stringWithFormat:@"%@,",value];
        
        sqlString.insert(sqlString.length()-1, ivar.append(","));
    
        valueString.append(value_string.UTF8String);
    }
    sqlString.replace(sqlString.end()-2, sqlString.end()-1, "");
    valueString.replace(valueString.end()-1, valueString.end(), "");
    sqlString.append("values()");
    
    sqlString.insert(sqlString.length()-1, valueString);
    
    sqlite3_stmt *insert;
    int result = sqlite3_prepare_v2(db, sqlString.c_str(), 0, &insert, 0);
    if (result == 0) {
        cout << "插入成功" << endl;
    } else {
        cout << "插入失败result=" << result << endl;
    }
}

+ (void)load {
    LoginModel *user = [LoginModel shareInstance];
    [user openDB];
    user.username = @"18225523932";
    user.password = @"123456";
    user.accessToken = @"oxwweq231314451";
    
    [user insertUserData];
    NSString *username = [[NSUserDefaults standardUserDefaults]stringForKey:@"username"];
    if (!username.isExists) {
        username = user.username;
    }
    [user findUserData:username];
}

@end
