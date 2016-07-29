//
//  BaseDataModel.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (instancetype)init {
    if (self = [super init]) {
        [[ProtocolTerminal sharedInstance]registerHttpProtocol:@protocol(HTTPProtocol) handler:self];
        [[ProtocolTerminal sharedInstance]registerHttpProtocol:@protocol(ParserDataProtocol) handler:self];
        [[ProtocolTerminal sharedInstance]registerHttpProtocol:@protocol(PersistentDataProtocol) handler:self];
    }
    return self;
}

#pragma mark --- 请求方法
- (void)get:(NSString *)url type:(int)type params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    if (type != self.type) {
        return;
    }
    [[ProtocolTerminal sharedInstance]get:url params:params success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)post:(NSString *)url type:(int)type params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    if (type != self.type) {
        return;
    }
    [[ProtocolTerminal sharedInstance]post:url params:params success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
}

- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
}

#pragma mark --- 网络数据处理方法
- (id)parserData_Dictionary:(NSDictionary *)jsonData {
    return nil;
}



@end
