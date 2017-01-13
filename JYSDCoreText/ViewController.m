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

#import "racListViewController.h"//6.racListVC

#import "JSPathViewController.h"//7.JSPath

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UITableView * tableView;


@property (strong, nonatomic) NSArray * leftTitleArray;


@end

@implementation ViewController

/*
 
 
 NSArray * titleArray = @[@"杂项",@"friendTrends",@"core animation",@"bezierPath",@"A-GUIDE-TO-iOS-ANIMATION",@"swimmingFish",@"ReactiveCocoa"];
 
 
 
 */


-(NSArray *)leftTitleArray{
    
    if (!_leftTitleArray) {
        _leftTitleArray = @[@"杂项",@"friendTrends",@"core animation",@"bezierPath",@"A-GUIDE-TO-iOS-ANIMATION",@"swimmingFish",@"ReactiveCocoa",@"JSPath"];
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
            [self.navigationController pushViewController:[racListViewController new] animated:YES];
            break;
            
        case 7:
            [self.navigationController pushViewController:[JSPathViewController new] animated:YES];
            break;
            
        default:
            break;
    }
}

@end
