//
//  coreAnimationListViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/12.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "coreAnimationListViewController.h"

#import "baseAnimationViewController.h"
#import "keyFrameAnimationViewController.h"
#import "groupAnimationViewController.h"

@interface coreAnimationListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView * tableView;


@property (strong, nonatomic) NSArray * leftTextArray;//列表title

@end



@implementation coreAnimationListViewController


-(NSArray *)leftTextArray{
    
    if (!_leftTextArray) {
        _leftTextArray = @[@"基础动画",@"关键帧动画",@"组动画",@"过渡动画",@"仿射动画",@"综合案例"];
    }
    return _leftTextArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self createTableView];
}

-(void)setNav{
    
    self.title = @"动画列表";
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    return self.leftTextArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID  = @"coreAnimationListCellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.leftTextArray[indexPath.row];
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
        case 0://基础动画
            [self.navigationController pushViewController:[baseAnimationViewController new] animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:[keyFrameAnimationViewController new] animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:[groupAnimationViewController new] animated:YES];
            break;
            
        default:
            break;
    }
    
}

@end
