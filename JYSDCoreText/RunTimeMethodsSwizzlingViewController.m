//
//  RunTimeMethodsSwizzlingViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/11/10.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "RunTimeMethodsSwizzlingViewController.h"
#import "NSString+runtimeSwizzling.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "obj.h"
@interface RunTimeMethodsSwizzlingViewController ()

@end

@implementation RunTimeMethodsSwizzlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self testOneFunc];
    [self testTwoFunc];
    
}
///// An opaque type that represents a method in a class definition. 一个类型，代表着类定义中的一个方法
//typedef struct objc_method *Method;
//
///// An opaque type that represents an instance variable.代表实例(对象)的变量
//typedef struct objc_ivar *Ivar;
//
///// An opaque type that represents a category.代表一个分类
//typedef struct objc_category *Category;
//
///// An opaque type that represents an Objective-C declared property.代表OC声明的属性
//typedef struct objc_property *objc_property_t;
//
//// Class代表一个类，它在objc.h中这样定义的  typedef struct objc_class *Class;
//struct objc_class {
//    Class isa  OBJC_ISA_AVAILABILITY;
//
//#if !__OBJC2__
//    Class super_class                                        OBJC2_UNAVAILABLE;
//    const char *name                                         OBJC2_UNAVAILABLE;
//    long version                                             OBJC2_UNAVAILABLE;
//    long info                                                OBJC2_UNAVAILABLE;
//    long instance_size                                       OBJC2_UNAVAILABLE;
//    struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
//    struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
//    struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
//    struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
//#endif
//
//} OBJC2_UNAVAILABLE;

//对对象进行操作的方法一般以object_开头
//对类进行操作的方法一般以class_开头
//对类或对象的方法进行操作的方法一般以method_开头
//对成员变量进行操作的方法一般以ivar_开头
//对属性进行操作的方法一般以property_开头开头
//对协议进行操作的方法一般以protocol_开头
//    class_getInstanceMethod     得到类的实例方法
//    class_getClassMethod          得到类的类方法
-(void)testTwoFunc{
    Method oldFunc = class_getInstanceMethod([obj class], @selector(oldFunc));
    Method newFunc  = class_getInstanceMethod([obj class], @selector(newFunc));
    method_exchangeImplementations(oldFunc, newFunc);
    objc_msgSend([obj new],@selector(oldFunc));
}
-(void)testOneFunc{
    Method  funcOne = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method  funcTwo = class_getInstanceMethod([NSString class], @selector(JY_myLowecaseString));
    method_exchangeImplementations(funcOne, funcTwo);
    
    NSString * string = @"this is old string";
    NSString * newString = [string lowercaseString];
    NSLog(@"----------交换方法之后的数据:%@",newString);
}
-(void)setNav{
    self.view.backgroundColor = [UIColor whiteColor];
}
@end
