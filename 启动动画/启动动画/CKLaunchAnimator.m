//
//  CKLaunchAnimator.m
//  启动动画
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CKLaunchAnimator.h"

@implementation CKLaunchAnimator

+ (void)launchAnimationWithView:(UIView *)view duration:(CGFloat)duration delegate:(id)delegate animKey:(NSString *)animKey {
    
    CABasicAnimation *anim   = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    view.layer.anchorPoint   = CGPointMake(0.5, 0.5);
    anim.fromValue           = @1.0;
    anim.toValue             = @1.2;
    anim.fillMode            = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.autoreverses        = NO;
    anim.duration            = duration;
    anim.delegate            = delegate;
    
    [view.layer addAnimation:anim forKey:animKey];
}

@end
