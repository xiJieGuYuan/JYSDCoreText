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
}

-(void)setNav{
    
    self.title = @"JSPath";
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)logErrorArray{
    
    NSArray * array = [NSArray arrayWithObjects:@"1",@"1",@"1",@"1", nil];
    
    for (int i = 0; i < 5; i++) {
        
        NSLog(@"array:%@",array[i]);
        
    }
    
    
}
@end
