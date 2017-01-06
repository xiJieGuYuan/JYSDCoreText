//
//  blockRACViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/30.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "blockRACViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIView+SDAutoLayout.h"
@interface blockRACViewController ()

@end

@implementation blockRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNav];
    [self createButton];
}

-(void)setNav{
    
    self.title = @"blockRAC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

-(void)createButton{
     UIButton * button = [[UIButton alloc]init];
    [self.view addSubview:button];
    
    button.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .heightIs(40)
    .widthIs(200);
    
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];


    
    
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * button) {
    
        @strongify(self);
        
        NSLog(@"看看这个信号的传递过程:button.name.%@", button.titleLabel.text);

        //[[NSNotificationCenter defaultCenter] postNotificationName:@"clickBlockRACButton" object:button.titleLabel.text];
        
        
    
        
        [self createBlock];
        
                
    }];
    
    
    
}


-(void)createBlock{
    
    [[self asyncProcess] subscribeNext:^(id x) {
        
        NSLog(@"打印出我创建的信号内容blockRAC:%@",x);
        
    }];
}


-(RACSignal *)asyncProcess{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"我自己创建了一个信号"];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
}

@end
