//
//  searchFromViewController.h
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <Accounts/Accounts.h>
#import <Social/Social.h>


typedef NS_ENUM(NSInteger,RWTwitterInstantError){
    
    RWTwitterInstantErrorAccessDenied,
    RWTwitterInstantErrorNoTwitterAccounts,
    RWTwitterInstantErrorInvalidResponse
};

static NSString *  const RWTwitterInstantDomain = @"TwitterInstant";

@interface searchFromViewController : UIViewController

@property (strong, nonatomic) ACAccountStore * accountStore;
@property (strong, nonatomic) ACAccountType * twitterAccountType;

@end
