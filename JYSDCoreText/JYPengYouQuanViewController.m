//
//  JYPengYouQuanViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/9/3.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//


#define CELLID NSStringFromClass([JYPengYouQuanCustomCell class])
#import "JYPengYouQuanViewController.h"

#import "JYHeaderView.h"//头部视图
#import "JYPengYouQuanModel.h"//数据模型
#import "JYPengYouQuanCustomCell.h"


#import "UITableView+SDAutoTableViewCellHeight.h"

@interface JYPengYouQuanViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *modelsArray;


@end

@implementation JYPengYouQuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self createTableView];
    [self createTableViewHeaderView];
    [self creatModelsWithCount:10];
}

#pragma mark - 1.设置导航栏相关内容
-(void)setNav{
    
    self.title = @"朋友圈";

    
    //第一种方法
    UIButton * addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [addButton setTitle:@"发表状态" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    addButton.backgroundColor = [UIColor yellowColor];
    [addButton addTarget:self action:@selector(addNewContent) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * myButton = [[UIBarButtonItem alloc]initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = myButton ;
    
    //第二种方法
//    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"发表状态" style:UIBarButtonItemStylePlain target:self action:@selector(addNewContent)];
//    self.navigationItem.rightBarButtonItem = myButton;
}

-(void)addNewContent{
    
    
    
}

#pragma mark - 2.创建tableView
-(void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - 2.1创建tableView头部视图
-(void)createTableViewHeaderView{
    
    JYHeaderView * headerView = [[JYHeaderView alloc]initWithFrame:CGRectMake(0, 0, 0, 260)];
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView registerClass:[JYPengYouQuanCustomCell class] forCellReuseIdentifier:CELLID];
}

#pragma mark - 3.tableViewDataSourceDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modelsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    JYPengYouQuanCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    cell.model = self.modelsArray[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CGFloat cellHeight = [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width tableView:self.tableView];
    
    
    return cellHeight;

}

- (void)creatModelsWithCount:(NSInteger)count
{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"JY_iOS",
                            @"XCode-7.2",
                            @"effective-code",
                            @"西结古原",
                            @"react-native"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        JYPengYouQuanModel *model = [JYPengYouQuanModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.content = textArray[contentRandomIndex];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(10);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
        [self.modelsArray addObject:model];
    }
}
@end
