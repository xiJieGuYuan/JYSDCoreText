//
//  groupAnimationViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/12.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "groupAnimationViewController.h"

#import "configHeader.h"
@interface groupAnimationViewController ()
@property (strong, nonatomic) UIImageView * animationImageView;
@end

@implementation groupAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createAnimationImageView];
}


-(NSString *)controllerTitle{
    
    return @"组动画";
}

-(void)createAnimationImageView{
    
    self.animationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100,100 ,100 )];
    _animationImageView.image = [UIImage imageNamed:@"京东京豆"];
    _animationImageView.backgroundColor = [UIColor clearColor];
    _animationImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_animationImageView];
}

-(NSArray *)operateTitleArray{
    
    return @[@"同时",@"连续"];
}


-(void)clickBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            [self groupAnimation1];
            break;
            
        case 1:
            [self groupAnimation2];
            break;
            
        default:
            break;
    }
}


#pragma mark - 1.同时动画
-(void)groupAnimation1{
    
    //位移动画
    CAKeyframeAnimation * anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    
    
    //缩放动画
    CABasicAnimation * anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    
    //旋转动画
    CABasicAnimation * anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI * 4];
    
    //组动画
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[anima1,anima2,anima3];
    groupAnimation.duration = 3.0f;
    
    
    [_animationImageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
    
    
    
    /*
    //位移动画
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:anima1,anima2,anima3, nil];
    groupAnimation.duration = 4.0f;
    
    [_animationImageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
     
     */
}

#pragma mark - 2.顺序执行的组动画
-(void)groupAnimation2{
    
    CFTimeInterval currentTime = CACurrentMediaTime();
    
    //位移动画
    CABasicAnimation * anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2 - 75)];
    anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2 - 75)];
    anima1.beginTime = currentTime;
    anima1.duration = 1.0f;
    anima1.fillMode = kCAFillModeForwards;
    anima1.removedOnCompletion = NO;
    [_animationImageView.layer addAnimation:anima1 forKey:@"aa"];
    
    //缩放动画
    CABasicAnimation * anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.beginTime = currentTime + 1.0f;
    anima2.duration = 1.0f;
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = YES;
    [_animationImageView.layer addAnimation:anima2 forKey:@"bb"];
    
    //旋转动画
    CABasicAnimation * anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI * 4];
    anima3.beginTime = currentTime + 2.0f;
    anima3.duration = 1.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [_animationImageView.layer addAnimation:anima3 forKey:@"cc"];
    
}



@end
