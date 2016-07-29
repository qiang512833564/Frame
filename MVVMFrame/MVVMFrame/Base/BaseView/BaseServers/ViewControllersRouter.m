//
//  ViewControllersRouter.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewControllersRouter.h"

@implementation ViewControllersRouter
static ViewControllersRouter *router;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (router == nil) {
            router = [[self alloc]init];
        }
    });
    return router;
}

- (NSString *)classNameForViewModel:(NSString *)viewModelName {
    NSDictionary *maps = [self viewContollerWithViewMoldeMaps];
    return [maps objectForKey:viewModelName];
}

- (NSDictionary *)viewContollerWithViewMoldeMaps {
    return nil;
}

@end
