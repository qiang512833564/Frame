//
//  NewsViewModel.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "NewsViewModel.h"

@implementation NewsViewModel

- (void)fetchRemoteServerData {
    
    [self get:self.url type:1 params:self.params  success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
