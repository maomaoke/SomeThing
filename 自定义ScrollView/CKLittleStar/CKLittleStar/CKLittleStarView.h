//
//  CKLittleStarView.h
//  CKLittleStar
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CKLittleStarViewDelegate <NSObject>

- (void)littleStarViewDidClicked:(NSInteger)level;

@end

@interface CKLittleStarView : UIView

@property (nonatomic, weak) id<CKLittleStarViewDelegate> delegate;


+ (instancetype)littleStarViewWithPosition:(CGPoint)position width:(CGFloat)width;
@end
