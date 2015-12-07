//
//  CustomScrollView.m
//  自定义ScrollView
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CustomScrollView.h"

@interface CustomScrollView ()

@property (nonatomic, weak) UIView *subView;
@end

@implementation CustomScrollView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:panGesture];
        [self setupSubView];
    }
    return self;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    //计算手势偏移量
    CGPoint translationPoint = [panGesture translationInView:self];
    NSLog(@"%@", self.subView);
    
    CGRect bounds = self.bounds;
    CGFloat newBoundsOriginX = bounds.origin.x - translationPoint.x;
    CGFloat minBoundsOriginX = 0.0;
    CGFloat maxBoundsOriginX = self.contentSize.width - bounds.size.width;
    bounds.origin.x = fmax(minBoundsOriginX, fmin(newBoundsOriginX, maxBoundsOriginX));
    
    CGFloat newBoundsOriginY = bounds.origin.y - translationPoint.y;
    CGFloat minBoundsOriginY = 0.0;
    CGFloat maxBoundsOriginY = self.contentSize.height - bounds.size.height;
    bounds.origin.y = fmax(minBoundsOriginY, fmin(newBoundsOriginY, maxBoundsOriginY));
    self.bounds = bounds;
    //将手势的偏移量归零
    [panGesture setTranslation:CGPointZero inView:self];
}

- (void)setupSubView {
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    subView.backgroundColor = [UIColor redColor];
    [self addSubview:subView];
    self.subView = subView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
