//
//  CKLaunchAnimator.h
//  启动动画
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CKLaunchAnimator : NSObject

+ (void)launchAnimationWithView:(UIView *)view duration:(CGFloat)duration delegate:(id)delegate animKey:(NSString *)animKey;

@end
