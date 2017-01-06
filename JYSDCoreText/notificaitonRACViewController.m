//
//  notificaitonRACViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/30.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "notificaitonRACViewController.h"


#import <ReactiveCocoa/ReactiveCocoa.h>

#import "UIView+SDAutoLayout.h"

@interface notificaitonRACViewController ()


@property (strong, nonatomic) UIButton * button;




@end

@implementation notificaitonRACViewController



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}


-(instancetype)init{
    
    if (self = [super init]) {
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"clickBlockRACButton" object:nil] ignore:@""] subscribeNext:^(NSNotification * notification) {
            
            NSLog(@"notification.object:%@",notification.object);
            NSLog(@"notification.name:%@",notification.name);
        }];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    
}

-(void)setNav{
    
    self.title = @"notificationRAC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
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
    
    
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"我点击了当前的按钮");
        
//        [[NSNotificationCenter defaultCenter ] postNotificationName:@"clickBlockRACButtonNew" object:@"RACSuccess"];
        
    }] ;
    
    
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"clickBlockRACButtonNew" object:nil] subscribeNext:^(NSNotification * notification) {
//    
//            NSLog(@"notification.object:%@",notification.object);
//            NSLog(@"notification.name:%@",notification.name);
//        }];
}



@end
