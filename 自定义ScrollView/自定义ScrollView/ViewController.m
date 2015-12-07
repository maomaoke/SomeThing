//
//  ViewController.m
//  自定义ScrollView
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "CustomScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomScrollView *view = [[CustomScrollView alloc]initWithFrame:self.view.bounds];
    view.contentSize = CGSizeMake(1000, 1000);
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
