//
//  testView.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/11/19.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "testView.h"



@interface testView ()




@end

@implementation testView



//-(void)awakeFromNib{
//    
//    [super awakeFromNib];
//    self.path = [[UIBezierPath alloc]init];
//    self.path.lineJoinStyle = kCGLineJoinRound;
//    self.path.lineCapStyle = kCGLineCapRound;
//    self.path.lineWidth = 5;
//}


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.path = [[UIBezierPath alloc]init];
        self.path.lineJoinStyle = kCGLineJoinRound;
        self.path.lineCapStyle = kCGLineCapRound;
        self.path.lineWidth = 5;
    }
    
    return self;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //get the starting point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    
    //move the path drawing cursor to the starting point
    [self.path moveToPoint:point];
}



-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //get the current point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //add a new line segment to our path
    [self.path addLineToPoint:point];
    
    
    //redraw the view
    [self setNeedsDisplay];
    
}
-(void)drawRect:(CGRect)rect{
    
    //darw path
    [[UIColor cyanColor] setFill];
    [[UIColor redColor] setStroke];
    [self.path stroke];
}


@end
