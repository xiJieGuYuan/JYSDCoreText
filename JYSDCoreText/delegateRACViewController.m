//
//  delegateRACViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/30.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "delegateRACViewController.h"

#import "UIView+SDAutoLayout.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface delegateRACViewController ()<UIScrollViewDelegate>


@property (strong, nonatomic) UIScrollView * scrollView;



@end

@implementation delegateRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self createScorllView];
}

-(void)setNav{
    
    self.title = @"delegateRAC";
    self.view.backgroundColor = [UIColor whiteColor];
    
}


-(void)createScorllView{
    
    self.edgesForExtendedLayout=UIRectEdgeNone;//解决-64.00000距离的问题
    
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:_scrollView];
    
    
    
    self.scrollView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(100, 50, 200, 50));
    
    
    self.scrollView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.scrollView.layer.borderWidth = 0.3;

    _scrollView.contentSize = CGSizeMake(self.view.width - 100, 610);
    
    
    @weakify(self)
    [[self rac_signalForSelector:@selector(scrollViewDidScroll:) fromProtocol:@protocol(UIScrollViewDelegate)]
    subscribeNext:^(id x) {
       @strongify(self)
        NSLog(@"scrollView:%f",self.scrollView.contentOffset.y);
        
    }];
    
    self.scrollView.delegate = self;
}

@end
