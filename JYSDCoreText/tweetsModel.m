//
//  tweetsModel.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "tweetsModel.h"

@implementation tweetsModel


+ (instancetype)tweetWithStatus:(NSDictionary *)status {
    tweetsModel *tweet = [tweetsModel new];
    tweet.status = status[@"text"];
    
    NSDictionary *user = status[@"user"];
    tweet.profileImageUrl = user[@"profile_image_url"];
    tweet.username = user[@"screen_name"];
    return tweet;
}

@end
