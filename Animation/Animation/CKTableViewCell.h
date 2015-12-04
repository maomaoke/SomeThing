//
//  CKTableViewCell.h
//  Animation
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Hero;

@interface CKTableViewCell : UITableViewCell

@property (nonatomic, strong) Hero *hero;

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView actionBlock:(void(^)(UIButton *btn, CGPoint point, UIImage *image))actionBlock;



@end
