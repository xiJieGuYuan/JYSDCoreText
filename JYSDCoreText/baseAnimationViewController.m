//
//  baseAnimationViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/12.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "baseAnimationViewController.h"
#import "configHeader.h"


@interface baseAnimationViewController ()<CAAnimationDelegate>

@property (strong, nonatomic) UIImageView * animationImageView;

@end

@implementation baseAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self createAnimationImageView];
}

-(void)setNav{
    self.title = @"基础动画";
}

-(void)createAnimationImageView{
    
    self.animationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100,100 ,100 )];
    _animationImageView.image = [UIImage imageNamed:@"京东京豆"];
//    _animationImageView.layer.borderColor = [UIColor cyanColor].CGColor;
//    _animationImageView.layer.borderWidth = 1.0f;
//    self.animationImageView.backgroundColor = [UIColor cyanColor];
    _animationImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_animationImageView];
}

-(NSArray *)operateTitleArray{
    
    return @[@"位移",@"透明度",@"缩放",@"旋转",@"背景色"];
}


-(void)clickBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            [self positionAnimation];
            break;
            
        case 1:
            [self opacityAniamtion];
            break;
            
        case 2:
            [self scaleAnimation];
            break;
            
        case 3:
            [self rotateAnimation];
            break;
            
        case 4:
            [self backgroundAnimation];
            break;
            
        default:
            break;
    }
}


#pragma mark - 1.位移动画
-(void)positionAnimation{
    //使用CABaseAnimation 创建基础动画
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-75)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2 - 75)];
    animation.duration = 2.0f;//动画持续时间
    animation.delegate = self;//设置代理
    
    //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
    //anima.fillMode = kCAFillModeForwards;
    //anima.removedOnCompletion = NO;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_animationImageView.layer addAnimation:animation
                                     forKey:@"positionAnimationQQ"];
    
    
}

#pragma mark - 2.透明度动画
-(void)opacityAniamtion{
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.2f];
    animation.duration = 2.0f;
    [_animationImageView.layer addAnimation:animation forKey:@"opacityAniamtionQQ"];
}

#pragma mark - 3.缩放动画
-(void)scaleAnimation{
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.toValue = [NSNumber numberWithFloat:2.0f];
    animation.duration = 2.0f;
    [_animationImageView.layer addAnimation:animation forKey:@"scaleAnimationQQ"];
}


/*
 kCAMediaTimingFunctionLinear 传这个值，在整个动画时间内动画都是以一个相同的速度来改变。也就是匀速运动。
 kCAMediaTimingFunctionEaseIn 使用该值，动画开始时会较慢，之后动画会加速。
 kCAMediaTimingFunctionEaseOut 使用该值，动画在开始时会较快，之后动画速度减慢。
 kCAMediaTimingFunctionEaseInEaseOut 使用该值，动画在开始和结束时速度较慢，中间时间段内速度较快。
 */

#pragma mark - 4.旋转动画
-(void)rotateAnimation{
   
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];////绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    
    animation.fromValue = [NSNumber numberWithFloat:-M_PI * 0.5];
    animation.toValue = [NSNumber numberWithFloat:M_PI * 0.5];
    animation.duration = 2.0f;
    animation.repeatCount = HUGE_VALF;     //重复的次数。不停重复设置为 HUGE_VALF
    //animation.repeatDuration = 10.0; //设置动画的时间。在该时间内动画一直执行，不计次数
    animation.autoreverses = YES;   //动画结束时是否执行逆动画
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.beginTime = CACurrentMediaTime() + 2;//立即执行延迟2秒
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [_animationImageView.layer addAnimation:animation forKey:@"rotateAnimationQQ"];
}


#pragma mark - 5.背景色变化动画
-(void)backgroundAnimation{
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    
    animation.toValue = (id)[UIColor greenColor].CGColor;
    animation.duration = 2.0f;
    [_animationImageView.layer addAnimation:animation forKey:@"backgroundColorQQ"];
}

#pragma mark - animationDelegate
-(void)animationDidStart:(CAAnimation *)anim{
    
    NSLog(@"animation:%@",_animationImageView.layer.animationKeys);
}

@end
