//
//  signInService.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/13.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "signInService.h"

@implementation signInService


-(void)signInWithUserName:(NSString *)userName password:(NSString *)password complete:(RWSignInResponse )completeBlock{
    
    
    double delayInSeconds = 2.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
  
  dispatch_after(popTime, dispatch_get_main_queue(), ^{
      
      BOOL success = [userName isEqualToString:@"user"] && [password isEqualToString:@"password"];
      
      completeBlock(success);
      
  });
    
    
}



//BOOL success = [userName isEqualToString:@"user"] && [password isEqualToString:@"password"];
//
//completeBlock(success);

@end
