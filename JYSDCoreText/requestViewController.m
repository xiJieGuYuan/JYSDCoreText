//
//  requestViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/1/5.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "requestViewController.h"

#import "requestViewModel.h"
@interface requestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSArray * dataArray;
@property (strong, nonatomic) requestViewModel * viewModel;

@end

@implementation requestViewController


-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}

-(NSArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

-(requestViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[requestViewModel alloc]init];
    }
    return _viewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self createTableView];
    [self getDataFromViewModel];
}
-(void)setNav{
    
    self.title = @"AFNRAC";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)createTableView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID  = @"requestRACVCCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
//    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    
    cell.textLabel.text = self.dataArray[indexPath.row][@"publisher"];
    cell.detailTextLabel.text = self.dataArray[indexPath.row][@"binding"];

    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    
    return cell;
}



-(void)getDataFromViewModel{
    
    RACSignal * signal = [self.viewModel.requestCommand execute:nil];
    
    @weakify(self)
    
    [signal subscribeNext:^(NSArray * array) {
       
        @strongify(self)
        self.dataArray = array;
        [self.tableView reloadData];
    }];
}

@end
