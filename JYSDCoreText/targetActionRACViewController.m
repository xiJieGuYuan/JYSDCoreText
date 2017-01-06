//
//  targetActionRACViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/30.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "targetActionRACViewController.h"


#import "UIView+SDAutoLayout.h"


#import <ReactiveCocoa/ReactiveCocoa.h>

@interface targetActionRACViewController ()

@property (strong, nonatomic) UIButton * button;



@end

@implementation targetActionRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self createRACButton];
    
}

-(void)setNav{
    
    self.title = @"targetActionRAC";
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)createRACButton{
    
    self.button = [[UIButton alloc]init];
    [self.view addSubview:_button];
    
    self.button.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .heightIs(40)
    .widthIs(200);
    
    [_button setTitle:@"确定" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button setBackgroundColor:[UIColor orangeColor]];
    
    
    @weakify(self);
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self);
        NSLog(@"我点击了当前的按钮");
        
    }] ;
    
    
    
}




@end
