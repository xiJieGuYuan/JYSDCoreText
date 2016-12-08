//
//  affineTransformViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "affineTransformViewController.h"
#import "configHeader.h"

@interface affineTransformViewController ()


@property (strong, nonatomic) UIImageView * demoView;

@end

@implementation affineTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self createDemoView];
}
-(void)setNav{
    
    self.title = @"仿射变换";
}

-(void)createDemoView{
    
    self.demoView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT/2 -50, 100, 100)];
    _demoView.image = [UIImage imageNamed:@"京东京豆"];
    _demoView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_demoView];
}

/*
//UI开发技巧，重写setter方法和Code Block Evaluation C Extension语法
- (UIView *)demoView{
    if (!_demoView) {
        _demoView = ({
            UIView *demoView = [[UIView alloc] initWithFrame:({
                CGRect rect = CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100,100 ,100 );
                rect;
            })];
            demoView.backgroundColor = [UIColor redColor];
            demoView;
        });
    }
    return _demoView;
}
*/

//-(UIView *)demoView{
//    
//    if (!_demoView) {
//        _demoView = ({
//            
//            UIView * demoView = [[UIView alloc]initWithFrame:({
//            
//                CGRect rect = CGRectMake(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT/2 -50, 100, 100);
//                 rect;
//            })];
//            demoView.backgroundColor = [UIColor cyanColor];
//            demoView;
//            
//            
//        });
//    }
//    
//    return _demoView;
//}


-(NSArray *)operateTitleArray{
    
    return @[@"位移",@"缩放",@"旋转",@"组合",@"反转"];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self positionAnimation];
            break;
        case 1:
            [self scaleAnimation];
            break;
        case 2:
            [self rotateAnimation];
            break;
        case 3:
            [self combinationAnimation];
            break;
        case 4:
            [self invertAnimation];
            break;
        default:
            break;
    }
}

#pragma mark - 1.positionAnimation ->位移
-(void)positionAnimation{
    
    _demoView.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:1.0f animations:^{
        
        _demoView.transform = CGAffineTransformMakeTranslation(100, 100);
    }];
}


#pragma mark - 2.scaleAnimatioon ->缩放
-(void)scaleAnimation{
    
    _demoView.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:1.0 animations:^{
        
        _demoView.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

#pragma mark - 3.roateAnimation ->旋转
-(void)rotateAnimation{
    
    _demoView.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:1.0f animations:^{
        
        _demoView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

#pragma mark - 4.combinationAnimation ->组合
-(void)combinationAnimation{
    
    //仿射变换的组合使用
    _demoView.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
        
        _demoView.transform = CGAffineTransformTranslate(transform2, 100, 100);
    }];
}

#pragma mark - 5.invertAnimation ->反转
-(void)invertAnimation{
    
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        
        _demoView.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(2, 2));
    }];
}



@end
