//
//  NSObject+ExceptionHandler.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "NSObject+ExceptionHandler.h"

@implementation NSObject (ExceptionHandler)

#pragma mark -- notrecognition handler
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    Method method = class_getInstanceMethod([self class], aSelector);
    NSMethodSignature *signature = nil;
    if (method == nil) {
        signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    } else {
        signature = [NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(method)];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}
@end
