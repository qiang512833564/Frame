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

template <typename T> void __swap (T &a, T &b)
{
    std::cout << "a =" << a << "   " << "b =" << b << std::endl;
    T c(a); a=b; b=c;
}

template <typename T>
class String:std::string {
    String();
    String(T name){
        
    }
};

template <class T>
String<T>::String(){
    
}

struct Teacher {
    Teacher (){
        std::cout << "Teacter()" <<__FUNCTION__ << std::endl;
    }
    
    ~Teacher(){
        std::cout << "~Teacher()" << __FUNCTION__ << std::endl;
    }
};


template <typename T>
class Student {
public:
    Student() {
        
    }
    Student(T name){
        std::cout <<name << std::endl;
    }
};

//template<> std::vector<std::string>::~vector() {
//    
//}
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
    
    //在容器vector中，其内存占用的空间是只增不减的，比如说首先分配了10,000个字节，然后erase掉后面9,999个，则虽然有效元素只有一个，但是内存占用仍为10,000个。所有内存空间在vector析构时回收。
    //vector< T >().swap(X)
    //使得它从曾经的容量减少至它现在需要的容量，这样减少容量的方法被称为“收缩到合适（shrink to fit）”
    std::vector<std::string>().swap(array);
    
    // 上面的作用相当于：
    {
       std::vector<std::string> temp(array);
       temp.swap(array);
    }
    
    Student<Teacher> student;
    int a = 10, b =20;
    __swap(a,b);
}

@end
