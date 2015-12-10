//
//  ViewController.m
//  景深和导航栏渐变
//
//  Created by 毛毛可 on 15/12/10.
//  Copyright © 2015年 maomaoke. All rights reserved.
//

#import "ViewController.h"
#import "CKCustomNavigationView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"background.jpg" ofType:nil]];
    UIImage *icon  = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon.jpg" ofType:nil]];
    
    CKCustomNavigationView *navView = [[CKCustomNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) backgroundImage:image iconImage:icon title:nil subTitle:nil clickIconBlock:^{
        
    }];
    navView.scrollView = self.tableView;
    [self.view addSubview:navView];
    
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height)];
//    view.backgroundColor = [UIColor redColor];
//    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"background.jpg" ofType:nil]];
//    UIImageView *bgImgVw = [[UIImageView alloc] initWithImage:image];
//    bgImgVw.center = CGPointMake(self.view.frame.size.width * 0.5, 0);
//    [view addSubview:bgImgVw];
//    [self.view addSubview:view];
//    view.clipsToBounds = YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseID = @"testBarId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.textLabel.text = @"test";
    return cell;
}


@end
