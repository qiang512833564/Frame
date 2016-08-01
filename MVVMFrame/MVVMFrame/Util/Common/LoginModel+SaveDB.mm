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
///在 STL9中对vector 的习惯用法完全不同。我们不是定义一个已知大小的 vector，而是定义一个空 vector \
vector< string > text;

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
    for (auto &i :array) {
        std::cout << i << std::endl;
    }
    int ia[6] = {-2, -1, 0, 1, 2, 1024};
   
    std::vector<int> ivec(ia, ia+6);
    int count = static_cast<int>(ivec.size());//(int)ivec.size();
    std::cout << ivec[count-1] << std::endl;
    
    std::vector<int> ivec1(&ia[0], &ia[6]);
    count = static_cast<int>(ivec1.size());//(int)ivec.size();
    ivec1[5] = 1234;
    std::cout << ivec1[0] << std::endl << ivec1[count-1] << std::endl;
    
    int *p = (int *)&array;
    
    for (int i =0 ; p != nullptr; i++) {
        std::cout << *p << typeid(*p).name() << std::endl;
        p += sizeof(int);
    }
}

@end
