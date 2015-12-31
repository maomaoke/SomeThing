//
//  CKCustomView.h
//  Loading动画
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKCustomView : UIView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;

@property (nonatomic, assign) BOOL paused;

@end
