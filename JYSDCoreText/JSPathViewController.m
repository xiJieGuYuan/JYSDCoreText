//
//  JSPathViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/1/13.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "JSPathViewController.h"

@interface JSPathViewController ()

@end


@implementation JSPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self logErrorArray];
    [self createTextLabel];
}

-(void)setNav{
    
    self.title = @"JSPathError";
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)logErrorArray{
    
    NSArray * array = [NSArray arrayWithObjects:@"1",@"1",@"1",@"1", nil];
    
    for (int i = 0; i < 5; i++) {
        
        NSLog(@"array:%@",array[i]);
    }
}


-(void)createTextLabel {
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"看看会不会变";
    label.textColor = [UIColor orangeColor];
    label.backgroundColor = [UIColor cyanColor];
    label.center = self.view.center;
    [self.view addSubview:label];
}


@end
