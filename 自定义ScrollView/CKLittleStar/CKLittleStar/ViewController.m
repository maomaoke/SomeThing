//
//  ViewController.m
//  CKLittleStar
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "CKLittleStarView.h"
@interface ViewController () <CKLittleStarViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CKLittleStarView *starView = [CKLittleStarView littleStarViewWithPosition:CGPointMake(100, 100) width:300];
    starView.delegate = self;
    [self.view addSubview:starView];
}


- (void)littleStarViewDidClicked:(NSInteger)level {
    NSLog(@"%zd", level);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
