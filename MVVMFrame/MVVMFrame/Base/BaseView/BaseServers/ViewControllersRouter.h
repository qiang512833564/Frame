//
//  ViewControllersRouter.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllersRouter : NSObject

+ (instancetype)shareInstance;

- (NSString *)classNameForViewModel:(NSString *)viewModelName;

@end
