//
//  Hero.m
//  Animation
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "Hero.h"

@implementation Hero


+ (instancetype)heroWithDict:(NSDictionary *)dict {
    
    Hero *hero = [[self alloc] init];
    
    [hero setValuesForKeysWithDictionary:dict];
    
    return hero;
}
@end
