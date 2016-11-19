//
//  transitionAnimationViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "transitionAnimationViewController.h"
#import "configHeader.h"

@interface transitionAnimationViewController ()

@property (strong, nonatomic) UIView * demoView;
@property (strong, nonatomic) UILabel * demoLabel;
@property (assign, nonatomic) NSInteger index;


@end

@implementation transitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self createDemoView];
}

-(void)createDemoView{
    
    self.index = 0;
    self.demoView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 90, SCREEN_HEIGHT/2-200, 180, 260)];
    [self.view addSubview:self.demoView];
    
    self.demoLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_demoView.frame)/2 - 10, CGRectGetHeight(_demoView.frame)/2 - 40, 20, 40)];
    
    [self.demoView addSubview:self.demoLabel];
    [self changeView:YES];
}


-(void)setNav{
    
    self.title = @"过渡动画";
}

-(NSArray *)operateTitleArray{
    
    return @[@"fade",@"moveIn",@"push",@"reveal",@"cube",@"suck",@"oglFlip",@"ripple",@"curl",@"unCurl",@"caOpen",@"caClose"];
}

-(void)clickBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            [self fadeAnimation];
            break;
            
        case 1:
            [self moveInAnimation];
            break;
            
        case 2:
            [self pushAnimation];
            break;
            
        case 3:
            [self revealAnimation];
            break;
            
        case 4:
            [self cubeAnimatiom];
            break;
            
        case 5:
            [self suckEffectAnimation];
            break;
            
        case 6:
            [self ogFlipAnimation];
            break;
            
        case 7:
            [self rippleEffectAnimation];
            break;
            
        case 8:
            [self pageCurlAnimation];
            break;
            
        case 9:
            [self pageUnCurlAnimation];
            break;
            
            
        case 10:
            [self cameraIrisHollowOpenAnimation];
            break;
            
            
        case 11:
            [self cameraIrisHollowCloseAnimation];
            break;
            
            
        default:
            break;
    }
}


#pragma mark - 1.逐渐消失
-(void)fadeAnimation{
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    anima.type = kCATransitionFade;//设置动画类型
    anima.subtype = kCATransitionFromRight;//设置动画的方向
    
//    anima.startProgress = 0.3;//设置动画起点
//    anima.endProgress = 0.8;//设置动画终点
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"fadeAn"];
}

#pragma mark - 2.moveInAnimation
-(void)moveInAnimation{
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    anima.type = kCATransitionMoveIn;//设置动画的类型
    anima.subtype = kCATransitionFromRight;//设置动画的方向
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"moveInAnimationQQ"];
}


#pragma mark - 3.pushAnimation
-(void)pushAnimation{
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    anima.type = kCATransitionPush;//设置动画类型
    anima.subtype = kCATransitionFromRight;//设置动画的方向
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"pushAnimationQQ"];
}


#pragma mark - 4.revealAnimation
-(void)revealAnimation{
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    anima.type = kCATransitionReveal;//设置动画的类型
    anima.subtype = kCATransitionFromRight;//设置动画的方向
    anima.duration = 1.0;
    [_demoView.layer addAnimation:anima forKey:@"revealAnimation"];
}



//-----------------------------private api------------------------------------

/*
	Don't be surprised if Apple rejects your app for including those effects,
	and especially don't be surprised if your app starts behaving strangely after an OS update.
 */



#pragma mark - 5.立体翻滚效果
-(void)cubeAnimatiom{
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    anima.type = @"cube";
    anima.subtype = kCATransitionFromRight;
    
    [_demoView.layer addAnimation:anima forKey:@"cubeAnimation"];
}

#pragma mark - 6.suckEffectAnimation
-(void)suckEffectAnimation{
    
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    anima.type = @"suckEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight;//设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"suckEffectAnimation"];
}

#pragma mark - 7.oglFlipAnimation
-(void)ogFlipAnimation{
    
    [self changeView:YES];
    CATransition * anima = [CATransition animation];
    anima.type = @"oglFlip";
    anima.subtype = kCATransitionFromRight;
    anima.duration = 1.0;
    
    [_demoView.layer addAnimation:anima forKey:@"oglFlipAnimation"];
}

#pragma mark - 8.rippleEffectAnimation
-(void)rippleEffectAnimation{
    
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    
    anima.type = @"rippleEffect";//设置动画的类型
    anima.subtype  = kCATransitionFromRight;//设置动画的方向
    anima.duration = 1.0;
    [_demoView.layer addAnimation:anima forKey:@"rippleEffectAnimation"];
}

#pragma mark - 9.pageCurlAnimation
-(void)pageCurlAnimation{
    
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    anima.type = @"pageCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight;
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"pageCurlAnimation"];
}


#pragma mark - 10.pageUnCurlAnimation
-(void)pageUnCurlAnimation{
    
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    anima.type = @"pageUnCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight;//设置动画的方向
    anima.duration = 1.0;
    [_demoView.layer addAnimation:anima forKey:@"pageUnCurlAnimation"];
}

#pragma mark - 11.cameraIrisHollowOpenAnimation

-(void)cameraIrisHollowOpenAnimation{
    
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    anima.type  = @"cameraIrisHollowOpen"; //设置动画的类型
    anima.subtype = kCATransitionFromRight;//设置动画的方向
    anima.duration = 1.0;
    
    [_demoView.layer addAnimation:anima forKey:@"cameraIrisHollowOpenAnimation"];
}


#pragma mark - 12.cameraIrisHollowCloseAnimation
-(void)cameraIrisHollowCloseAnimation{
    
    [self changeView:YES];
    
    CATransition * anima = [CATransition animation];
    anima.type = @"cameraIrisHollowClose";//设置动画的类型
    anima.subtype = kCATransitionFromRight;
    anima.duration = 1.0;
    [_demoView.layer addAnimation:anima forKey:@"cameraIrisHollowCloseAnimation"];
}



-(void)changeView:(BOOL)isUp{
    
    if (_index > 3) {
        _index = 0;
    }
    
    if (_index < 0) {
        _index = 3;
    }
    
    NSArray * colors = @[[UIColor cyanColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor]];
    NSArray * titles = @[@"1",@"2",@"3",@"4"];
    
    _demoView.backgroundColor = [colors objectAtIndex:_index];
    _demoLabel.text = [titles objectAtIndex:_index];
    
    if (isUp) {
        _index++;
    }else{
        _index--;
    }
}


@end
