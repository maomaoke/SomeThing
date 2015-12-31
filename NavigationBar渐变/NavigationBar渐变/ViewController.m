//
//  ViewController.m
//  NavigationBar渐变
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "CKCommonDataSource.h"
#import "UINavigationBar+CustomNavigationBar.h"

@interface ViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CKCommonDataSource *dataSource;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation ViewController

static NSString *reuseID = @"NavigationBarCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    self.title = @"test";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)setupTableView {
    self.dataSource = ({
        CKCommonDataSource *dataSource = [CKCommonDataSource commonDataSourceWithModels:self.dataList
                                                                             identifier:reuseID
                                                                        cellConfigBlock:^(id model, UITableViewCell *cell) {
                                                                            cell.textLabel.text = [NSString stringWithFormat:@"%@", model];
                                                                        }];
        dataSource;
    });
    
    self.tableView = ({
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:self.tableView];
        self.tableView.delegate   = self;
        self.tableView.dataSource = self.dataSource;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
        self.tableView;
    });
}


#pragma mark lazy initial

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = @[@1, @2, @3, @4, @5, @6, @7, @8, @1, @2, @3, @4, @5, @6, @7, @8, @1, @2, @3, @4, @5, @6, @7, @8];
    }
    return _dataList;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    UIColor *color = [UIColor blueColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = 1- (64 - offsetY) / 64 >1 ? 1 : 1- (64 - offsetY) / 64;
        [self.navigationController.navigationBar setCustomBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
    } else {
        [self.navigationController.navigationBar setCustomBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

@end






