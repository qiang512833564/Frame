//
//  ViewControllerSimpleConfig.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewControllerSimpleConfig.h"

@implementation ViewControllerSimpleConfig

+ (NSDictionary *)viewModelSimpleConfigMappings:(id)viewModel {
    BOOL result = isKindClass(viewModel, "BaseViewModel");
    NSDictionary *configParameter = @{};
    if (result == true) {
        configParameter = @{
                            @"title":@"标题",
                            @"leftImageName":@"left",
                            @"rightImageName":@"right"
                            };
    }
    return configParameter;
}

@end
