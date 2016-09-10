//
//  TheMessageViewController.m
//  自定义聊天键盘
//
//  Created by 茹茹想 on 16/7/27.
//  Copyright © 2016年 RuXiang&YangTao. All rights reserved.
//


#import <UIKit/UIKit.h>

//获取当前设备的尺寸
#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define ScreenSize    [[UIScreen mainScreen] bounds].size

//以iphone5为基础 坐标都以iphone5为基准 进行代码的适配
#define ratio         [[UIScreen mainScreen] bounds].size.width/320.0

//设置图片
#define ImgName(imagename) [UIImage imageNamed:@"delete"]

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@end
