//
//  commandViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/1/6.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "commandViewController.h"


@interface commandViewController ()


@property (strong, nonatomic,readwrite) RACCommand * command;

@end

@implementation commandViewController

/*
 RACCommand: RAC中用于处理事件的类,可以把事件如何处理,事件中的数据如何传递,包装到这个类里面.
             可以很方便的监控事件的执行过程,比如看事件有没有执行完毕
 使用场景   : 监听按钮的点击,网络请求
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
//    [self testOne];
//    [self testTwo];
//    [self testThree];
//    [self testFour];
    
      [self testFive];
}


-(void)setNav{
    
    self.title = @"RACCommand";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 1.普通做法
-(void)testOne {
  //RACCommand : 处理事件
  //不能返回空信号 创建命令
    self.command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
       
        //block 调用,执行命令的时候调用
        NSLog(@"%@",input);// input 执行命令传进来的参数
        
        //这里的返回值不允许为nil
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            [subscriber sendNext:@"执行命令产生的数据"];
            [subscriber sendCompleted];
            return nil;
        }];
        
    }];
    
    //如何难道执行命令中产生的数据? ==> 订阅命令内部的信号
    //** 方式一: 直接订阅执行命令返回的信号
    
    //执行命令
    RACSignal * signal = [self.command execute:nil];//这里其实用到的是replaySubject 可以先发送命令再订阅
    
    [signal subscribeNext:^(id x) {
        NSLog(@"打印testOne数据:%@",x);
    }];
}


#pragma mark - 2.一般做法
-(void)testTwo{
    
    //1.创建命令
    self.command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        //block 调用,执行命令的时候调用
        NSLog(@"imput:%@",input);// input 执行命令传进来的参数
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"command一般做法传递数据"];
            [subscriber sendCompleted];
            return nil;
        }];
        
    }];
    
    //**方式二: 订阅信号
    //注意: 这里必须是先订阅 才能发送命令
    // executionSignals: 信号源,信号中信号   signalofsignals:信号,发送数据就是信号
    
    [self.command.executionSignals subscribeNext:^(RACSignal * x) {
       
        [x subscribeNext:^(id x) {
            
            NSLog(@"一般方法:%@",x);
        }];
    }];
    
    //2.执行命令
    [self.command execute:@2];
    
}


#pragma mark - 3.高级做法
-(void)testThree{
    
    //1.创建命令
    self.command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        //block调用: 执行命令的时候就会调用
        NSLog(@"%@",input);
        
        //这里的返回值不允许为nil
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"发送信号"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    //方式三
    //switchToLatest获取最新发送的信号,只能用于信号中的信号
    [self.command.executionSignals.switchToLatest subscribeNext:^(id x) {
       
        NSLog(@"高级做法:%@",x);
    }];
    
    [self.command execute:@3];
}

#pragma mark - 4.switchToLatest
-(void)testFour{
    
    //创建信号中信号
    RACSubject *  signalofsignals = [RACSubject subject];
    RACSubject * signalA = [RACSubject subject];
    
    //switchToLastest: 获取信号中信号发送的最新信号
    [signalofsignals.switchToLatest subscribeNext:^(id x) {
       
        NSLog(@"信号中信号:%@",x);
    }];
    
    //发送信号
    [signalofsignals sendNext:signalA];
    [signalA sendNext:@4];
}


#pragma mark - 5.监听事件有没有完成
-(void)testFive{
    
    //注意:当前命令内部发送数据完成,一定要主动发送完成
    //1.创建命令
    
    self.command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        NSLog(@"监听事件是否完成:%@",input);
        
        //这里的返回值不允许为nil
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            //发送数据
            [subscriber sendNext:@"执行命令产生的数据"];
            
            // *** 发送完成 ***
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    //监听事件有没有完成
    [self.command.executing subscribeNext:^(id x) {
        
        if ([x boolValue] == YES) {//..ing
            
            NSLog(@"当前正在执行:%@",x);
        }else{
            
            NSLog(@"执行完成/没有执行");
        }
    }];
    //2.执行命令
    [self.command execute:@1];
}


@end
