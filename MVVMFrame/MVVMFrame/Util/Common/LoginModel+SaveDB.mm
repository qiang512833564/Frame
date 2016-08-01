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
#warning 总结：模板类的模板参数\
         如：template <typename T, int N>  这里 <> 尖括号里面的参数内容，可以是 typename 表示任意类型, int , enum 等，同时，这里的参数尤其得注意，这个就是下面模板类 String 的声明格式，也就是说，如果需要用到 String模板的时候，得 String<T,N> 格式的样子使用，另外，需要注意的是：这里的 T,N 类型，如果在 String 的内部用到了，也得注意参数类型一样，否则会出现编译不通过\
            class String:std::string {\
                String(T name){} \
            };

@implementation LoginModel (SaveDB)
/*
    C++中模板的声明和定义的位置一定要小心处理, 否则在链接时会出现"无法解析某某函数或类"的错误。
 　　函数模板的一般定义形式：
 　　template < 类型形式参数表 > 返回类型 FunctionName( 形式参数表 )
 　　{
 　　// 函数定义体
 　　}
 　　说明：
 　　⒈ < 类型形式参数表 > 可以包含基本数据类型，也可以包含类类型。若是类类型，则须加前缀 class 。
 　　⒉这样的函数模板定义不是一个实实在在的函数，编译系统不为其产生任何执行代码。该定义只是对函数的描述，表示它每次能单独处理在类型形式参数表中说明的数据类型。
 */
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


template <typename T, int N>
class Student {
public:
    Student() {
        
    }
    Student(T name){
        std::cout <<name <<std::endl << N << std::endl;
    }
};

template <typename T>
inline T const& max(T const &a, T const &b)
{
    return a<b?b:a;
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
    
    //在容器vector中，其内存占用的空间是只增不减的，比如说首先分配了10,000个字节，然后erase掉后面9,999个，则虽然有效元素只有一个，但是内存占用仍为10,000个。所有内存空间在vector析构时回收。
    //vector< T >().swap(X)
    //使得它从曾经的容量减少至它现在需要的容量，这样减少容量的方法被称为“收缩到合适（shrink to fit）”
    std::vector<std::string>().swap(array);
    
    // 上面的作用相当于：
    {
       std::vector<std::string> temp(array);
       temp.swap(array);
    }
    
    Student<int,100> student(10);
    int a = 10, b =20;
    __swap(a,b);
    
    
    ::max("a","b");         //正确
    //::max("a","ab");        //错误。因为当成引用时，匹配过程包括数组的维数。把模板参数改成指针就可以通过了
    //std::string s;
    //::max("a",s);           //srting和这里的字符数组没办法匹配
}

@end
