//
//  CKCustomNavigationView.m
//  景深和导航栏渐变
//
//  Created by 毛毛可 on 15/12/10.
//  Copyright © 2015年 maomaoke. All rights reserved.
//

#import "CKCustomNavigationView.h"

static const CGFloat minOffset = -64;
static const CGFloat iconSize  = 70;

@interface CKCustomNavigationView ()

@property (nonatomic, strong) UIImageView *backgroundImgView;

@property (nonatomic, strong) UIImageView *iconImgView;

@property (nonatomic, strong) UIImage *bgImg;
@property (nonatomic, strong) UIImage *iconImg;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) dispatch_block_t clickIconBlock;
@end

@implementation CKCustomNavigationView

- (instancetype)initWithFrame:(CGRect)frame
              backgroundImage:(UIImage *)bgImg
                    iconImage:(UIImage *)iconImg
                        title:(NSString *)title
                     subTitle:(NSString *)subTitle
               clickIconBlock:(dispatch_block_t)clickIconBlock {
    
    if (self = [self initWithFrame:frame]) {
        self.bgImg          = bgImg;
        self.iconImg        = iconImg;
        self.title          = title;
        self.subTitle       = subTitle;
        self.clickIconBlock = clickIconBlock;
        [self setupSubViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setupSubViews {
    
    self.backgroundImgView = [[UIImageView alloc] initWithImage:self.bgImg];
    [self addSubview:self.backgroundImgView];
    self.backgroundImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImgView.frame = CGRectMake(0, -self.frame.size.height * 0.5, self.frame.size.width, self.frame.size.height * 1.5);
    
    self.iconImgView = [[UIImageView alloc] initWithImage:self.iconImg];
    self.iconImgView.frame = CGRectMake((self.frame.size.width - iconSize) * 0.5,
                                        0.27 * self.frame.size.height, iconSize, iconSize);
    self.iconImgView.layer.masksToBounds = YES;
    self.iconImgView.layer.cornerRadius  = iconSize * 0.5;
    [self addSubview:self.iconImgView];
    self.clipsToBounds = YES;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    //1.kvo监听外部传入的scroll的滚动
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    //2.将scrollView位于self 下方
    self.scrollView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.frame), 0, 0, 0);
    //将scrollview 默认的contentInset 设置成定制
    self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
}

#pragma mark kvo method
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGPoint offsetPoint = [change[@"new"] CGPointValue];
    //    NSLog(@"%f", offsetPoint.y);
    [self updataSubViewsWithScrollOffset:offsetPoint];
}

- (void)updataSubViewsWithScrollOffset:(CGPoint)offset {
    
    CGFloat startOffset = -self.scrollView.contentInset.top;
    offset.y = offset.y < startOffset ? startOffset : (offset.y > minOffset ? minOffset : offset.y);
    CGFloat newY = -offset.y - self.scrollView.contentInset.top;
    self.frame = CGRectMake(0, newY, self.frame.size.width, self.frame.size.height);
    
    CGFloat alpha = ((startOffset - minOffset) - newY) /  (startOffset - minOffset);
    
    CGFloat bgY = -0.5*self.frame.size.height+(1.5*self.frame.size.height+minOffset)*(1-alpha);
    self.backgroundImgView.frame = CGRectMake(0, bgY, self.frame.size.width, self.frame.size.height * 1.5);
    
    CGFloat scale = 1 + (offset.y - startOffset) / ((startOffset - minOffset) * 2);
    CGFloat subviewOffset = self.frame.size.height-40;
    CGAffineTransform t = CGAffineTransformMakeTranslation(0,(subviewOffset-0.35*self.frame.size.height)*(1-alpha));
    self.iconImgView.transform = CGAffineTransformScale(t, scale, scale);
    
    NSLog(@"%f", scale);
}


- (void)dealloc {
    
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

@end
