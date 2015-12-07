//
//  CKLittleStarView.m
//  CKLittleStar
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CKLittleStarView.h"


@interface CKStarButton : UIButton

@end


@implementation CKStarButton

- (void)setHighlighted:(BOOL)highlighted {
    
}
@end

@interface CKLittleStarView ()
@property (nonatomic, strong) NSMutableArray *layerArr;

@property (nonatomic, strong) NSMutableArray *btnArr;
@end

@implementation CKLittleStarView


static NSString *scaleAnimate = @"scaleAnimate";

+ (instancetype)littleStarViewWithFrame:(CGRect)frame {
    CKLittleStarView *starView = [[CKLittleStarView alloc]initWithFrame:frame];
    
    return starView;
}

+ (instancetype)littleStarViewWithPosition:(CGPoint)position width:(CGFloat)width {
    CGRect frame = CGRectMake(position.x, position.y, width, width / 5);
    return [self littleStarViewWithFrame:frame];
}



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //创建子控件
        [self setupSubStar];
        
//        [self setupAnimateForLayers];
    }
    return self;
}

- (void)setupSubStar {
    CGFloat width = self.frame.size.width * 0.2;
    for (NSInteger i = 0; i < 5; ++i) {
//        CALayer *starLayer = [CALayer layer];
//        starLayer.frame = CGRectMake(width * i, 0, width, self.frame.size.height);
//        starLayer.contents = (id)[UIImage imageNamed:@"star"].CGImage;
//        starLayer.contentsScale = [[UIScreen mainScreen] scale];
//        [self.layer addSublayer:starLayer];
//        [self.layerArr addObject:starLayer];
        CKStarButton *starBtn = [[CKStarButton alloc]init];
        starBtn.frame = CGRectMake(width * i, 0, width, self.frame.size.height);
        [starBtn setImage:[UIImage imageNamed:@"star1"] forState:UIControlStateNormal];
        [starBtn setImage:[UIImage imageNamed:@"star"] forState:UIControlStateSelected];
        starBtn.contentMode = UIViewContentModeCenter;
        [self addSubview:starBtn];
        [self.btnArr addObject:starBtn];
        [self.layerArr addObject:starBtn.layer];
        [starBtn addTarget:self action:@selector(changeStarButtons:) forControlEvents:UIControlEventTouchDown];
        starBtn.tag = i;
    }
    UIView *coverView = [[UIView alloc]initWithFrame:self.bounds];
    coverView.backgroundColor = [UIColor clearColor];
    [self addSubview:coverView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickWhichBtn:)];
    [coverView addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(slideStarView:)];
    [coverView addGestureRecognizer:panGesture];
}

- (void)clickWhichBtn:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:tap.view];
    NSInteger index = (NSInteger)floor((fabs(point.x) / fabs(self.frame.size.width * 0.2)));
    if (index <= self.btnArr.count -1) {
       [self changeStarButtons:self.btnArr[index]];
    }
    if (tap.state == UIGestureRecognizerStateEnded || tap.state == UIGestureRecognizerStateCancelled) {
        //使用代理
        if (_delegate && [self.delegate respondsToSelector:@selector(littleStarViewDidClicked:)]) {
            [self.delegate littleStarViewDidClicked:index +1];
        }
    }
}

- (void)slideStarView:(UIPanGestureRecognizer *)pan {
    
    CGPoint point = [pan locationInView:pan.view];
    if (point.x >0) {
        NSInteger index = (NSInteger)floor((fabs(point.x) / fabs(self.frame.size.width * 0.2)));
        if (index <= self.btnArr.count -1) {
            [self changeStarButtons:self.btnArr[index]];
        }
        if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
            //使用代理
            if (_delegate && [self.delegate respondsToSelector:@selector(littleStarViewDidClicked:)]) {
                [self.delegate littleStarViewDidClicked:index +1];
            }
        }
    } else {
        [self cancelAllAnmation];
        for (CKStarButton *btn in self.btnArr) {
            btn.selected = NO;
        }
        if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
            //使用代理
            if (_delegate && [self.delegate respondsToSelector:@selector(littleStarViewDidClicked:)]) {
                [self.delegate littleStarViewDidClicked:0];
            }
        }
    }
    
}


- (void)setupAnimateForLayers {
    
    for (NSInteger i = 0; i < self.layerArr.count; ++i) {
        CALayer *layer = self.layerArr[i];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animation.repeatCount = CGFLOAT_MAX;
        animation.duration = 0.75;
        animation.autoreverses = YES;
        animation.fromValue = @(1);
        animation.toValue = @(1.25);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(((i+1) * 0.15) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [layer addAnimation:animation forKey:nil];
        });
    }
}

- (void)setupAnimateForLayers:(NSInteger)tag {
    for (NSInteger i = 0; i <= tag; ++i) {
        CALayer *layer = self.layerArr[i];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animation.repeatCount = CGFLOAT_MAX;
        animation.duration = 0.5;
        animation.autoreverses = YES;
        animation.fromValue = @(1);
        animation.toValue = @(1.25);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((i * 0.1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [layer addAnimation:animation forKey:scaleAnimate];
        });
    }
}

- (void)cancelAllAnmation {
    for (CALayer *layer in self.layerArr) {
        [layer removeAnimationForKey:scaleAnimate];
    }
}

- (void)changeStarButtons:(CKStarButton *)sender {
    [self cancelAllAnmation];
    for (CKStarButton *btn in self.btnArr) {
        btn.selected = NO;
    }
    [self setupAnimateForLayers:sender.tag];
    for (NSInteger i = 0; i <= sender.tag; ++i) {
        CKStarButton *btn = self.btnArr[i];
        btn.selected = !btn.selected;
    }
}



- (NSMutableArray *)layerArr {
    if (!_layerArr) {
        _layerArr = [NSMutableArray array];
    }
    return _layerArr;
}

- (NSMutableArray *)btnArr {
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

@end






