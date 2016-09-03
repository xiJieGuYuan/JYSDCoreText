//
//  ViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/8/20.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "ViewController.h"
#import "JYPengYouQuanViewController.h"



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
    
     NSArray * titleArray = @[@"1111",@"点击进入朋友圈"];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UIButton  * button = [[UIButton alloc]init];
        [self.view addSubview:button];
        
        button.sd_layout.centerXEqualToView(self.view).widthIs(250).heightIs(30).topSpaceToView(self.view,200 + 60 * i);
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 3.0f;
        button.tag = i;//工具感觉个
        button.backgroundColor = [UIColor orangeColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAllButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}


-(void)clickAllButton:(UIButton *)button{
    
    [self.navigationController pushViewController:[JYPengYouQuanViewController new] animated:YES];
//    NSLog(@"button.tag:%ld",(long)button.tag);
    
}
@end