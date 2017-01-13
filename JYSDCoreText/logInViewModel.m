//
//  logInViewModel.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/1/7.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "logInViewModel.h"

#import "AFNetworking.h"
@interface logInViewModel()

@property (strong, nonatomic,readwrite) RACCommand * command;

@end

@implementation logInViewModel

-(instancetype)init{
    
    if (self = [super init]) {
        
        [self logInDataRequst];
    }
    
    return self;
}


-(void)logInDataRequst{
    
        self.command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
                
                [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q" : @"美女"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    NSNumber * statusDict   =  @1;
                    NSDictionary * dataDict =   @{@"data": responseObject[@"books"]};
                    
                    RACTuple * tuple =RACTuplePack(statusDict,dataDict);
                    
                    [subscriber sendNext:tuple];
                    [subscriber sendCompleted];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    NSNumber * statusDict   =  @0;
                    NSDictionary * dataDict =   @{@"data": @""};
                    RACTuple * tuple =RACTuplePack(statusDict,dataDict);
                    
                    [subscriber sendNext:tuple];
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
        }];
}
@end
