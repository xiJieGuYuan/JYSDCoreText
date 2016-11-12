//
//  JYSolidColorButton.h
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/10/8.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SolidColorButtonBlock)(UIButton * button);


@interface JYSolidColorButton : UIButton

@property (nonatomic,copy) SolidColorButtonBlock doneBlock;


-(instancetype)initWithFrame:(CGRect)frame buttonTitle:(NSString *)buttonTitle normalBGColor:(UIColor *)normalBGColor selectBGColor:(UIColor *)selectBGColor normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor buttonFont:(UIFont *)buttonFont cornerRadius:(CGFloat )cornerRadius doneBlock:(SolidColorButtonBlock)doneBlock;



+(JYSolidColorButton *)initWithFrame:(CGRect)frame buttonTitle:(NSString *)buttonTile normalBGColor:(UIColor *)normalBGColor selectBGColor:(UIColor *)selectBGColor normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor buttonFont:(UIFont *)buttonFont cornerRadius:(CGFloat )cornerRadius doneBlock:(SolidColorButtonBlock)doneBlock;



@end
