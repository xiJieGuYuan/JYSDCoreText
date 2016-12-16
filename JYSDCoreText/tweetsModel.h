//
//  tweetsModel.h
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tweetsModel : NSObject


@property (strong, nonatomic) NSString *status;

@property (strong, nonatomic) NSString *profileImageUrl;

@property (strong, nonatomic) NSString *username;

+ (instancetype)tweetWithStatus:(NSDictionary *)status;
@end
