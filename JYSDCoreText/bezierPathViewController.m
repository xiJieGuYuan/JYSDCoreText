//
//  bezierPathViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//



#define degreesToRadians(degrees) ((degrees * (float)M_PI) / 180.0f)

#import "bezierPathViewController.h"

#import "testView.h"

#import "configHeader.h"
@interface bezierPathViewController ()


@property (strong, nonatomic) testView * test;

@property (strong, nonatomic) UIView * animaView;


@property (strong, nonatomic) UIBezierPath * path;


@end

@implementation bezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNav];
    
    [self setupSubviews];
    
   [self createSubviews];
}

-(void)setNav{
    
    self.title = @"bezierPath";
    self.view.backgroundColor = [UIColor whiteColor];
}

//- (void)setupSubviews {
//
//
//    //create a path
//    UIBezierPath * bezierPath = [[UIBezierPath alloc]init];
//    [bezierPath moveToPoint:CGPointMake(0, 150)];
//    
//    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(120, 100) controlPoint2:CGPointMake(200, 200)];
//    
//    //draw the using a CAShapeLayer
//    CAShapeLayer * pathLayer = [CAShapeLayer layer];
//    pathLayer.path = bezierPath.CGPath;
//    
//    
//    
//    
//}



- (void)setupSubviews {
    
    
    /*
     CAKeyframeAnimation * anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
     
     UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2 - 100, 200, 200) ];
     
     anima.path = path.CGPath;
     anima.repeatCount = HUGE_VALL;
     anima.autoreverses = YES;
     anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
     anima.duration = 3.0f;
     [_animationImageView.layer addAnimation:anima forKey:@"pathAnimationQQ"];
     */
    
    testView * test = [[testView alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
    test.layer.masksToBounds = YES;
    test.layer.borderColor = [UIColor cyanColor].CGColor;
    test.layer.borderWidth = 0.5;
    test.backgroundColor = [UIColor whiteColor];
    test.userInteractionEnabled = YES;
    CGPoint  point = CGPointMake(self.view.center.x, self.view.center.y);
    test.center = point;
    [self.view addSubview:test];
    
    self.test = test;
}


-(void)createSubviews{
    
    UIButton * button  = [[UIButton alloc]initWithFrame:CGRectMake(60,self.view.frame.size.height - 60, 100, 40)];
    button.backgroundColor = [UIColor yellowColor];
    [button setTitle:@"动画路径" forState:UIControlStateNormal];
   
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    self.animaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.animaView.backgroundColor = [UIColor yellowColor];
    [self.test addSubview:self.animaView];
}

-(void)clickButton{
    
    NSLog(@"点击了按钮");
    
    CAKeyframeAnimation * anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anima.path = (self.test.path).CGPath;
    anima.autoreverses = YES;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anima.duration = 3.0f;
    
    [self.animaView.layer addAnimation:anima forKey:@"pathAnimation"];
}


@end
