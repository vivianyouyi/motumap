//
//  DPNavigationController.m
//  DPAssistant
//
//  Created by 吴曹敏 on 16/9/23.
//  Copyright © 2016年 吴曹敏. All rights reserved.
//

#import "MoNavigationController.h"

@interface MoNavigationController ()

@end

@implementation MoNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark 百度页面统计
// 进入页面，建议在此处添加
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
// 退出页面，建议在此处添加
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
