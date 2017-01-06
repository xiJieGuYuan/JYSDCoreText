//
//  JYHeaderView.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/9/3.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "JYHeaderView.h"
#import "UIView+SDAutoLayout.h"


@interface JYHeaderView()
{
    UIImageView *_backgroundImageView;
    UIImageView *_iconView;
    UILabel *_nameLabel;
}

@end

@implementation JYHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}


- (void)setup{
    
    _backgroundImageView = [UIImageView new];
    _backgroundImageView.image = [UIImage imageNamed:@"pbg.jpg"];
    [self addSubview:_backgroundImageView];
    
    _iconView = [UIImageView new];
    _iconView.image = [UIImage imageNamed:@"picon.jpg"];
    _iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconView.layer.borderWidth = 3;
    [self addSubview:_iconView];
    
    _nameLabel = [UILabel new];
    _nameLabel.text = @"JY_iOS";
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:_nameLabel];
    
    
    _backgroundImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 40, 0));
    _iconView.sd_layout.widthIs(70).heightIs(70).rightSpaceToView(self, 15).bottomSpaceToView(self, 20);
    
    
    _nameLabel.tag = 1000;
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    _nameLabel.sd_layout
    .rightSpaceToView(_iconView, 20)
    .bottomSpaceToView(_iconView, -35)
    .heightIs(20);
}

@end
