//
//  UIView+Frame.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

//struct mainThreadQueue {
//    
//};

- (void)setX:(CGFloat)left {
    @weakify(self);
    
    @mainThreadQueue (
                      
                          @strongify(self);
                          CGRect frame = self.frame;
                          frame.origin.x = left;
                          self.frame = frame;
                      
    );
}

- (void)setY:(CGFloat)top {
    @weakify(self);
    
    @mainThreadQueue (
                      @strongify(self);
                      CGRect frame = self.frame;
                      frame.origin.y = top;
                      self.frame = frame;
                      );
}

- (void)setWidth:(CGFloat)width {
    @weakify(self);
    @mainThreadQueue (
                      @strongify(self);
                      CGRect frame = self.frame;
                      frame.size.width = width;
                      self.frame = frame;
                      );
}

- (void)setHeight:(CGFloat)bottom {
    @weakify(self);
    @mainThreadQueue (
                      @strongify(self);
                      CGRect frame = self.frame;
                      frame.size.width = bottom;
                      self.frame = frame;
                      );
}



- (CGFloat)X {
    return self.frame.origin.x;
}

- (CGFloat)Y {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

@end
