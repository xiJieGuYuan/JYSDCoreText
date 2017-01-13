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


#import "logInViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


//#import "requestViewModel.h"

@interface logInRACViewController ()

@property (strong, nonatomic) UITextField * userNameField;
@property (strong, nonatomic) UITextField * passWordField;
@property (strong, nonatomic) UIButton * signInButton;

@property (strong, nonatomic) UILabel * signInFailureText;


@property (strong, nonatomic) signInService * signInObj;

//@property (nonatomic,assign) BOOL userNameIsValid;
//@property (assign, nonatomic) BOOL passWordIsValid;


//@property (strong, nonatomic) logInViewModel * viewModel;


@property (strong, nonatomic) logInViewModel * viewModel;


@end

@implementation logInRACViewController


-(logInViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[logInViewModel alloc]init];
    }
    
    return _viewModel;
}

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
    
    _signInFailureText.text = @"Invalid credentials";
    _signInFailureText.textColor = [UIColor redColor];
    _signInFailureText.hidden = NO;
    
    
    _signInButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _signInButton.layer.borderWidth = 1.0;
    _signInButton.layer.cornerRadius = 3.0;
    _signInButton.layer.masksToBounds = YES;
    
    [_signInButton setTitle:@"sigIn" forState:UIControlStateNormal];
    [self.signInButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}


