//
//  BaseViewController.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, strong, readwrite) UIView         *contentView;
@end

@implementation BaseViewController

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configContentView];
    
    [self bindViewModel];
}


- (void)bindViewModel {
    NSDictionary *params = [ViewControllerSimpleConfig viewModelSimpleConfigMappings:self.viewModel];
    
    self.navigationItem.title = [params stringForKey:@"title"];
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 40)];
    leftImageView.image = [UIImage imageNamed:[params stringForKey:@"leftImageName"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftImageView];
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 40)];
    rightImageView.image = [UIImage imageNamed:[params stringForKey:@"rightImageName"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightImageView];
}

- (void)configContentView {
    self.contentView = [[UIView alloc]initWithFrame:self.frame];
}

- (void)reloadviewWhenDatasourceChange {
    
}
@end
