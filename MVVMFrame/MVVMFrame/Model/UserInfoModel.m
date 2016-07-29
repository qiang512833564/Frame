//
//  UserInfoModel.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self != nil) {
        
    }
    return self;
}


#pragma mark MTLJSONSerializing
/// 处理 ivar 与 json 数据中 key 不同的映射关系
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userId":@"id"
             };
}

/// 通过 NSValueTransformer 处理 ivar 与 json 数据中 value 类型不同的方法转换
+ (NSValueTransformer *)userIdJSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"userId"]) {
        return [MTLValueTransformer transformerUsingReversibleBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            return [value stringValue];
        }];
    }
    return nil;
}

@end