-(void)createSignal{
    
    @weakify(self)//block return cycle
    
    //1.text  map--->BOOL
    RACSignal * validUserNameSignal = [[[[_userNameField.rac_textSignal map:^id(NSString * text) {
        @strongify(self)
        return @([self isValidUsernameOrValidPassWord:text]);
    }] setNameWithFormat:@"userNameSignal"] map:^id(NSNumber * userNameValid) {
        
        return [userNameValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
        
    }] doNext:^(UIColor * backgroundColor) {
        @strongify(self)
        self.userNameField.backgroundColor = backgroundColor;
    }];
    
    RACSignal * validPassWordSignal = [[[[_passWordField.rac_textSignal map:^id(NSString *  text) {
        @strongify(self)
        return @([self isValidUsernameOrValidPassWord:text]);
    }] setNameWithFormat:@"passWordSignal"] map:^id(NSNumber * passWordValid) {
        
        return [passWordValid boolValue] ? [UIColor clearColor] : [UIColor cyanColor];
    }] doNext:^(UIColor * backgroundColor) {
        
        @strongify(self)
        self.passWordField.backgroundColor = backgroundColor;
    }];
    
    
//    //2.BOOL map ---> UIColor
//   RAC(self.userNameField,backgroundColor) = [validUserNameSignal map:^id(NSNumber * userNameValid) {
//      
//       return [userNameValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
//   }];
//    
//    RAC(self.passWordField,backgroundColor) = [validPassWordSignal map:^id(NSNumber * passWordValid) {
//       
//        return [passWordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
//    }];
    
    
    //3.聚合信号 combineLastest

//    [[RACSignal combineLatest:@[validUserNameSignal,validPassWordSignal] reduce:^id (NSNumber * userNameValid,NSNumber * passWordValid){
//        
//        return @([userNameValid boolValue] && [passWordValid boolValue]);
//    }]  subscribeNext:^(NSNumber *  signUpActive) {
//        @strongify(self)
//        self.signInButton.enabled = [signUpActive boolValue];
//
//    }];
    
    
    [[[RACSignal combineLatest:@[validUserNameSignal,validPassWordSignal] reduce:^id (UIColor * userNameValid,UIColor * passWordValid){
        
        return @([userNameValid isEqual:[UIColor clearColor]] && [passWordValid isEqual:[UIColor clearColor]]);
    }] doNext:^(NSNumber * buttonNumber) {
        
        @strongify(self)
        self.signInButton.backgroundColor =  [buttonNumber boolValue] ? [UIColor orangeColor] : [UIColor lightGrayColor];
        self.signInButton.enabled = [buttonNumber boolValue];
        
    }] subscribeNext:^(NSNumber *  signUpActive) {
        @strongify(self)
        self.signInButton.enabled = [signUpActive boolValue];
    }];

    
    //throttle 后面是个时间 表示rac_textSignal发送消息，0.3秒内没有再次发送就会相应，若是0.3内又发送消息了，便会在新的信息处重新计时
    //distinctUntilChanged 表示两个消息相同的时候，只会发送一个请求
    //ignore 表示如果消息和ignore后面的消息相同，则会忽略掉这条消息，不让其发送
    //[[[[[[textField.rac_textSignal throttle:1] distinctUntilChanged] ignore:@""] map:^id(id value) {
    
    
//    [[[[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] distinctUntilChanged]
//    [[[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
//                                                                                //doNext: 跟在按钮点击事件后面,没有返回值.doNext是附加操作,并不改变事件本身
//        @strongify(self)
////        self.signInButton.enabled = NO;
//        self.signInFailureText.hidden = YES;
//        
//        
//        NSLog(@"点击按钮:%@",x);
//        
//    }]flattenMap:^id(id x) {//flattenMap 信号中产生新的信号  Map 创建一个和之前一样的信号,不同的是新信号传递的值被改变(value)
//                            //map方法，根据原信号创建了一个新的信号，并且变换了信号的输出值。这两个信号具有明显的先后顺序关系(原始信号在前,map的新信号在后)
//                            //flattenMap方法，直接生成了一个新的信号，这两个信号并没有先后顺序关系，属于同层次的平行关系。这也许就是为什么会被命名为flattenMap
//        @strongify(self)
//        //return [self signInSignal];
//        
//        
//        
//        return [self.viewModel.command execute:@""] ;
//    }]subscribeNext:^(RACTuple * tuple) {
//        @strongify(self)
//        
//        
//        RACTupleUnpack(NSNumber * status,NSArray * array) = tuple;
//        
//        
//        NSInteger arrayCount = array.count;
//        
//        BOOL success = [status boolValue];
//        self.signInFailureText.hidden = success;
//        
//        if (success) {
//            
//         UIAlertView * alertView  = [[UIAlertView alloc]initWithTitle:@"登录成功!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
//         [alertView show];
//            
//        }
//    }];
    
//    
 [[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x ) {
        @strongify(self)
    
    
     [[self.viewModel.command execute:nil] subscribeNext:^(RACTuple * tuple) {
         
         @strongify(self)
         
         RACTupleUnpack(NSNumber * status,NSArray * array) = tuple;
         NSLog(@"arrayCount:%ld",array.count);
         
         BOOL success = [status boolValue];
         self.signInFailureText.hidden = success;
         
         if (success) {
             
             UIAlertView * alertView  = [[UIAlertView alloc]initWithTitle:@"登录成功!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
             [alertView show];
         }else{
             
             UIAlertView * alertView  = [[UIAlertView alloc]initWithTitle:@"登录超时!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
             [alertView show];
             
         }
     }];
    

     
    }];

}



//-(RACSignal *)signInSignal{
//
//
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        
//        [self.signInObj signInWithUserName:self.userNameField.text password:self.passWordField.text complete:^(BOOL success) {
//            
//            [subscriber sendNext:@(success)];
//            [subscriber sendCompleted];
//        }];
//        
//        return nil;
//    }];
//}


-(BOOL)isValidUsernameOrValidPassWord:(NSString *)text{
    
    return text.length > 3 ? 1 : 0;
}

-(void)setCommonTextField:(UITextField *)textField placeholder:(NSString *)placeholder{
    
    textField.placeholder = placeholder;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textField.backgroundColor = [UIColor yellowColor];
    textField.layer.borderWidth = 1.0;
    textField.layer.cornerRadius = 3.0;
    textField.layer.masksToBounds = YES;
}
@end
