//
//  UIViewController+Frame.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "UIViewController+Frame.h"

@implementation UIViewController (Frame)

- (CGRect)frame {
    return self.view.frame;
}

- (CGRect)bounds {
    return self.view.bounds;
}

- (void)addSubview:(UIView *)view {
    @mainThreadQueue (
                      [self.view addSubview:view];
    );
}

@end
