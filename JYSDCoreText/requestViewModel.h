//
//  requestViewModel.h
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/1/5.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface requestViewModel : NSObject

@property (strong, nonatomic) RACCommand * requestCommand;

@end

