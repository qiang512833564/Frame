//
//  UIView+Frame.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*为了保证 UIView frame 设置的线程安全性，在设改变 frame 的时候，统一放到主线程上面去*/
@interface UIView (Frame)

- (void)setX:(CGFloat)left;
- (void)setY:(CGFloat)top;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (CGFloat)X;
- (CGFloat)Y;
- (CGFloat)width;
- (CGFloat)height;

@end
