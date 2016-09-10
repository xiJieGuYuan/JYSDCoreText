//
//  TheMessageViewController.m
//  自定义聊天键盘
//
//  Created by 茹茹想 on 16/7/27.
//  Copyright © 2016年 RuXiang&YangTao. All rights reserved.
//

#import "ExpandingCell.h"

@implementation ExpandingCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView];
    }
    return self;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _imgView;
}

@end
