//
//  CKShapeView.m
//  CAShapeLayer
//
//  Created by 毛毛可 on 15/11/19.
//  Copyright © 2015年 maomaoke. All rights reserved.
//

#import "CKShapeView.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MIN_HEIGHT     (100)


@interface CKShapeView ()

@property (nonatomic, assign) CGFloat mHeight;

@property (nonatomic, assign) CGFloat curveX;

@property (nonatomic, assign) CGFloat curveY;

@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) UIView *curveView;

@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation CKShapeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self configShapeLayer];
        [self configCurveView];
        [self configAction];
        [self updateShapeLayerPath];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
       
        [self configShapeLayer];
        [self configCurveView];
        [self configAction];
        [self updateShapeLayerPath];
    }
    return self;
}



- (void)configShapeLayer {
    
    self.shapeLayer            = [CAShapeLayer layer];
    self.shapeLayer.fillColor  = [UIColor lightGrayColor].CGColor;
    
    [self.layer addSublayer:self.shapeLayer];
}

- (void)configCurveView {
    
    self.curveX = SCREEN_WIDTH * 0.5;
    self.curveY = MIN_HEIGHT;
    
    self.curveView  = [[UIView alloc] initWithFrame:CGRectMake(self.curveX,
                                                               self.curveY,
                                                               3, 3)];
    self.curveView.backgroundColor = [UIColor redColor];
    [self addSubview:self.curveView];
    
}

- (void)configAction {
    
    _mHeight     = MIN_HEIGHT;
    _isAnimating = NO;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handlePanAction:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:pan];
    
    //CADisplayLink
    _displayLink  = [CADisplayLink displayLinkWithTarget:self
                                                              selector:@selector(calculatePath)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                      forMode:NSDefaultRunLoopMode];
    _displayLink.paused = YES;
}

- (void)handlePanAction:(UIPanGestureRecognizer *)pan {
    
    if (!_isAnimating) {
        
        if (pan.state == UIGestureRecognizerStateChanged) {
            
            CGPoint point = [pan translationInView:pan.view];
            
            _mHeight = point.y * 0.7 + MIN_HEIGHT;
            _curveX  = SCREEN_WIDTH * 0.5 + point.x;
            _curveY  = _mHeight > MIN_HEIGHT ? _mHeight : MIN_HEIGHT;
            
            _curveView.frame = CGRectMake(_curveX, _curveY,
                                          _curveView.frame.size.width,
                                          _curveView.frame.size.height);
            [self updateShapeLayerPath];
        } else if (pan.state == UIGestureRecognizerStateCancelled ||
                   pan.state == UIGestureRecognizerStateEnded ||
                   pan.state == UIGestureRecognizerStateFailed) {
            
            //手势结束时,_shapeLayer 返回圆谎并产生弹簧动效
            _isAnimating        = YES;
            _displayLink.paused = NO; //开启dsplayLink执行方法
            
            //弹簧动效
            [UIView animateWithDuration:1.f
                                  delay:0.f
                 usingSpringWithDamping:.5f
                  initialSpringVelocity:.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 
                                 _curveView.frame =CGRectMake(SCREEN_WIDTH * 0.5,
                                                              MIN_HEIGHT, 3, 3);
                             }
                             completion:^(BOOL finished) {
                                 
                                 if (finished) {
                                     
                                     _displayLink.paused = YES;
                                     _isAnimating        = NO;
                                 }
                             }];
        }
    }
}

- (void)updateShapeLayerPath {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)]; //r1点
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)]; //r2点
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH, MIN_HEIGHT)]; //r4点
    [path addQuadCurveToPoint:CGPointMake(0, MIN_HEIGHT)
                 controlPoint:CGPointMake(_curveX, _curveY)]; //r3.r4.r5确定的一条弧线
    [path closePath];
    
    _shapeLayer.path = path.CGPath;
}

//计算弹簧效果坐标
- (void)calculatePath {
    
    //由于手势结束时,r5执行了一个UIView的动画,把这个过程的左边记录下来,并相应的划出_shapeLayer形状
    CALayer *layer = _curveView.layer.presentationLayer;
    _curveX = layer.position.x;
    _curveY = layer.position.y;
    [self updateShapeLayerPath];
}

@end





