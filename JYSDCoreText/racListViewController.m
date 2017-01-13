//
//  racListViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/13.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "racListViewController.h"

#import "reactiveCocoaViewController.h"//funcRAC

#import "logInRACViewController.h"//loginVC
#import "searchFromViewController.h"//searchVC


#import "targetActionRACViewController.h"//targetActionVC
#import "delegateRACViewController.h" //delegateRAC
#import "blockRACViewController.h"//blockRAC
#import "notificaitonRACViewController.h"//notificationRAC
#import "kvoRACViewController.h" //kvoRAC
#import "requestViewController.h"//afnRAC

#import "commandViewController.h"//RACCommand



@interface racListViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) UITableView * tableView;

@property (strong, nonatomic) NSArray * leftArray;

@end

@implementation racListViewController


-(NSArray *)leftArray{
    
    if (!_leftArray) {
        _leftArray = @[@"funcRAC",@"logInRAC",@"TwitterInstantRAC",@"targetActionRAC",@"delegateRAC",@"blockRAC",@"notificationRAC",@"kvoRAC",@"afnRAC",@"RACCommand"];
    }
    return _leftArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self createTableView];
}

-(void)setNav{
    
    self.title = @"learnListRAC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];

}

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
    
    return self.leftArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID  = @"racListCellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.leftArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
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
            [self.navigationController pushViewController:[reactiveCocoaViewController new] animated:YES];
            break;
            
            case 1:
            [self.navigationController pushViewController:[logInRACViewController new] animated:YES];
            break;
            
            case 2:
            [self.navigationController pushViewController:[searchFromViewController new] animated:YES];
            break;
            
            case 3:
            [self.navigationController pushViewController:[targetActionRACViewController new] animated:YES];
            break;
            
            
            case 4:
            [self.navigationController pushViewController:[delegateRACViewController new] animated:YES];
            break;
            
            case 5:
            [self.navigationController pushViewController:[blockRACViewController new] animated:YES];
            break;
            
            case 6:
            [self.navigationController pushViewController:[notificaitonRACViewController new] animated:YES];
            break;
            
            case 7:
            [self.navigationController pushViewController:[kvoRACViewController new] animated:YES];
            
            case 8:
            [self.navigationController pushViewController:[requestViewController new] animated:YES];
            break;
            
            case 9:
            [self.navigationController pushViewController:[commandViewController new] animated:YES];
            break;
            
        default:
            break;
    }
}

@end
