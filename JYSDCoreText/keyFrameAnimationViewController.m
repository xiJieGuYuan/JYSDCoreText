//
//  keyFrameAnimationViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/12.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "keyFrameAnimationViewController.h"

#import "configHeader.h"
@interface keyFrameAnimationViewController ()<CAAnimationDelegate>
@property (strong, nonatomic) UIImageView * animationImageView;

@end

@implementation keyFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createAnimationImageView];
}


-(NSString *)controllerTitle{
    
    return @"关键帧动画";
}

-(void)createAnimationImageView{
    
    self.animationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100,100 ,100 )];
    _animationImageView.image = [UIImage imageNamed:@"京东京豆"];
    _animationImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_animationImageView];
}

-(NSArray *)operateTitleArray{
    
    return @[@"关键帧",@"路径",@"抖动"];
}


-(void)clickBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            [self keyFrameAnimation];
            break;
            
        case 1:
            [self pathAnimation];
            break;
            
        case 2:
            [self shakeAnimation];
            break;
      
            
        default:
            break;
    }
}

#pragma mark - 1.关键帧动画
-(void)keyFrameAnimation{
  
    CAKeyframeAnimation * anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    
    anima.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5,nil];
    anima.duration = 2.0f;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//动画节奏
    anima.delegate = self;//设置代理监测动画的开始/结束
    [_animationImageView.layer addAnimation:anima forKey:@"keyFrameAnimationQQ"];
    
}


#pragma mark - 2.path动画
-(void)pathAnimation{
    
    CAKeyframeAnimation * anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2 - 100, 200, 200) ];
    
    anima.path = path.CGPath;
    anima.repeatCount = HUGE_VALL;
    anima.autoreverses = YES;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anima.duration = 3.0f;
    [_animationImageView.layer addAnimation:anima forKey:@"pathAnimationQQ"];
    
}

#pragma mark - 3.抖动效果

-(void)shakeAnimation{
    
    CAKeyframeAnimation * anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"]; //在这里@"transform.rotation"==@"transform.rotation.z"
    
    NSValue * value1 = [NSNumber numberWithFloat:-M_PI/30 * 4];
    NSValue * value2 = [NSNumber numberWithFloat:M_PI/30 * 4];
    NSValue * value3 = [NSNumber numberWithFloat:-M_PI/30 *4];
    
    anima.values = @[value1,value2,value3];
    anima.repeatCount = MAXFLOAT;
    
    [_animationImageView.layer addAnimation:anima forKey:@"shakeAnimationQQ"];
}




#pragma mark - 动画开始
-(void)animationDidStart:(CAAnimation *)anim{
    
    NSLog(@"动画开始");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSLog(@"动画结束");
}

@end
