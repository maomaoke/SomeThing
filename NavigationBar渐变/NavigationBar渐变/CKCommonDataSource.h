//
//  CKCommonDataSoure.h
//  NavigationBar渐变
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CKCommonDataSource : NSObject <UITableViewDataSource>

+ (instancetype)commonDataSourceWithModels:(NSArray *)models
                                identifier:(NSString *)identifier
                           cellConfigBlock:(void(^)(id model, UITableViewCell *cell))cellConfigBlock;

@end
