//
//  searchRestultsCustomCell.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "searchRestultsCustomCell.h"

#import "UIView+SDAutoLayout.h"

@interface searchRestultsCustomCell()

@end

@implementation searchRestultsCustomCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    
    static NSString *identifier = @"searchRestultsCustomCellID";
    searchRestultsCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[searchRestultsCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//   searchRestultsCustomCell *     cell = [[searchRestultsCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
        [self setLayoutSubView];
    }
    return self;
}

- (void)setupSubviews {
    
    self.twitterAvatarView = [[UIImageView alloc]init];
    self.twitterStatusText = [[UILabel alloc]init];
    self.twitterUserNameText = [[UILabel alloc]init];
    
    [self.contentView  sd_addSubviews:@[_twitterAvatarView,_twitterStatusText,_twitterUserNameText]];
}

-(void)setLayoutSubView{
    
    _twitterAvatarView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .widthIs(60)
//    .heightIs(60);
    .heightEqualToWidth();
    
    _twitterStatusText.sd_layout
    .leftSpaceToView(_twitterAvatarView,10)
    .topEqualToView(_twitterAvatarView)
    .rightSpaceToView(self.contentView,10)
    .heightIs(20);
    
    
    _twitterUserNameText.sd_layout
    .leftEqualToView(_twitterStatusText)
    .topSpaceToView(_twitterStatusText,20)
    .rightSpaceToView(self.contentView,10)
    .heightIs(20);
    
    
    _twitterAvatarView.layer.borderColor = [UIColor redColor].CGColor;
    _twitterAvatarView.layer.borderWidth = 1.0;
    
    _twitterStatusText.font= [UIFont systemFontOfSize:14.0];
    _twitterUserNameText.font = [UIFont systemFontOfSize:14.0];

}

@end
