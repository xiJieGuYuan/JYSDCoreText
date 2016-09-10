//
//  TheMessageViewController.m
//  自定义聊天键盘
//
//  Created by 茹茹想 on 16/7/27.
//  Copyright © 2016年 RuXiang&YangTao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SendBlock)(void);
typedef void(^SelectedBlock)(NSInteger row);
typedef void(^AddBlock)(void);

@interface EmojiToolBar : UIView

#pragma mark - -----Properties-----
@property (strong, nonatomic) UIButton *sendBtn;
@property (strong, nonatomic) SendBlock sendBlock;
@property (strong, nonatomic) SelectedBlock selectedBlock;
@property (strong, nonatomic) AddBlock addBlock;
@property (assign, nonatomic) BOOL showAddBtn;


#pragma mark - -----Methods-----
/**
 *初始化一个EmojiToolBar对象
 *@param   初始化的对象   宽高一定，不可修改
 */
+ (EmojiToolBar *)sharedToolBar;

- (void)sendEmojis:(SendBlock)block;

- (void)selectedToolBar:(SelectedBlock)block;

- (void)addBtnClicked:(AddBlock)block;

@end
