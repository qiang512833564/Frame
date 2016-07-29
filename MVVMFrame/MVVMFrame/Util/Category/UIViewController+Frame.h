//
//  UIViewController+Frame.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Frame)
- (CGRect)frame;
- (CGRect)bounds;

- (void)addSubview:(UIView *)view;
@end
