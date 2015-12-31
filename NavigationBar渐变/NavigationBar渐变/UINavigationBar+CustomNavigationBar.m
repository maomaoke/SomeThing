//
//  UINavigationBar+CustomNavigationBar.m
//  NavigationBar渐变
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UINavigationBar+CustomNavigationBar.h"
#import <objc/runtime.h>

static const CGFloat defaultY = -20;

@implementation UINavigationBar (CustomNavigationBar)

 const char *overlayerKey = "overlayerKey";

- (UIView *)overlayer {
    
    return  objc_getAssociatedObject(self, overlayerKey);
}

- (void)setOverlayer:(UIView *)overlayer {
    
    objc_setAssociatedObject(self, overlayerKey, overlayer, OBJC_ASSOCIATION_RETAIN);
}


- (void)setCustomBackgroundColor:(UIColor *)color {
    if (!self.overlayer) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];
        
        self.overlayer = [[UIView alloc] initWithFrame:CGRectMake(0, defaultY, [UIScreen mainScreen].bounds.size.width, 64)];
        self.overlayer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self insertSubview:self.overlayer atIndex:0];
    }
    self.overlayer.backgroundColor = color;
}

@end
