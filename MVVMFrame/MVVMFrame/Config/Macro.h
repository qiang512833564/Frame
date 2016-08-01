//
//  Macro.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

/*
 弱引用处理
 */
#define weakify(...) \
        rac_keywordify \
        metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)

#define rac_keywordify autoreleasepool {} 

#define rac_weakify_(INDEX, CONTEXT, VAR) \
        CONTEXT __typeof__(VAR) metamacro_concat(VAR, _weak_) = (VAR);

#define metamacro_foreach_cxt(MACRO, SEP, CONTEXT, ...) \
        metamacro_concat(metamacro_foreach_cxt, metamacro_argcount(__VA_ARGS__))(MACRO, SEP, CONTEXT, __VA_ARGS__)

#define metamacro_concat(A, B) \
        metamacro_concat_(A, B)

#define metamacro_concat_(A, B) A ## B

#define metamacro_foreach_cxt1(MACRO, SEP, CONTEXT, _0) MACRO(0, CONTEXT, _0) //

#define metamacro_argcount(...) \
        metamacro_at(20, __VA_ARGS__, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)

#define metamacro_at(N, ...) \
        metamacro_concat(metamacro_at, N)(__VA_ARGS__)

#define metamacro_at20(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, ...) metamacro_head(__VA_ARGS__)

#define metamacro_head(...) \
        metamacro_head_(__VA_ARGS__, 0)

#define metamacro_head_(FIRST, ...) FIRST

/*
 强引用处理
 */
#define strongify(...) \
        rac_keywordify \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Wshadow\"") \
        metamacro_foreach(rac_strongify_,, __VA_ARGS__) \
        _Pragma("clang diagnostic pop")

#define metamacro_foreach(MACRO, SEP, ...) \
        metamacro_foreach_cxt(metamacro_foreach_iter, SEP, MACRO, __VA_ARGS__)

#define metamacro_foreach_iter(INDEX, MACRO, ARG) MACRO(INDEX, ARG)

#define rac_strongify_(INDEX, VAR) \
        __strong __typeof__(VAR) VAR = metamacro_concat(VAR, _weak_);

#endif /* Macro_h */


#define MYLog(...) \
        rac_keywordify \
        NSLog(@"%@,\n%s:%d\n",__VA_ARGS__,__FUNCTION__,__LINE__);
/*
 　1) __VA_ARGS__   是一个可变参数的宏，这个可宏是新的C99规范中新增的，目前似乎gcc和VC6.0之后的都支持（VC6.0的编译器不支持）。宏前面加上##的作用在于，当可变参数的个数为0时，这里的##起到把前面多余的","去掉的作用。
 　　2) __FILE__    宏在预编译时会替换成当前的源文件名
 　　3) __LINE__   宏在预编译时会替换成当前的行号
 　　4) __FUNCTION__   宏在预编译时会替换成当前的函数名称
 */
#define mainThreadQueue(...) \
        autoreleasepool {\
        if ([NSThread isMainThread]) {__VA_ARGS__} else {\
        dispatch_sync(dispatch_get_main_queue(), ^{__VA_ARGS__});\
        }}

#define isKindClass(A, B) \
        ({ \
           BOOL result = NO; \
           if ([A isKindOfClass:objc_getClass(B)]) {\
                result = YES;\
           } else { result = NO; }\
                result;      \
         });
