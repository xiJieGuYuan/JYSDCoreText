//
//  requestViewModel.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/1/5.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "requestViewModel.h"

#import "AFNetworking.h"

@implementation requestViewModel


-(instancetype)init{
    
    if (self = [super init]) {
        
        [self getData];
    }
    return self;
}

-(void)getData{
    
    
    self.requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
            
            [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q" : @"美女"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSArray * dictArray = responseObject[@"books"];
                
                [subscriber sendNext:dictArray];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"发送失败");
            }];
            
            return nil;
        }];
        
        
        return signal;
        
    }];
    
}
@end
