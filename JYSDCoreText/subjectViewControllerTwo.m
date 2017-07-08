//
//  subjectViewControllerTwo.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/1/13.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "subjectViewControllerTwo.h"

@interface subjectViewControllerTwo ()

@end

@implementation subjectViewControllerTwo


//-(RACSubject *)subject{
//    
//    if(!_subject ){
//        
//        _subject = [RACSubject subject];
//    }
//    
//    return _subject;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNav];
    
    [self createPopButton];
}

-(void)setNav{
    
    self.title = @"RACSubjectTwo";
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)createPopButton{
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 40)];
    [self.view addSubview:button];
    
    button.center = self.view.center;
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"popUpVC" forState:UIControlStateNormal];
    
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
       @strongify(self)
        
        RACTuple * tuple = RACTuplePack(@"RACSubject",[UIColor cyanColor]);
        
        [self.subject sendNext:tuple];
        [self.navigationController popViewControllerAnimated:YES];
    }];
 
}
@end
