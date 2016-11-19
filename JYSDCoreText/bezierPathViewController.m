//
//  bezierPathViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//



#define degreesToRadians(degrees) ((degrees * (float)M_PI) / 180.0f)

#import "bezierPathViewController.h"

@interface bezierPathViewController ()

@end

@implementation bezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self setupSubviews];
    
}

-(void)setNav{
    
    self.title = @"牙位图";
    self.view.backgroundColor = [UIColor cyanColor];
    
}

- (void)setupSubviews {
    
    float dist = 120;//半径
    
    float btnCount = 32.0f;
    
    for (int i= 1; i<= btnCount;i++) {
        
        float angle = degreesToRadians((360 /btnCount) * i);
        float y = cos(angle) * dist;
        float x = sin(angle) * dist;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //btn.width = 60;
        //btn.height = 60;
        btn.frame = CGRectMake(0, 0, 20, 20);
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = YES;
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        CGPoint center = CGPointMake(self.view.center.x + x, self.view.center.y + y-80);
        btn.center = center;
        
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.view addSubview:btn];
        
    }


}



@end
