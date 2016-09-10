//
//  TheMessageViewController.m
//  自定义聊天键盘
//
//  Created by 茹茹想 on 16/7/27.
//  Copyright © 2016年 RuXiang&YangTao. All rights reserved.
//


#import <UIKit/UIKit.h>

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

@interface LayoutTextView : UIView
@property (weak, nonatomic) UITextView *textView;
@property (weak, nonatomic) UIButton *sendBtn;
@property (weak, nonatomic) UIButton *gitbtn;
@property (copy, nonatomic) NSString *placeholder;

@property (copy, nonatomic) void (^(sendBlock)) (UITextView *textView);
@end
