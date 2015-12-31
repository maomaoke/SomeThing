//
//  CKCustomView.m
//  Loading动画
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CKCustomView.h"

static const CGFloat timeInterval = 3.0;

@interface CKCustomView ()

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@end

@implementation CKCustomView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color {
    
    if (self = [self initWithFrame:frame]) {
        
        self.color = color;
        
        [self setupLayer];
        [self setupTimer];
    }
    return self;
}

- (void)setupLayer {
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.frame;
    [self.layer addSublayer:self.shapeLayer];
    self.shapeLayer.lineWidth = 10;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.strokeColor = self.color.CGColor;
    self.shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    self.shapeLayer.anchorPoint = CGPointMake(0.5, 0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.shapeLayer.position radius:50 startAngle:M_PI*0.5*3 endAngle:M_PI*0.5*3 clockwise:NO];
    path.lineCapStyle = kCGLineCapRound;
    
    self.shapeLayer.path = path.CGPath;
}

- (void)setupTimer {
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculatePath)];
    self.displayLink.paused = YES;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)calculatePath {
    //o:M_PI*2
    //d:M_PI*4
    self.startAngle += (M_PI*2 - M_PI*0.5) / (timeInterval*60);
    self.endAngle   += (M_PI*4 - M_PI*0.5) / (timeInterval*60);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.shapeLayer.position radius:50 startAngle:M_PI*0.5*3-self.startAngle endAngle:M_PI*0.5*3 -self.endAngle  clockwise:NO];
    path.lineWidth     = 2;
    path.lineCapStyle  = kCGLineCapRound;
    self.shapeLayer.path = path.CGPath;
}


- (void)setPaused:(BOOL)paused {
    _paused = paused;
    self.displayLink.paused = paused;
}

@end
