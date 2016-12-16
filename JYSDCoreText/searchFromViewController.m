//
//  searchFromViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2016/12/15.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "searchFromViewController.h"


#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIView+SDAutoLayout.h"
#import "NSArray+LinqExtensions.h"
#import "tweetsModel.h"


#import "configHeader.h"


#import "searchResultsTableViewController.h"
@interface searchFromViewController ()

@property (strong, nonatomic) UIImageView * backImageView;//背景图片
@property (strong, nonatomic)    UITextField * textField;

@property (strong, nonatomic) searchResultsTableViewController * searchResultsTabVC;

@end

@implementation searchFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self setupContentSubviews];
    
    
    [self useSignal];
}

-(void)setNav{
    
    self.title = @"TwitterInstant";
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)setupContentSubviews{
    
    self.backImageView = [[UIImageView alloc]init];
    [self.view addSubview:_backImageView];
    
    _backImageView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .widthIs(SCREEN_WIDTH * 0.4)
    .heightIs(SCREEN_HEIGHT);
    
    _backImageView.image = [UIImage imageNamed:@"background.jpg"];
    _backImageView.alpha = 0.3;
    _backImageView.userInteractionEnabled = YES;
    _backImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _backImageView.layer.borderWidth = 1.0f;
    
    UILabel * textLabel = [[UILabel alloc]init];
    UITextField * textField = [[UITextField alloc]init];
    [self.view sd_addSubviews:@[textLabel,textField]];
    
    textLabel.text = @"Search Text:";
    textLabel.font = [UIFont systemFontOfSize:14.0f];
//    textField.backgroundColor = [UIColor yellowColor];
    _textField = textField;

    textLabel.sd_layout
    .topSpaceToView(self.view,100)
    .leftSpaceToView(self.view,15)
    .widthIs(120)
    .heightIs(20);
    
    textField.sd_layout
    .topSpaceToView(textLabel,10)
    .leftEqualToView(textLabel)
    .widthIs(SCREEN_WIDTH * 0.4 - 30)
    .heightIs(30);
    
    self.searchResultsTabVC = [[searchResultsTableViewController alloc]init];
    self.searchResultsTabVC.view.frame = CGRectMake(SCREEN_WIDTH * 0.4, 64, SCREEN_WIDTH * 0.6,SCREEN_HEIGHT - 64);
    [self.view addSubview:self.searchResultsTabVC.view];
    
    
    self.accountStore = [[ACAccountStore alloc]init];
    self.twitterAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    //用来通过背景色显示是否可用
    @weakify(self);
    [[self.textField.rac_textSignal map:^id(NSString * text) {
        
        return [self isValidTextFieldText:text] ? [UIColor whiteColor] : [UIColor yellowColor];
    }] subscribeNext:^(UIColor *  color) {
        
        @strongify(self);
        self.textField.backgroundColor = color;
    }];
}

-(void)useSignal{
    
    @weakify(self);
    [[[[[[[self requestAccessToTwitterSignal]
       then:^RACSignal *{
        
        @strongify(self);
        return self.textField.rac_textSignal;
    }]
      filter:^BOOL(NSString * text ) {
       
        @strongify(self);
        return [self isValidTextFieldText:text];

    }]
       throttle:0.5]
       
       flattenMap:^RACStream *(NSString  *  text) {
        
        @strongify(self);
        return [self signalForSearchWithText:text];
    }] deliverOn:[RACScheduler mainThreadScheduler ]]
    
      subscribeNext:^(NSDictionary * jsonSearchResult ) {
          
          NSArray * statues = jsonSearchResult[@"statuses"];
          
          NSArray * tweets = [statues linq_select:^id(id tweets) {
              
              return [tweetsModel tweetWithStatus:tweets];
          }];
          [self.searchResultsTabVC displayTweets:tweets];
          
          NSLog(@"textField.text:%@",tweets);
      } error:^(NSError *error) {
          NSLog(@"An error occurred:%@",error);
      }];
    
}

-(BOOL) isValidTextFieldText:(NSString *)text {
    
    return text.length >= 2 ? 1 : 0;
}

//1-1 创建一个授权访问信号
-(RACSignal *)requestAccessToTwitterSignal{
    
    //-1 define an errror
    NSError * accessError = [NSError errorWithDomain:RWTwitterInstantDomain code:RWTwitterInstantErrorAccessDenied userInfo:nil];
    
    //-2 create an signal
    @weakify(self);
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //-3 request access to twitter
        @strongify(self);
        
        [self.accountStore requestAccessToAccountsWithType:self.twitterAccountType options:nil completion:^(BOOL granted, NSError *error) {
            //-4 handle the request response
            if (!granted) {
                [subscriber sendError:accessError];
            }else{
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
        }];
        
        return nil;
    }];
}

//1-2 创建网络请求数据
-(SLRequest *)requestForTwitterSearchWithText:(NSString *)text{
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
    NSDictionary *params = @{@"q":text};
    SLRequest * request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:params];
    return request;
}

//1-3 创建基于request的信号
-(RACSignal * )signalForSearchWithText:(NSString * )text{
    
    //-1 define the error
    NSError * noAccountError = [NSError errorWithDomain:RWTwitterInstantDomain code:RWTwitterInstantErrorNoTwitterAccounts userInfo:nil];
    NSError * invalidResponseError = [NSError errorWithDomain:RWTwitterInstantDomain code:RWTwitterInstantErrorInvalidResponse userInfo:nil];
    
    
    //-2 create the signal block
    @weakify(self);
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        //-3 create the request
        SLRequest * request = [self requestForTwitterSearchWithText:text];
        
        //-4 supply a twitter account
        NSArray * twitterAccounts = [self.accountStore accountsWithAccountType:self.twitterAccountType];
    
        if (twitterAccounts.count == 0) {
            [subscriber sendError:noAccountError];
        }else{
            
            [request setAccount:[twitterAccounts lastObject]];
        }
        
        //-5 perform the request
        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
           
            if (urlResponse.statusCode == 200) {
                NSDictionary * timeLineData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
 
                [subscriber sendNext:timeLineData];
                [subscriber sendCompleted];
 
            }else{
                //7- send an error on failure
                [subscriber sendError:invalidResponseError];
            }
            
        }];
        return nil;
        
    }];
}
 

@end
