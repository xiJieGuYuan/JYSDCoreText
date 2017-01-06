//
//  searchResultsTableViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "searchResultsTableViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "tweetsModel.h"
#import "searchRestultsCustomCell.h"


#import "UIImageView+WebCache.h"
@interface searchResultsTableViewController ()

@property (strong, nonatomic) NSArray * tweets;

@end

@implementation searchResultsTableViewController


-(NSArray *)tweets{
    
    if (!_tweets) {
        _tweets = [NSArray array];
    }
    return _tweets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}



-(void)displayTweets:(NSArray *)tweets{
    
    self.tweets = tweets;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    searchRestultsCustomCell * cell = [searchRestultsCustomCell cellWithTableView:tableView];
    tweetsModel * model = self.tweets[indexPath.row];
    
    [cell setCustomCellWithModel:model];
    
//    cell.twitterStatusText.text = model.status;
//    cell.twitterUserNameText.text = [NSString stringWithFormat:@"@%@",model.username];
//    
//    
//    cell.twitterAvatarView.image = nil;
//    [[[[self signalForLoadingImage:model.profileImageUrl] takeUntil:cell.rac_prepareForReuseSignal ]deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(UIImage * image) {
//        cell.twitterAvatarView.image = image;
//    }];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}


////异步加载图片
//-(RACSignal *)signalForLoadingImage:(NSString * )imageUrl{
//    
//    RACScheduler *scheduler = [RACScheduler
//                               schedulerWithPriority:RACSchedulerPriorityBackground];
//    
//    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//        UIImage *image = [UIImage imageWithData:data];
//        [subscriber sendNext:image];
//        [subscriber sendCompleted];
//        return nil;
//    }] subscribeOn:scheduler];
//}


@end
