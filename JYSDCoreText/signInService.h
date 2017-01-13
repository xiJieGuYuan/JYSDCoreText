//
//  signInService.h
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/13.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RWSignInResponse)(BOOL success);

@interface signInService : NSObject

//暂时不使用
-(void)signInWithUserName:(NSString *)userName password:(NSString *)password complete:(RWSignInResponse )completeBlock;

@end
