//
//  JYPengYouQuanCustomCell.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/9/3.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "JYPengYouQuanCustomCell.h"

#import "UIView+SDAutoLayout.h"
#import "JYPengYouQuanModel.h"
#import "SDWeiXinPhotoContainerView.h"

@interface JYPengYouQuanCustomCell()



@end


@implementation JYPengYouQuanCustomCell
{
    UIImageView * _iconView;
    UILabel * _nameLable;
    UILabel * _contentLabel;
    SDWeiXinPhotoContainerView * _picContainerView;
    UILabel * _timeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup{
    
    _iconView = [UIImageView new];
    
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:14];
    _nameLable.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    
    _picContainerView = [SDWeiXinPhotoContainerView new];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    
    NSArray * views = @[_iconView,_nameLable,_contentLabel,_picContainerView,_timeLabel];
   [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     
       [self.contentView addSubview:obj];
            
    }];
    
    UIView * contentView = self.contentView;
    
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    
    _nameLable.sd_layout.leftSpaceToView(_iconView,margin).topEqualToView(_iconView).heightIs(18);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    _nameLable.backgroundColor = [UIColor orangeColor];
    
    
    _contentLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    
    _picContainerView.sd_layout.leftEqualToView(_contentLabel);
    
    _timeLabel.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_picContainerView, margin)
    .heightIs(15)
    .autoHeightRatio(0);
    
    
    [self setupAutoHeightWithBottomView:_timeLabel bottomMargin:margin + 5];
    
}


-(void)setModel:(JYPengYouQuanModel *)model{
    
    _model = model;
    
    _iconView.image = [UIImage imageNamed:model.iconName];
    _nameLable.text = model.name;
    _contentLabel.text = model.content;
    _picContainerView.picPathStringsArray = model.picNamesArray;
    
    
    CGFloat picContainerTopMargin = 0;
    
    if (model.picNamesArray.count) {
        
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_contentLabel,picContainerTopMargin);
    
    _timeLabel.text = @"1分钟前";
    
}


@end
