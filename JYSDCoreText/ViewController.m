//
//  ViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/8/20.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//
#include <objc/runtime.h>
#import "ViewController.h"
#import "UIView+SDAutoLayout.h"
#import "JYSolidColorButton.h"
#import "yaWeiImageViewController.h"//杂项
#import "JYPengYouQuanViewController.h"//1.朋友圈
#import "coreAnimationListViewController.h"//2.动画列表
#import "bezierPathViewController.h" //3.绘图
#import "A-GuideToIOSAnimationViewController.h"//4
#import "swimmingFishViewController.h"//5.游泳的鱼
#import "racListViewController.h"//6.racListVC
#import "JSPathViewController.h"//7.JSPath
#import "GCDViewController.h"//8.gcd
#import "RunTimeMethodsSwizzlingViewController.h"//9.runtime交换方法
#import "ScanImageViewController.h" //10.二维码扫描
#import "TestALibray.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UITableView * tableView;


@property (strong, nonatomic) NSArray * leftTitleArray;


//@property (strong, nonatomic) NSMutableString * testStr;


@end

@implementation ViewController

-(NSArray *)leftTitleArray{
    
    if (!_leftTitleArray) {
        _leftTitleArray = @[@"杂项",@"friendTrends",
                            @"core animation",@"bezierPath",
                            @"A-GUIDE-TO-iOS-ANIMATION",@"swimmingFish",
                            @"ReactiveCocoa",@"JSPath",
                            @"GCD",@"runtimeSwizzling",
                            @"scanImage",
                            @".a文件的制作"];
    }
    
    return _leftTitleArray;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
     NSLog(@"self.navigationController:%@,数组%@  =====firstObject:%@",self.navigationController,self.navigationController.viewControllers,[self.navigationController.viewControllers firstObject]);

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self createTableView];
    NSLog(@"第一次修改")
}


-(void)setNav{
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /*  创建.json文件两种方法
     
     1.xcode command + N  选择 strings File  创建一个文件 修改后缀名为.json  testjson -->在Xcode中创建
     2.在桌面创建一个文本 修改后缀名为.json,拖进Xcode即可                createInDestop -->在桌面创建
     */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testjson" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"rootDict:%@",rootDict);

}

#pragma mark - 创建tableView
-(void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.leftTitleArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID  = @"viewControllerCellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.leftTitleArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:{
            
            
            GCDViewController * vc = [[GCDViewController alloc]init];
            
            unsigned int outCount = 0;
            Ivar * ivars = class_copyIvarList([UITextField class], &outCount);
            for (unsigned int i = 0; i < outCount; i ++) {
                Ivar ivar = ivars[i];
                const char * name = ivar_getName(ivar);
                const char * type = ivar_getTypeEncoding(ivar);
                NSLog(@"+++++类型为 %s 的 %s ",type, name);
            }
            free(ivars);
            
            
            unsigned int outCountA = 0;
            Ivar * ivarsA = class_copyIvarList([UISearchBar class], &outCountA);
            for (unsigned int i = 0; i < outCountA; i ++) {
                Ivar ivar = ivarsA[i];
                const char * name = ivar_getName(ivar);
                const char * type = ivar_getTypeEncoding(ivar);
                NSLog(@"----类型为 %s 的 %s ",type, name);
            }
            free(ivars);
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            JYPengYouQuanViewController * vc = [[JYPengYouQuanViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
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
            [self.navigationController pushViewController:[racListViewController new] animated:YES];
            break;
            
        case 7:
            [self.navigationController pushViewController:[JSPathViewController new] animated:YES];
            break;
            
        case 8:
            [self.navigationController pushViewController:[RunTimeMethodsSwizzlingViewController new] animated:YES];
            break;
            
        case 9:
            
            [self.navigationController pushViewController:[ScanImageViewController new] animated:YES];
            break;
            
        case 10:
            [self.navigationController pushViewController:[ScanImageViewController new] animated:YES];
            break;
            
        case 11:{
            TestALibray * libray = [[TestALibray alloc]init];
            [libray ouputStringWithInputName:@"测试.a文件的输出内容"];
        }
            break;
            
            
        default:
            break;
    }
}

@end
