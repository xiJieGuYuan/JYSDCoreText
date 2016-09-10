//
//  TheMessageViewController.m
//  自定义聊天键盘
//
//  Created by 茹茹想 on 16/7/27.
//  Copyright © 2016年 RuXiang&YangTao. All rights reserved.
//

#import "LayoutTextView.h"
//emoji
#import "HCEmojiKeyboard.h"
#define textViewFont [UIFont systemFontOfSize:16]

#define GOODWidth  [UIScreen mainScreen].bounds.size.width
#define GOODHeight [UIScreen mainScreen].bounds.size.height

//static CGFloat maxHeight = 80.0f;
//static CGFloat leftFloat = 5.0f;
//static CGFloat textViewHFloat = 34.0f;
//static CGFloat sendBtnW = 50.0f;
//static CGFloat sendBtnH = 40.0f;

@interface LayoutTextView()<UITextViewDelegate>
{
    CGFloat maxHeight;
    CGFloat leftFloat;
    CGFloat textViewHFloat;
    CGFloat sendBtnW;
    CGFloat sendBtnH;
}
@property (assign, nonatomic) CGFloat superHight;
@property (assign, nonatomic) CGFloat textViewY;
@property (assign, nonatomic) CGFloat sendButtonOffset;
@property (assign, nonatomic) CGFloat keyBoardHight;
@property (assign, nonatomic) CGRect originalFrame;



@property (strong, nonatomic) HCEmojiKeyboard *emojiKeyboard;//emoji


@end

@implementation LayoutTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        maxHeight = GOODWidth/(320.00/80.00);
        leftFloat = GOODWidth/(320.00/5.00);
        textViewHFloat = GOODWidth/(320.00/34.00);
        sendBtnW = GOODWidth/(320.00/50.00);
        sendBtnH = GOODWidth/(320.00/40.00);
        
        _originalFrame = frame;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
        self.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:238/255.0 alpha:1];
        
        UITextView *textView = [[UITextView alloc] init];
        textView.delegate    = self;
        textView.backgroundColor = [UIColor whiteColor];
        textView.font = textViewFont;
        textView.layer.cornerRadius  = GOODWidth/(320.00/5.00);
        textView.layer.masksToBounds = YES;
        textView.layer.borderWidth   = 0.5;
        textView.layer.borderColor   = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor];
        textView.layoutManager.allowsNonContiguousLayout = NO;
        [self addSubview:textView];
        self.textView = textView;
        
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //字体大小
        int send = GOODWidth/(320.00/15.00);
        sendBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:send];
//        [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [sendBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
//        [sendBtn setBackgroundColor:[UIColor whiteColor]];
//        sendBtn.layer.cornerRadius  = 5;
//        sendBtn.layer.masksToBounds = YES;
//        sendBtn.layer.borderWidth   = 0.5;
//        sendBtn.layer.borderColor   = [[UIColor blackColor] CGColor];
        [sendBtn addTarget:self action:@selector(sednBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sendBtn];
        self.sendBtn =  sendBtn;
        
        //git图标按钮按钮
        UIButton *gitbtn = [UIButton buttonWithType:UIButtonTypeSystem];
       
        gitbtn.tag = 2;
        [gitbtn setBackgroundImage:[UIImage imageNamed:@"son_reply_icon"] forState:UIControlStateNormal];
        [gitbtn addTarget:self action:@selector(clickedFaceBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:gitbtn];
        self.gitbtn = gitbtn;

        CGFloat textViewX = leftFloat;
        CGFloat textViewW = Main_Screen_Width-(3*textViewX+sendBtnW);
        CGFloat textViewH = textViewHFloat;
        CGFloat textViewY = (self.frame.size.height-textViewH)*0.5;;
        _textView.frame = CGRectMake(textViewX+35, textViewY, textViewW-30, textViewH);
       
        _textViewY = textViewY;
        _sendButtonOffset = (self.frame.size.height-sendBtnH)*0.5;
        _superHight = self.frame.size.height;
        
        
        
        _emojiKeyboard = [HCEmojiKeyboard sharedKeyboard];
        _emojiKeyboard.showAddBtn = YES;
        [_emojiKeyboard addBtnClicked:^{
            NSLog(@"clicked add btn");
        }];
        [_emojiKeyboard sendEmojis:^{
            
        }];
    }
    return self;
}

