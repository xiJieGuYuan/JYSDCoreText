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
    
//    [self createSignal];
//    
//    [self mapAndFilter];
//    
//    [self delay];
//    
//    [self startWith];
    
//    [self timeOut];
    
    //[self takeOrSkip];
    
    
   // [self throttle];
    
//    [self repeatTest];
    
//    [self mergeTest];
    
//    [self RAC];
    
    [self stopWatch];
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

//2-2  信号的处理 Map(映射)和 filter
-(void)mapAndFilter{
    
    UITextField * textField = ({
        
        textField = [[UITextField alloc]init];
        textField.backgroundColor  = [ UIColor yellowColor];
        textField;
    });
    [self.view addSubview:textField];
    
    @weakify(self);
    
    textField.sd_layout.widthIs(100)
    .heightIs(30)
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view);
    
    [[[[textField.rac_textSignal map:^id(NSString * text) {
//        LxDBAnyVar(text);
        return @(text.length);
    }]filter:^BOOL(NSNumber * value) {
        
        return value.integerValue > 3;
        
    }]filter:^BOOL(NSNumber * value) {
        
        return value.integerValue <= 6;
    }]  subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
}

//2-3 delay
-(void)delay{
    
    //创建信号
    
    RACSignal * signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"rac"];
        [subscriber sendCompleted];
        
        return nil;
    }] delay:2];
    
    LxPrintAnything(start);
    
    //创建订阅者
    [signal subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
}


//2-4 最先开始的时候
-(void)startWith{
    
    RACSignal * signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      
        [subscriber sendNext:@"racStartWith"];
        [subscriber sendCompleted];
        return nil;
    }] startWith:@"123"];
    
    LxPrintAnything(start);
    
    
    [signal subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
}

//2-5 timeOut
-(void)timeOut{
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            
            [subscriber sendNext:@"racTimeOut"];
            [subscriber sendCompleted];
        }];
        return nil;
    }] timeout:2 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        LxDBAnyVar(x);
    } error:^(NSError *error) {
        LxDBAnyVar(error);
    } completed:^{
        LxPrintAnything(completed);
    }];
}


//2-6 takeOrSkip
-(void)takeOrSkip{
    
    RACSignal  * signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"rac1"];
        [subscriber sendNext:@"rac2"];
        [subscriber sendNext:@"rac3"];
        [subscriber sendNext:@"rac4"];
        [subscriber sendCompleted];
        
        return nil;
    }]take:3]; //Skip takeLast takeUntil takeWhileBlock: shipUntilBloclk:
    
    
    [signal subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
}


//2-7 throttle
-(void)throttle{
    
    UITextField * textField = ({
    
        UITextField * textField = [[UITextField alloc]init];
        textField.backgroundColor = [UIColor yellowColor];
        textField;
    });
    
    [self.view addSubview:textField];
    
    @weakify(self);
    
    //throttle 后面是个时间 表示rac_textSignal发送消息，0.3秒内没有再次发送就会相应，若是0.3内又发送消息了，便会在新的信息处重新计时
    //distinctUntilChanged 表示两个消息相同的时候，只会发送一个请求
    //ignore 表示如果消息和ignore后面的消息相同，则会忽略掉这条消息，不让其发送
    
    textField.sd_layout
    .leftSpaceToView(self.view,50)
    .topSpaceToView(self.view,300)
    .widthIs(100)
    .heightIs(30);
    
    
   [[[[[[textField.rac_textSignal throttle:1] distinctUntilChanged] ignore:@""] map:^id(id value) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:value];
            [subscriber sendCompleted];
            
            
            return [RACDisposable disposableWithBlock:^{
                //cancel request
            }];
            
        }];
    }] switchToLatest ] subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
}


//2-8 repeatTest
-(void)repeatTest{
    
    [[[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"repeatTest"];
        [subscriber sendCompleted];
        return nil;
    }] delay:1]repeat]take:10]subscribeNext:^(id x) {
        LxDBAnyVar(x);
    } completed:^{
        
        LxPrintAnything(completed);
    }];
}

//2-9 mergeTest  合并信号
-(void)mergeTest{
    
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LxPrintAnything(a);
            
            [subscriber sendNext:@"a"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
    
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            LxPrintAnything(b);
            
            [subscriber sendNext:@"b"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    
    //merge 合并 concat 链接  zipWith
    [[RACSignal concat:@[signalA,signalB]] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    
//    [[signalA combineLatestWith:signalB] subscribeNext:^(id x) {
//        LxDBAnyVar(x);
//    }];
    
//    [[RACSignal combineLatest:@[signalA,signalB]] subscribeNext:^(id x) {
//        LxDBAnyVar(x);
//    }];
}


//2-10 RAC(TARGET, ...) 宏
-(void)RAC{

    UIButton * button = [[UIButton alloc]init];
    [self.view addSubview:button];
    
    @weakify(self);
    
    button.sd_layout
    .leftSpaceToView(self.view,100)
    .topSpaceToView(self.view,400)
    .widthIs(100)
    .heightIs(40);
    
    
    RAC(button,backgroundColor) = [RACObserve(button, selected) map:^ UIColor *(NSNumber *  selected) {
        
        return [selected boolValue] ? [UIColor redColor] : [UIColor greenColor];
    }];
    
    [[button  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * button) {
        
        button.selected = !button.selected;
    }];
}


//2-11 stopWatch
  -(void)stopWatch{
    
    UILabel * label = ({
        UILabel * label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor cyanColor];
        label;
    });
    [self.view addSubview:label];
    
    
    @weakify(self);
    
    label.sd_layout
    .leftSpaceToView(self.view,70)
    .topSpaceToView(self.view,460)
    .widthIs(260)
    .heightIs(20);
    
    RAC(label,text) = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] map:^NSString * (NSDate * date) {
        
        return date.description;
    }];
}



@end
