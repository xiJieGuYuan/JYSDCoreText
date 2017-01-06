//
//  kvoRACViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/30.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "kvoRACViewController.h"

#import "UIView+SDAutoLayout.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
@interface kvoRACViewController ()


@property (strong, nonatomic) UITextField * textField;


@property (copy, nonatomic) NSString * name;


@end

@implementation kvoRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    
    [self createTextField];
}


-(void)setNav{
    
    self.title = @"kvoRAC";
    self.view.backgroundColor = [UIColor whiteColor];
}



-(void)createTextField{
    
    self.textField = [[UITextField alloc]init];
    [self.view addSubview:_textField];
    
    self.textField.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .widthIs(200)
    .heightIs(30);
    self.textField.backgroundColor = [UIColor yellowColor];
    
        
    [self.textField.rac_textSignal  subscribeNext:^(id x) {
        
         NSLog(@"输入的内容:%@",x);
    }];
    
    
        UIScrollView *scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 100, 100, 80)];
        scrolView.contentSize = CGSizeMake(100, 500);
        scrolView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:scrolView];
        [RACObserve(scrolView, contentSize) subscribeNext:^(id x) {
            NSLog(@"value:%@",x);
        }];
    
}

@end
