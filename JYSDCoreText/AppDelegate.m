//
//  AppDelegate.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/8/20.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import <JSPatchPlatform/JSPatch.h>

#define  JSPathKey  @"f23626f37b9bc22a"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController * VC = [[ViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:VC];
    self.window.rootViewController = nav  ;
    [self.window makeKeyAndVisible];
    
    
    //1.配置JSPath
    [self setupJSPath];
    
    
        
    return YES;
    
   }



/*
     typedef NS_ENUM(NSInteger, JPCallbackType){
     JPCallbackTypeUnknow        = 0,
     JPCallbackTypeRunScript     = 1,    //执行脚本
     JPCallbackTypeUpdate        = 2,    //脚本有更新
     JPCallbackTypeUpdateDone    = 3,    //已拉取新脚本
     JPCallbackTypeCondition     = 4,    //条件下发
     JPCallbackTypeGray          = 5,    //灰度下发
     };
 */
#pragma mark - 1.配置JSPath
-(void)setupJSPath{
    
   
    
    //[JSPatch testScriptInBundle];
    
    
    [JSPatch setupCallback:^(JPCallbackType type, NSDictionary *data, NSError *error) {
        
        
        switch (type) {
            case JPCallbackTypeUpdate: {
                NSLog(@"updated %@ %@", data, error);
                break;
            }
            case JPCallbackTypeRunScript: {
                NSLog(@"run script %@ %@", data, error);
                break;
            }
                
            default:
                break;
        }
    }];
    
    
    [JSPatch startWithAppKey:JSPathKey];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
#ifdef DEBUG
    [JSPatch setupDevelopment];
#endif
    [JSPatch sync];//每次唤醒都能同步更新 JSPatch 补丁，不需要等用户下次启动
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
