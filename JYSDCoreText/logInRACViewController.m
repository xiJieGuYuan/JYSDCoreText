//
//  logInRACViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/13.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "logInRACViewController.h"
#import "UIView+SDAutoLayout.h"
#import "signInService.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface logInRACViewController ()

@property (strong, nonatomic) UITextField * userNameField;
@property (strong, nonatomic) UITextField * passWordField;
@property (strong, nonatomic) UIButton * signInButton;

@property (strong, nonatomic) UILabel * signInFailureText;


@property (strong, nonatomic) signInService * signInObj;





//@property (nonatomic,assign) BOOL userNameIsValid;
//@property (assign, nonatomic) BOOL passWordIsValid;


@end

@implementation logInRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self createSubViews];
    [self createSignal];
    
}


-(void)setNav{
    
    self.title = @"logInRAC";
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)createSubViews{
    
    self.signInObj = [[signInService alloc]init];
    
    self.userNameField    = [[UITextField alloc]init];
    self.passWordField    = [[UITextField alloc]init];
    self.signInButton     =  [[UIButton alloc]init];
    self.signInFailureText = [[UILabel alloc]init];
    [self.view sd_addSubviews:@[_userNameField,_passWordField,_signInButton,_signInFailureText]];
    
    
    self.userNameField.sd_layout
    .topSpaceToView(self.view,100)
    .centerXEqualToView(self.view)
    .widthIs(250)
    .heightIs(40);
    
    self.passWordField.sd_layout
    .topSpaceToView(_userNameField,20)
    .centerXEqualToView(self.view)
    .widthIs(250)
    .heightIs(40);
    
    self.signInFailureText.sd_layout
    .leftEqualToView(_passWordField)
    .topSpaceToView(_passWordField,20)
    .widthIs(150)
    .heightIs(30);
    
    self.signInButton.sd_layout
    .topSpaceToView(_passWordField,20)
    .leftSpaceToView(_signInFailureText,10)
    .widthIs(90)
    .heightIs(30);
    
    
    [self setCommonTextField:_userNameField placeholder:@"username"];
    [self setCommonTextField:_passWordField placeholder:@"password"];
    
    self.signInFailureText.text = @"Invalid credentials";
    self.signInFailureText.textColor = [UIColor redColor];
    self.signInFailureText.hidden = NO;
    
    
    self.signInButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.signInButton.layer.borderWidth = 1.0;
    self.signInButton.layer.cornerRadius = 3.0;
    self.signInButton.layer.masksToBounds = YES;
    
    [self.signInButton setTitle:@"sigIn" forState:UIControlStateNormal];
    [self.signInButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self.signInButton addTarget:self action:@selector(signInButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    self.signInButton.enabled = NO;
    
}


-(void)createSignal{
    
    
    RACSignal * validUserNameSignal = [self.userNameField.rac_textSignal map:^id(NSString * text) {
        
        return @([self isValidUsernameOrValidPassWord:text]);
    }];
    
    
    RACSignal * validPassWordSignal = [self.passWordField.rac_textSignal map:^id(NSString *  text) {
        
        return @([self isValidUsernameOrValidPassWord:text]);
    }];
    
    
   RAC(self.userNameField,backgroundColor) = [validUserNameSignal map:^id(NSNumber * userNameValid) {
      
       return [userNameValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
   }];
    
    RAC(self.passWordField,backgroundColor) = [validPassWordSignal map:^id(NSNumber * passWordValid) {
       
        return [passWordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    [[RACSignal combineLatest:@[validUserNameSignal,validPassWordSignal] reduce:^id (NSNumber * userNameValid,NSNumber * passWordValid){
        
        return @([userNameValid boolValue] && [passWordValid boolValue]);
    }]  subscribeNext:^(NSNumber *  signUpActive) {
        
        self.signInButton.enabled = [signUpActive boolValue];

    }];

    
    [[[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        
        self.signInButton.enabled = NO;
        self.signInFailureText.hidden = YES;
        
        
//        NSLog(@"输入的信息:%@",x);
    }]flattenMap:^id(id x) {
        return [self signInSignal];
    }]subscribeNext:^(NSNumber * signedIn) {

        BOOL success = [signedIn boolValue];
        self.signInFailureText.hidden = success;
        
        if (success) {
            
         UIAlertView * alertView  = [[UIAlertView alloc]initWithTitle:@"登录成功!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
            
         [alertView show];
            
            
            self.signInButton.backgroundColor = [UIColor cyanColor];
        }
    
    }];
    
}

-(RACSignal *)signInSignal{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self.signInObj signInWithUserName:self.userNameField.text password:self.passWordField.text complete:^(BOOL success) {
            
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}


-(BOOL)isValidUsernameOrValidPassWord:(NSString *)text{
    
    return text.length > 3 ? 1 : 0;
}

////点击用户名
//-(void)usernameTextFieldChanged{
//    
////    self.userNameIsValid = self.userNameField.text.length > 3 ? 1 : 0;
//    [self updateUIState];
//}
//
////点击密码
//-(void)passwordTextFieldChanged{
//    
////    self.passWordIsValid =  self.passWordField.text.length > 3 ? 1 : 0;
//    [self updateUIState];
//}
//

//updateUIStats
//-(void)updateUIState{
    
//    self.userNameField.backgroundColor = self.userNameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//    self.passWordField.backgroundColor = self.passWordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//    self.signInButton.enabled = self.userNameIsValid && self.passWordIsValid;
//}

//点击登录按钮触发事件
//-(void)signInButtonTouched{
//        NSLog(@"点击登录按钮");
//    
//    self.signInButton.enabled = NO;
////    self.sigInFailureText.hidden = YES;
//    
//    
//    [self.signInObj signInWithUserName:self.userNameField.text password:self.passWordField.text complete:^(BOOL success) {
//        
//        self.signInButton.enabled = YES;
//        self.sigInFailureText.hidden = YES;
//        
//        if (success) {
//            
//            UIAlertView * alertView  = [[UIAlertView alloc]initWithTitle:@"登录成功!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
//            
//            [alertView show];
//        }
//    }];
//    
//}

-(void)setCommonTextField:(UITextField *)textField placeholder:(NSString *)placeholder{
    
    textField.placeholder = placeholder;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textField.backgroundColor = [UIColor yellowColor];
    textField.layer.borderWidth = 1.0;
    textField.layer.cornerRadius = 3.0;
    textField.layer.masksToBounds = YES;
}
@end
