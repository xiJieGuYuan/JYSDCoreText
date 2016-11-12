//
//  JYSolidColorButton.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/10/8.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "JYSolidColorButton.h"
#import "UIImage+Color.h"
#import "UIButton+touch.h"


@implementation JYSolidColorButton

-(instancetype)initWithFrame:(CGRect)frame buttonTitle:(NSString *)buttonTitle normalBGColor:(UIColor *)normalBGColor selectBGColor:(UIColor *)selectBGColor normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor buttonFont:(UIFont *)buttonFont cornerRadius:(CGFloat)cornerRadius doneBlock:(SolidColorButtonBlock)doneBlock{
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = cornerRadius;
        
        self.doneBlock = doneBlock;
        self.timeInterval = 2.0f;
        self.titleLabel.font=buttonFont;
        [self setTitle:buttonTitle forState:UIControlStateNormal];
        [self setTitleColor:normalColor forState:UIControlStateNormal];
        [self setTitleColor:selectColor forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageWithColor:normalBGColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:selectBGColor] forState:UIControlStateHighlighted];
        
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)buttonAction:(UIButton *)button
{
    if (self.doneBlock) {
        self.doneBlock(button);
    }
}

+(JYSolidColorButton *)initWithFrame:(CGRect)frame buttonTitle:(NSString *)buttonTile normalBGColor:(UIColor *)normalBGColor selectBGColor:(UIColor *)selectBGColor normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor buttonFont:(UIFont *)buttonFont cornerRadius:(CGFloat)cornerRadius doneBlock:(SolidColorButtonBlock)doneBlock{
    
    JYSolidColorButton * SolidColorButton= [[JYSolidColorButton alloc]initWithFrame:frame buttonTitle:buttonTile normalBGColor:normalBGColor selectBGColor:selectBGColor normalColor:normalColor selectColor:selectColor buttonFont:buttonFont cornerRadius:cornerRadius doneBlock:doneBlock];
    
    return SolidColorButton;
}

@end
