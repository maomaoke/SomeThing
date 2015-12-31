//
//  ViewController.m
//  Loading动画
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "CKCustomView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (nonatomic, strong) CKCustomView *customView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.customView = [[CKCustomView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) color:[UIColor blueColor]];
//    self.customView.center = self.view.center;
//    [self.view addSubview:self.customView];
}


- (IBAction)clickStopButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.customView.paused = !sender.selected;
}

@end
