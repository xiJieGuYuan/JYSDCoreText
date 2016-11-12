//
//  baseViewController.h
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/12.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TitleButton.h"

@interface baseViewController : UIViewController

/**
 *  当前Controller的标题
 *
 *  @return 标题
 */
-(NSString *)controllerTitle;

/**
 *  初始化View
 */
-(void)initView;

/**
 *  按钮操作区的数组元素
 *
 *  @return 数组
 */
-(NSArray *)operateTitleArray;

/**
 *  每个按钮的点击时间
 *
 *  @param btn
 */
-(void)clickBtn : (UIButton *)btn;

@end
