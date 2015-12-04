//
//  ViewController.m
//  CAShapeLayer
//
//  Created by 毛毛可 on 15/11/19.
//  Copyright © 2015年 maomaoke. All rights reserved.
//

#import "ViewController.h"
#import "CKShapeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CKShapeView *shapeView    = [[CKShapeView alloc] initWithFrame:self.view.bounds];
    shapeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shapeView];
}

@end
