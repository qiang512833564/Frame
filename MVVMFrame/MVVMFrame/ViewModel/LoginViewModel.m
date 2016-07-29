//
//  LoginViewModel.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()

@end

@implementation LoginViewModel

- (void)fetchRemoteServerData {
    @weakify(self);
    [self post:self.url type:1 params:self.params  success:^(id response) {
        @strongify(self);
        [self bindModel:response];
    } failure:^(NSError *error) {
        
    }];
}

- (void)bindModel:(NSDictionary *)response {
    
    //self.model = [[UserInfoModel alloc]initWithDictionary:response error:nil];
    
}

@end
