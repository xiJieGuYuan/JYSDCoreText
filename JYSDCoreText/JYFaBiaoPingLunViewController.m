//
//  JYFaBiaoPingLunViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/9/3.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "JYFaBiaoPingLunViewController.h"

@interface JYFaBiaoPingLunViewController ()

@end

@implementation JYFaBiaoPingLunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];

}

#pragma mark - 1.设置导航栏相关内容
-(void)setNav{
    
    self.title = @"发表评论";
    
    
    //第一种方法
    UIButton * addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [addButton setTitle:@"添加图片" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    addButton.backgroundColor = [UIColor yellowColor];
    [addButton addTarget:self action:@selector(addNewContent) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * myButton = [[UIBarButtonItem alloc]initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = myButton ;
    
    //第二种方法
    //    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"发表状态" style:UIBarButtonItemStylePlain target:self action:@selector(addNewContent)];
    //    self.navigationItem.rightBarButtonItem = myButton;
}


-(void)addNewContent{
    
    
    
    
}
@end
