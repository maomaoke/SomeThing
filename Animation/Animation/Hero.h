//
//  Hero.h
//  Animation
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL isCollection;

+ (instancetype)heroWithDict:(NSDictionary *)dict;

@end
