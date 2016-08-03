//
//  LoginModel.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/8/1.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "LoginModel.h"


@implementation LoginModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key { }

+ (void)load {
}

static LoginModel *user;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (user == nil) {
            user = [[LoginModel alloc]init];
        }
    });
    return user;
}



@end
