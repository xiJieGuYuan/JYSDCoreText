//
//  swimmingFishViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/25.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//



#define SwimmingCenter CGPointMake (self.view.center.x,self.view.center.y)
#define SwimmingStartPoint CGPointMake(200,100)
#import "swimmingFishViewController.h"


@interface swimmingFishViewController ()

@property (strong, nonatomic) UIButton * startAnimationButton;//开始动画按钮
@property (strong, nonatomic) UIImageView * fishImageView;

@property (strong, nonatomic) UIBezierPath * beizerPath;//触摸绘制路径

@property (assign, nonatomic) CGPoint lastPoint;//最后一点
@property (strong, nonatomic) NSMutableArray * pointMutArray;//移动点集合

@end

@implementation swimmingFishViewController

-(NSMutableArray *)pointMutArray{
    
    if (!_pointMutArray) {
        _pointMutArray = [NSMutableArray array];
    }

    return _pointMutArray;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self createBackGroundView];
    [self createStartAnimationButton];
    [self createFishImageView];
}

-(void)setNav{
        
    self.title = @"swimming fish";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)createBackGroundView{
    
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    bgImageView.image = [UIImage imageNamed:@"fishbg"];
    bgImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgImageView];
}

-(void)createStartAnimationButton{
    
    self.startAnimationButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 50, 20)];
    [self.view addSubview:_startAnimationButton];

    [_startAnimationButton setTitle:@"开始" forState:UIControlStateNormal];
    [_startAnimationButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    _startAnimationButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _startAnimationButton.backgroundColor = [UIColor yellowColor];
    
    [_startAnimationButton addTarget:self action:@selector(clickStartAnimationButton:) forControlEvents:UIControlEventTouchUpInside   ];
    
}


#pragma mark - 点击开始动画
-(void)clickStartAnimationButton:(UIButton *)button{
    NSLog(@"开始动画");
    button.enabled = NO;
    
//    //1.绘制bezierPath路径
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:SwimmingCenter radius:(self.view.frame.size.width - 20)/2 startAngle:-M_PI_2 endAngle:3 * M_PI_2 clockwise:1];
    
    CAKeyframeAnimation * animaCycle = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animaCycle.path = path.CGPath;
    animaCycle.calculationMode = @"cubicPaced";
//  animaCycle.rotationMode = kCAAnimationRotateAuto;

    
    CABasicAnimation * animaRote = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animaRote.toValue = [NSNumber numberWithFloat:2 * M_PI];
    
    
    CAAnimationGroup * animaGroup = [CAAnimationGroup animation];
    
    animaGroup.animations = @[animaCycle,animaRote];
    animaGroup.duration = 5.0f;
    animaGroup.repeatCount = MAXFLOAT;
    
    animaGroup.fillMode = @"forwards";
    animaGroup.removedOnCompletion = NO;
    
    [_fishImageView.layer addAnimation:animaGroup forKey:@"swimmingFish"];
}


-(void)createFishImageView{
    
    self.fishImageView = [[UIImageView alloc]init];
    [self.view addSubview:_fishImageView];
    
    NSMutableArray * marr = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        
        UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"fish%d",i]];
        [marr addObject:img];
    }
    
    _fishImageView.animationImages = marr;
    _fishImageView.animationDuration = 0.5;
    _fishImageView.animationRepeatCount = INTMAX_MAX;
    [_fishImageView startAnimating];
    [_fishImageView sizeToFit];
    _fishImageView.center = CGPointMake(200, 100);
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:nil];
    self.lastPoint = point;

    self.beizerPath = [UIBezierPath bezierPath];
    [_beizerPath moveToPoint:point];


    [self.pointMutArray removeAllObjects];
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:nil];
    self.lastPoint = point;
    
    [self.beizerPath addLineToPoint:point];
    
    CGFloat angle = atan2(point.y - _lastPoint.y, point.x - _lastPoint.x);
    [self.pointMutArray addObject:[NSNumber numberWithFloat:angle]];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self startSwimming];
    
}

-(void)startSwimming{
    
    self.startAnimationButton.enabled = YES;
    
    CAKeyframeAnimation  * animaCycle = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animaCycle.path = _beizerPath.CGPath;
    animaCycle.rotationMode = kCAAnimationRotateAuto;
    animaCycle.calculationMode = kCAAnimationPaced;
    
    CAAnimationGroup * animaGroup = [CAAnimationGroup animation];
    animaGroup.animations = @[animaCycle];
    animaGroup.duration = self.pointMutArray.count * 0.1;
    animaGroup.fillMode = kCAFillModeForwards;
    
    animaGroup.removedOnCompletion = NO;
    [_fishImageView.layer addAnimation:animaGroup forKey:@"pathAnimationGroup"];
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [_fishImageView startAnimating];
    _startAnimationButton.enabled = YES;
    
}


@end
