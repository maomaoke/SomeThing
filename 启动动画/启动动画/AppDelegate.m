//
//  AppDelegate.m
//  启动动画
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CKLaunchAnimator.h"
@interface AppDelegate ()

@property (nonatomic, strong) UIImageView *launchImgView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = ({
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [window makeKeyAndVisible];
        window.rootViewController = [[ViewController alloc] init];
        window;
    });
    
    self.launchImgView = ({
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        imgView.contentMode  = UIViewContentModeScaleAspectFill;
        imgView.image        = [UIImage imageNamed:@"750.png"];
        [self.window addSubview:imgView];
        [self.window bringSubviewToFront:imgView];
        imgView;
    });
    
    {
        [CKLaunchAnimator launchAnimationWithView:self.launchImgView duration:1.2 delegate:self animKey:@"scale"];
        
    }
    
return YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        [self.launchImgView removeFromSuperview];
        self.launchImgView = nil;
    }
}

@end
