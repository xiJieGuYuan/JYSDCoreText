//
//  obj.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/11/10.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "obj.h"

@implementation obj

-(void)oldFunc{
     NSLog(@"我是旧的方法");
}

-(void)newFunc{
    NSLog(@"我是新的方法");
}
//-(void)load{
//    Method funcOld  = class_getInstanceMethod([self class], @selector(oldFunc));
//    Method funcNew  = class_getInstanceMethod([self class], @selector(newFunc));
//    method_exchangeImplementations(funcOld, funcNew);
//}
@end
