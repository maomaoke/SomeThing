//
//  ViewController.m
//  Animation
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"

#import "CKTableViewCell.h"

#import "Hero.h"


#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)
#define MARGIN (8)

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    UIImageView *_shopCart;
    
}

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) CALayer *layer;

@property (nonatomic, strong) UIView  *coverView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupData];
    
    [self setupTableView];
    
    [self setupShoppingCart];
}

- (void)setupData {
    
    NSString *arrayPath = [[NSBundle mainBundle] pathForResource:@"heros.plist" ofType:nil];
    NSArray  *dataArr   = [NSArray arrayWithContentsOfFile:arrayPath];
    
    for (NSDictionary *dict in dataArr) {
        
        Hero *hero = [Hero heroWithDict:dict];
        [self.dataList addObject:hero];
    }
    
}

- (void)setupShoppingCart {
    
    _shopCart = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123"]];
    
    [_shopCart sizeToFit];
    
    [_shopCart setCenter:CGPointMake(SCREEN_WIDTH - _shopCart.bounds.size.width - MARGIN,
                                     SCREEN_HEIGHT - _shopCart.bounds.size.height - MARGIN)];
    
    [self.view addSubview:_shopCart];
}

- (void)setupTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)
                                              style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark table view delegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CKTableViewCell *cell = [CKTableViewCell tableViewCellWithTableView:tableView actionBlock:^(UIButton *btn, CGPoint point, UIImage *image) {
        __weak typeof(self) weakSelf = self;
        
        CGPoint coordinate = [self.view convertPoint:point fromView:tableView];
        btn.tag = indexPath.row;
        //1.执行动画
        [weakSelf actionAnimationWithButton:btn andPoint:coordinate iconImage:image];
    }];
    
    cell.hero = self.dataList[indexPath.row];
    
    return cell;
}

- (void)actionAnimationWithButton:(UIButton *)btn andPoint:(CGPoint)point iconImage:(UIImage *)image {
    
    //判断按钮的状态
    if (btn.selected) {
        
        NSLog(@"%zd", btn.tag);
        
        //更改模型属性
        Hero *hero = self.dataList[btn.tag];
        hero.isCollection = YES;
        //蒙版
        [self.view addSubview:self.coverView];
        _layer        = [CALayer layer];
        _layer.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
        _layer.position      = point;
        _layer.cornerRadius  = image.size.width * 0.5;
        _layer.masksToBounds = YES;
        _layer.contents      = (__bridge id _Nullable)(image.CGImage);
        [_layer setContentsGravity:kCAGravityResizeAspectFill];
        [self.view.layer addSublayer:_layer];
        
        //创建贝塞尔曲线
        CGFloat ctrlX = point.x + (_shopCart.center.x - point.x) * 0.5;
        CGFloat ctrlY = point.y + (_shopCart.center.y - point.y) - 400;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:point];
        [path addQuadCurveToPoint:_shopCart.center controlPoint:CGPointMake(ctrlX, ctrlY)];
        
        //创建动画
        CAKeyframeAnimation *curveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        curveAnim.path                 = path.CGPath;
        curveAnim.rotationMode         = kCAAnimationRotateAuto;
        
        CABasicAnimation *expandAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        expandAnim.duration          = .5f;
        expandAnim.fromValue         = @1;
        expandAnim.toValue           = @1.5f;
        expandAnim.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        CABasicAnimation *narrowAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        narrowAnim.beginTime         = .5f;
        narrowAnim.duration          = 1.f;
        narrowAnim.fromValue         = @1.5f;
        narrowAnim.toValue           = @.3f;
        narrowAnim.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        CAAnimationGroup *groupAnim  = [CAAnimationGroup animation];
        
        groupAnim.animations          = @[curveAnim, expandAnim, narrowAnim];
        groupAnim.duration            = 1.5f;
        groupAnim.removedOnCompletion = NO;
        
        groupAnim.fillMode  = kCAFillModeForwards;
        groupAnim.delegate  = self;
        
        [_layer addAnimation:groupAnim forKey:@"groupAnim"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (anim == [_layer animationForKey:@"groupAnim"]) {
    
        [_layer removeFromSuperlayer];
        
        //购物车动画
        CABasicAnimation *shopCartAnim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shopCartAnim.duration  = .25f;
        shopCartAnim.fromValue = @(-3);
        shopCartAnim.toValue   = @(3);
        shopCartAnim.autoreverses = YES;
        [_shopCart.layer addAnimation:shopCartAnim forKey:nil];
        
        if (flag) {
            [self.coverView removeFromSuperview];
        }
    }
}


#pragma mark 懒加载

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        [_coverView setBackgroundColor:[UIColor clearColor]];
    }
    return _coverView;
}

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
