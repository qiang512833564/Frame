//
//  ViewController.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *subView = [[UIView alloc]init];
    subView.backgroundColor = [UIColor redColor];
    subView.frame = CGRectMake(50, 100, 100, 60);
    [self.view addSubview:subView];
    
    subView.X = 200;
    
    [self performSelector:@selector(hide) withObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
