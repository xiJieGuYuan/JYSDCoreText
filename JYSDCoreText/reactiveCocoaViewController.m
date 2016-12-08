//
//  reactiveCocoaViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/7.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

//#import "UIView+SDAutoLayout.h"

#import "reactiveCocoaViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIView+SDAutoLayout.h"
#import "LxDBAnything.h"
@interface reactiveCocoaViewController ()

@end

@implementation reactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self easyUseReactiveCocoa];
    [self useReactiveCocoa];
}


-(void)setNav{
    
    self.title = @"ReactiveCocoa";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 1.简单使用reactiveCocoa
-(void)easyUseReactiveCocoa{
    
    [self textFieldTest];   //1-1 文本框事件
//    [self gestureTest];     //1-2 手势滑动事件
//    [self notificationTest];//1-3 通知测试
    //[self timeTest];        //1-4 时间测试
    //[self delegateTest];    //1-5 代理测试
    [self kvoTest];         //1-6 kvo测试
}

//1-1 文本框事件
-(void)textFieldTest{
    
    UITextField * textField = ({
        
        UITextField * textField = [[UITextField alloc]init];
        textField.backgroundColor = [UIColor cyanColor];
        textField;
    });
    [self.view addSubview:textField];
    
    @weakify (self);//__weak type(self)weakSelf = self;
    
    textField.sd_layout.leftSpaceToView(self.view,20)
    .topSpaceToView(self.view,100)
    .widthIs(100)
    .heightIs(40);
    
    [[textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    
    //更简单的方式
    [textField.rac_textSignal subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
}

//1-2 手势
-(void)gestureTest{
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
    
    [[tap rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer * tap) {
        
        LxDBAnyVar(tap);
    }];
    
    [self.view addGestureRecognizer:tap];
}

//1-3 通知
-(void)notificationTest{
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] subscribeNext:^(NSNotification * notification) {
        
        LxDBAnyVar(notification);
    }];
    
    //不需要removeObserver
}


//1-4 定时器
-(void)timeTest{
    
    //1.延迟某个时间后再做某件事情
    [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
        
        LxPrintAnything(rac==测试延迟打印这句话);
    }];
   
    //2.每隔多长时间做一件事
    [[RACSignal interval:3 onScheduler:[RACScheduler mainThreadScheduler]]subscribeNext:^(NSDate * date) {
        
        LxDBAnyVar(date);
    }];
}

//1-5 代理(有局限,只能取代没有返回值得代理方法)
-(void)delegateTest{
   
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"RAC" message:@"ReactiveCocoa" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ensurre", nil];
            
    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple * tuple) {
        LxDBAnyVar(tuple);
        LxDBAnyVar(tuple.first);
        LxDBAnyVar(tuple.second);
        LxDBAnyVar(tuple.third);
    }];
    
    [alertView show];
    
    
    //简单方式:
    [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
}

//1-6 KVO
-(void)kvoTest{
    
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.delegate = (id<UIScrollViewDelegate>)self;
    [self.view addSubview:scrollView];
    
    UIView * scrollViewContentView = [[UIView alloc]init];
    scrollViewContentView.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:scrollViewContentView];
    
    @weakify(self);
    
    
    scrollView.sd_layout
    .topSpaceToView(self.view,140)
    .leftSpaceToView(self.view,100)
    .widthIs(150)
    .heightIs(100);
    
    
    scrollViewContentView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(60, 60, 60, 60));
    
    [RACObserve(scrollView, contentOffset) subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
    
    //写法简单 keyPath 有代码提示
}


#pragma mark - 2.进阶使用reactiveCocoa
-(void)useReactiveCocoa{
    
    
    [self createSignal];
    
    
}

//2-1 信号(创建信号 & 激活信号  & 废弃信号)
-(RACSignal *)createSignal{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        RACDisposable * schedulerDisposable = [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
           
            if (arc4random()  %  10 > 1) {
                
                [subscriber sendNext:@"Login response"];
                [subscriber sendCompleted];
            }else{
                
                [subscriber sendError:[NSError errorWithDomain:@"LOGIN_ERROR_DOMAIN" code:444 userInfo:@{@"error":@"not netWork!"}]];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [schedulerDisposable dispose];
        }];
        
        
    }];
    
    
    
}


@end
