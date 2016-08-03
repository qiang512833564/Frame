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

@implementation LoginModel (SaveDB)

+ (std::vector<std::string>)getIvarArray {
    std::vector<std::string> array;
    
    unsigned int outCount = 0;
    Ivar *ivar = class_copyIvarList(self, &outCount);//self.
    for (int i=0; i<outCount; i++) {
        Ivar oneIvar = ivar[i];
        const char *ivarName = ivar_getName(oneIvar);
        std::string str = ivarName;
        array.push_back(str);
    }
    
    return array;
}

+ (void)load {
    std::vector<std::string> array = [self getIvarArray];
    
    for (auto &ivar :array) {
        std::cout << ivar << std::endl;
    }
    
    std::vector<std::string>().swap(array);
    
    
}

@end
