//
//  A-GuidToIOSAnimationViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/19.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "A-GuideToIOSAnimationViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface A_GuideToIOSAnimationViewController ()

@end

@implementation A_GuideToIOSAnimationViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setNav];
    
}
-(void)setNav{
    
//    self.title = @"swimming fish";
    
    self.title = @"A-GUIDE-TO-iOS-ANIMATION";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
   // CABasicAnimation 脉冲效果
//    UIImage *image = [UIImage imageNamed:@"heart.png"];
    
    UIImage *image = [UIImage imageNamed:@"京东京豆"];

         CALayer *layer = [CALayer layer];
         layer.contents = (id)image.CGImage;
         layer.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
         layer.position = CGPointMake(160, 200);
    
         layer.transform = CATransform3DMakeScale(0.90, 0.90, 1);  // 将图片大小按照X轴和Y轴缩放90%，永久
         [self.view.layer addSublayer:layer];

    
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
         animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity]; // 将目标值设为原值
         animation.autoreverses = YES; // 自动倒回最初效果
         animation.duration = 0.35;
         animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
         animation.repeatCount = HUGE_VALF;
        [layer addAnimation:animation forKey:@"pulseAnimation"];
    
    
        
}


@end
