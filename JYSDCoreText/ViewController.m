//
//  ViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/8/20.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "ViewController.h"

#import "UIView+SDAutoLayout.h"
#import "JYSolidColorButton.h"

#import "JYPengYouQuanViewController.h"//1.朋友圈
#import "coreAnimationListViewController.h"//2.动画列表

@interface ViewController ()

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
     NSLog(@"self.navigationController:%@,数组%@  =====firstObject:%@",self.navigationController,self.navigationController.viewControllers,[self.navigationController.viewControllers firstObject]);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCustomContents];
}

-(void)createCustomContents{
    
    
    
    __weak typeof(self) weakSelf = self;
     NSArray * titleArray = @[@"1111",@"朋友圈",@"core animation"];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        JYSolidColorButton  * button = [JYSolidColorButton initWithFrame:CGRectNull buttonTitle:titleArray[i] normalBGColor:[UIColor orangeColor] selectBGColor:[UIColor orangeColor] normalColor:nil selectColor:nil buttonFont:[UIFont systemFontOfSize:14.0f] cornerRadius:3.0f doneBlock:^(UIButton *button) {
            
            NSLog(@"点击按钮的button.tag:%ld",button.tag);
            [weakSelf clickAllButton:button];

        }];
        [self.view addSubview:button];
        button.sd_layout.centerXEqualToView(self.view).widthIs(250).heightIs(30).topSpaceToView(self.view,150 + 60 * i);
        button.tag = i;
    }
}

-(void)clickAllButton:(UIButton *)button{
    
    switch (button.tag) {
        case 0:
            [self.navigationController pushViewController:[JYPengYouQuanViewController new] animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:[JYPengYouQuanViewController new] animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:[coreAnimationListViewController new] animated:YES];
            
            break;
            
        default:
            break;
    }
}
@end
