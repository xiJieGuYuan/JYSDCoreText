//
//  ViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/8/20.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "ViewController.h"

#import "UIView+SDAutoLayout.h"
#import "JYSolidColorButton.h"

#import "yaWeiImageViewController.h"//杂项

#import "JYPengYouQuanViewController.h"//1.朋友圈
#import "coreAnimationListViewController.h"//2.动画列表
#import "bezierPathViewController.h" //3.绘图
#import "A-GuideToIOSAnimationViewController.h"//4

#import "swimmingFishViewController.h"//5.游泳的鱼

#import "reactiveCocoaViewController.h"//6.reactiveCocoa

@interface ViewController ()

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
     NSLog(@"self.navigationController:%@,数组%@  =====firstObject:%@",self.navigationController,self.navigationController.viewControllers,[self.navigationController.viewControllers firstObject]);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCustomContents];
    
   
    /*  创建.json文件两种方法
     
        1.xcode command + N  选择 strings File  创建一个文件 修改后缀名为.json  testjson -->在Xcode中创建
        2.在桌面创建一个文本 修改后缀名为.json,拖进Xcode即可                createInDestop -->在桌面创建
     */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testjson" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}

-(void)createCustomContents{
    
    __weak typeof(self) weakSelf = self;
     NSArray * titleArray = @[@"杂项",@"friendTrends",@"core animation",@"bezierPath",@"A-GUIDE-TO-iOS-ANIMATION",@"swimmingFish",@"ReactiveCocoa"];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        JYSolidColorButton  * button = [JYSolidColorButton initWithFrame:CGRectNull buttonTitle:titleArray[i] normalBGColor:[UIColor orangeColor] selectBGColor:[UIColor orangeColor] normalColor:nil selectColor:nil buttonFont:[UIFont systemFontOfSize:14.0f] cornerRadius:3.0f doneBlock:^(UIButton *button) {
            
            NSLog(@"点击按钮的button.tag:%ld",button.tag);
            [weakSelf clickAllButton:button];

        }];
        [self.view addSubview:button];
        button.sd_layout.centerXEqualToView(self.view).widthIs(250).heightIs(30).topSpaceToView(self.view,100 + 60 * i);
        button.tag = i;
    }
}

-(void)clickAllButton:(UIButton *)button{
    
    switch (button.tag) {
        case 0:
            [self.navigationController pushViewController:[yaWeiImageViewController new] animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:[JYPengYouQuanViewController new] animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:[coreAnimationListViewController new] animated:YES];
            break;
        
        case 3:
            [self.navigationController pushViewController:[bezierPathViewController new] animated:YES];
            break;
        
        case 4:
            [self.navigationController pushViewController:[A_GuideToIOSAnimationViewController new] animated:YES];
            break;
            
            
        case 5:
            [self.navigationController pushViewController:[swimmingFishViewController new] animated:YES];
            break;
            
        case 6:
            [self.navigationController pushViewController:[reactiveCocoaViewController new] animated:YES];
            break;
        
        default:
            break;
    }
}
@end
