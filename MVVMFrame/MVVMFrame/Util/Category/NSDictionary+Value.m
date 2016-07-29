//
//  NSDictionary+Value.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "NSDictionary+Value.h"

@implementation NSDictionary (Value)

- (NSString *)stringForKey:(NSString *)key {
    NSString *str = [self objectForKey:key];
    if (str.length) {
        
    } else {
        str = @"";
    }
    
    return str;
}

@end
