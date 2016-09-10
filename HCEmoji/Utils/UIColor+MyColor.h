
//
//  TheMessageViewController.m
//  自定义聊天键盘
//
//  Created by 茹茹想 on 16/7/27.
//  Copyright © 2016年 RuXiang&YangTao. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - inputView
@interface UIColor (MyColor)

+ (UIColor *)backgroundColor;

+ (UIColor *)borderColor;

+ (UIColor *)bigBorderColor;


#pragma mark - SendBtn Color

+ (UIColor *)sendBgNormalColor;

+ (UIColor *)sendBgHighlightedColor;

+ (UIColor *)sendTitleNormalColor;

+ (UIColor *)sendTitleHighlightedColor;

#pragma mark - pageController color

+ (UIColor *)pageIndicatorTintColor;

+ (UIColor *)currentPageIndicatorTintColor;

#pragma mark - EmojiCell

+ (UIColor *)emojiBgColor;

#pragma mark - EmojiToolBar

+ (UIColor *)lineColor;

@end
