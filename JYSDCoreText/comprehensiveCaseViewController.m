//
//  comprehensiveCaseViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/18.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "comprehensiveCaseViewController.h"
#import "DCPathButton.h"//Path button
#import "DWBubbleMenuButton.h"//dingDingButton

#import "MCFireworksButton.h"

#import "configHeader.h"

@interface comprehensiveCaseViewController ()<DCPathButtonDelegate>

@property (strong, nonatomic) DCPathButton * pathAnimationView;//path 的按钮

//@property (strong, nonatomic) DWBubbleMenuButton * dingDingAnimation;


@property (nonatomic , assign) BOOL selected;



@end

@implementation comprehensiveCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNav];
    
    [self pathAnimationView];

}

-(void)setNav{
    
    self.title = @"综合案例";
}

-(NSArray *)operateTitleArray{
    
    return @[@"Path",@"钉钉",@"点赞"];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self pathAnimation];
            break;
        case 1:
            [self dingdingAnimation];
            break;
        case 2:
            [self clickGoodAnimation];
            break;
        default:
            break;
    }
}


#pragma mark - 1.Path 菜单动画
-(void)pathAnimation{
    
    if (!_pathAnimationView) {
        
        [self ConfigureDCPathButton];
    }
    
}

-(void)ConfigureDCPathButton{
    
    self.pathAnimationView = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"] hilightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    
    CGPoint center = CGPointMake(self.view.center.x, self.view.frame.size.height - 60);
    self.pathAnimationView.center = center;
    
    self.pathAnimationView.delegate = self;
    
    NSArray * imageArray = @[@"chooser-moment-icon-music",
                             @"chooser-moment-icon-place",
                             @"chooser-moment-icon-camera",
                             @"chooser-moment-icon-sleep"];
    
    NSArray * imageHeightArray = @[@"chooser-moment-icon-music-highlighted",
                                   @"chooser-moment-icon-place-highlighted",
                                   @"chooser-moment-icon-camera-highlighted",
                                   @"chooser-moment-icon-sleep-highlighted"];
    
//    
//    NSArray * backgroundImageArray = @[@"chooser-moment-button",
//                                       @"chooser-moment-button",
//                                       @"chooser-moment-button",
//                                       @"chooser-moment-button"];
//    NSArray * backgroundHighlightedImageArray = @[@"chooser-moment-button-highlighted",
//                                                  @"chooser-moment-button-highlighted",
//                                                  @"chooser-moment-button-highlighted",
//                                                  @"chooser-moment-button-highlighted"];
    
    
    NSMutableArray * itemButtonArray = [NSMutableArray array];
    
    for (int i = 0; i < imageArray.count; i++) {
    
        DCPathItemButton * itemButton = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:imageArray[i]] highlightedImage:[UIImage imageNamed:imageHeightArray[i]] backgroundImage:[UIImage imageNamed:@"chooser-moment-button"] backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
        
        [itemButtonArray addObject:itemButton];
    }
    
    [_pathAnimationView addPathItems:itemButtonArray];
    [self.view addSubview:_pathAnimationView];
}

#pragma mark - DCPathButtonDelegate
-(void)itemButtonTappedAtIndex:(NSUInteger)index{
    
    NSLog(@"click PathButton:%lu",(unsigned long)index);
}




#pragma mark - 2.钉钉菜单动画
-(void)dingdingAnimation{
    
    DWBubbleMenuButton * upMenuView = [[DWBubbleMenuButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 20, SCREEN_HEIGHT - 40 - 20, 40, 40) expansionDirection:DirectionUp];
    upMenuView.homeButtonView = [self createHomeButtonView];
    [upMenuView addButtons:[self createDemoButtonArray]];
    
    [self.view addSubview:upMenuView];
}


-(UILabel *)createHomeButtonView{
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    label.text = @"Tap";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height/2.f;
    label.layer.masksToBounds = YES;
    
    label.backgroundColor = [UIColor cyanColor];
    //label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];

    return label;
}


-( NSArray *)createDemoButtonArray{
    
    NSMutableArray * buttonsMutable = [NSMutableArray array];
    
    int i = 0;
    for (NSString * title in @[@"A",@"B",@"C",@"D",@"E"]) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 30, 30);
        button.layer.cornerRadius = button.frame.size.height/2;
        button.layer.masksToBounds = YES;
        button.tag = i++;
        button.backgroundColor = [UIColor cyanColor];
        [button addTarget:self action:@selector(dwBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
    
}
-(void)dwBtnClick:(UIButton *)button {
    
    NSLog(@"buttonTitle:%@",button.titleLabel.text);
}



#pragma mark - 3.facebook,点赞动画
-(void)clickGoodAnimation{
    
    MCFireworksButton * fireButton = [[MCFireworksButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 20, SCREEN_HEIGHT/2 - 20, 40, 40)];
    
    fireButton.particleImage = [UIImage imageNamed:@"Sparkle"]; //@"text"

    fireButton.particleScale = 0.05;
    fireButton.particleScaleRange = 0.02;
    [fireButton setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    
    [fireButton addTarget:self action:@selector(handelButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fireButton];
}

-(void)handelButtonPress:(MCFireworksButton *)button {
    
    _selected = !_selected;
    
    if (_selected) {
        [button popOutsideWithDuration:0.5];
        [button setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
        [button animate];
    }else{
        [button popInsideWithDuration:0.4];
        [button setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    }
}

@end
