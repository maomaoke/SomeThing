//
//  CKCommonDataSoure.m
//  NavigationBar渐变
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CKCommonDataSource.h"

@interface CKCommonDataSource ()

@property (nonatomic, strong) NSArray *models;

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) void(^cellConfigBlock)(id model, UITableViewCell *cell);
@end

@implementation CKCommonDataSource

+ (instancetype)commonDataSourceWithModels:(NSArray *)models
                                identifier:(NSString *)identifier
                           cellConfigBlock:(void (^)(id, UITableViewCell *))cellConfigBlock {
    
    CKCommonDataSource *dataSource = [[CKCommonDataSource alloc] initWithModels:models identifier:identifier cellConfigBlock:cellConfigBlock];
    
    return dataSource;
}


- (instancetype)initWithModels:(NSArray *)models
                    identifier:(NSString *)identifier
               cellConfigBlock:(void (^)(id, UITableViewCell *))cellConfigBlock {
    
    if (self = [super init]) {
        
        self.models = models;
        self.identifier = identifier;
        self.cellConfigBlock = cellConfigBlock;
    }
    return self;
}

#pragma mark table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
    id model = self.models[indexPath.row];
    if (self.cellConfigBlock) {
        self.cellConfigBlock(model, cell);
    }
    return cell;
}

@end
