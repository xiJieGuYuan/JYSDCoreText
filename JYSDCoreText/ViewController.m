//
//  ViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/8/20.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "ViewController.h"

#import "UIView+SDAutoLayout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCustomContents];
    
}


-(void)createCustomContents{
    
   // NSArray * titleArray = @[@"统计玩家服务器注册数据",@"统计玩家的账号登陆服务器数据",@"统计玩家的充值数据",@"统计玩家在游戏内的虚拟交易数据",@"统计玩家的任务、副本数据",@"统计玩家的自定义事件",];
    
    
     NSArray * titleArray = @[@"1111",@"2222"];
    
    
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UIButton  * button = [[UIButton alloc]init];
        [self.view addSubview:button];
        
        button.sd_layout.centerXEqualToView(self.view).widthIs(250).heightIs(30).topSpaceToView(self.view,100 + 60 * i);
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 3.0f;
        button.tag = i;
        button.backgroundColor = [UIColor orangeColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAllButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}


-(void)clickAllButton:(UIButton *)button{
    
    NSLog(@"button.tag:%ld",(long)button.tag);
    
}
@end