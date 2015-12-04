//
//  CKTableViewCell.m
//  Animation
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CKTableViewCell.h"
#import "Hero.h"

@interface CKTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *collectionButton;

@property (nonatomic, copy) void(^actionBlock)(UIButton *btn, CGPoint point, UIImage *image);

@end

@implementation CKTableViewCell

static NSString *reuseID = @"CKTableViewCellID";

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView actionBlock:(void (^)(UIButton *, CGPoint, UIImage *image))actionBlock {
    
    CKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.actionBlock    = actionBlock;
    return cell;
}

- (IBAction)clickCollctionBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    //block
    CGPoint coordinate = [self convertPoint:self.iconView.center toView:self.superview];
    
    if (self.actionBlock) {
        self.actionBlock(sender, coordinate, _iconView.image);
    }
}

- (void)setHero:(Hero *)hero {
    _hero = hero;
    
    self.iconView.image = [UIImage imageNamed:hero.icon];
    self.nameLabel.text = hero.name;
    _collectionButton.selected = hero.isCollection;
}


@end