- (void)sednBtnAction{

    if (_sendBlock) {
        _sendBlock(_textView);
    }
    
    [_textView resignFirstResponder];
    _textView.text = _placeholder;
    _textView.textColor = [UIColor grayColor];
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textView.text = _placeholder;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat sendBtnX = CGRectGetMaxX(_textView.frame)+leftFloat;
    CGFloat sendBtnY = self.frame.size.height-(_sendButtonOffset+sendBtnH);
    _sendBtn.frame = CGRectMake(sendBtnX, sendBtnY, sendBtnW, sendBtnW);
   
    _gitbtn.frame = CGRectMake(GOODWidth/(320.00/8.00), sendBtnY+GOODWidth/(320.00/8.00), GOODWidth/(320.00/25.00), GOODWidth/(320.00/25.00));
}
//改变键盘状态
- (void)clickedFaceBtn:(UIButton *)button{
    if (button.tag == 1){
        self.textView.inputView = nil;
        [button setBackgroundImage:[UIImage imageNamed:@"son_reply_icon"] forState:UIControlStateNormal];
       
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"son_reply_icon"] forState:UIControlStateNormal];
        [_emojiKeyboard setTextInput:self.textView];
    }
    [self.textView reloadInputViews];
    button.tag = (button.tag+1)%2;
    [self.textView becomeFirstResponder];
}
#pragma mark - == UITextViewDelegate ==
- (void)textViewDidBeginEditing:(UITextView *)textView{
    _textView.text = @"";
    _textView.textColor = [UIColor blackColor];

}
- (void)textViewDidChange:(UITextView *)textView{
    
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height<=frame.size.height) {

    }else{
        if (size.height>=maxHeight){
            size.height = maxHeight;
            textView.scrollEnabled = YES;   // 允许滚动
           
        }else{
            textView.scrollEnabled = NO;    // 不允许滚动
        }
    }
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    
    CGFloat superHeight = CGRectGetMaxY(textView.frame)+_textViewY;
    
    [UIView animateWithDuration:0.15 animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x, Main_Screen_Height-(_keyBoardHight+superHeight), self.frame.size.width, superHeight)];
    }];
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView{

    CGRect r = [textView caretRectForPosition:textView.selectedTextRange.end];
    CGFloat caretY =  MAX(r.origin.y - textView.frame.size.height + r.size.height + 8, 0);
    if (textView.contentOffset.y < caretY && r.origin.y != INFINITY) {
        textView.contentOffset = CGPointMake(0, caretY);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    textView.scrollEnabled = NO;
    CGRect frame = textView.frame;
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, textViewHFloat);
    [textView layoutIfNeeded];
    
    [_textView resignFirstResponder];
    
}

#pragma mark - == 键盘弹出事件 ==
- (void)keyboardWasShow:(NSNotification*)notification{
    
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _keyBoardHight = keyBoardFrame.size.height;
    
    [self translationWhenKeyboardDidShow:_keyBoardHight];
}

- (void)keyboardWillBeHidden:(NSNotification*)notification{
    
    [self translationWhenKeyBoardDidHidden];
}

- (void)translationWhenKeyboardDidShow:(CGFloat)keyBoardHight{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, Main_Screen_Height-(keyBoardHight+self.frame.size.height), self.frame.size.width, self.frame.size.height);
    }];
}

- (void)translationWhenKeyBoardDidHidden{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = _originalFrame;
    }];
}
@end
