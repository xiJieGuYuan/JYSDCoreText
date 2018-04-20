//
//  NSString+runtimeSwizzling.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/11/10.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "NSString+runtimeSwizzling.h"

@implementation NSString (runtimeSwizzling)
-(NSString *)JY_myLowecaseString{
    
    NSString * lowercase = [self  JY_myLowecaseString];
    NSLog(@"%@ => %@",self,lowercase);
    return lowercase;
}
@end
