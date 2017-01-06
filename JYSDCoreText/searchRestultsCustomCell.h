//
//  searchRestultsCustomCell.h
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class tweetsModel;
@interface searchRestultsCustomCell : UITableViewCell

@property (strong, nonatomic) UIImageView * twitterAvatarView;
@property (strong, nonatomic) UILabel * twitterStatusText;
@property (strong, nonatomic) UILabel * twitterUserNameText;

+(instancetype)cellWithTableView:(UITableView *)tableView;


-(void)setCustomCellWithModel:(tweetsModel *)model;

@end
