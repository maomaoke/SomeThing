//
//  CKCustomNavigationView.h
//  景深和导航栏渐变
//
//  Created by 毛毛可 on 15/12/10.
//  Copyright © 2015年 maomaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKCustomNavigationView : UIView

- (instancetype)initWithFrame:(CGRect)frame
              backgroundImage:(UIImage *)bgImg
                    iconImage:(UIImage *)iconImg
                        title:(NSString *)title
                     subTitle:(NSString *)subTitle
               clickIconBlock:(dispatch_block_t)clickIconBlock;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
