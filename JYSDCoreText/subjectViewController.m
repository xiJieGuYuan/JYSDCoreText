//
//  subjectViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/1/13.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "subjectViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


#import "subjectViewControllerTwo.h"

@interface subjectViewController ()


@property (strong, nonatomic) subjectViewControllerTwo * vcTwo;


@end

@implementation subjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self createPushButton];
}

-(void)setNav{
    
    self.title = @"RACSubject";
    self.view.backgroundColor =[UIColor whiteColor];
}

-(void)createPushButton{
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 40)];
    [self.view addSubview:button];
    
    button.center = self.view.center;
    
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"pushNextVC" forState:UIControlStateNormal];
    
   
  
    
     @weakify(self)
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
    @strongify(self)
        
        subjectViewControllerTwo * twoVC = [[subjectViewControllerTwo alloc] init];
        
       twoVC.subject = [RACSubject subject];
        
        [twoVC.subject subscribeNext:^(RACTuple  * tuple) {  // 这里的x便是sendNext发送过来的信号
            NSLog(@"代理传过来的值:%@", x);
            
            
            RACTupleUnpack(NSString * title,UIColor * color) = tuple;
            
            [button setTitle:title forState:UIControlStateNormal];
            self.view.backgroundColor = color ;
        
        }];
        
        [self.navigationController pushViewController:twoVC animated:YES];
        
    }];
}

@end
