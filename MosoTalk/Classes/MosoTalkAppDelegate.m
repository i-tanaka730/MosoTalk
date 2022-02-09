//
//  MosoTalkAppDelegate.m
//  MosoTalk
//
//  Created by 田中郁也 on 2013/05/30.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "MosoTalkAppDelegate.h"

#import "FriendListViewController.h"

@implementation MosoTalkAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.rootViewController = [UIViewController new];
    
    // ナビゲーションコントローラにベースとなるコントローラをセット
    self.viewController = [[FriendListViewController alloc]init];
    naviController = [[UINavigationController alloc] initWithRootViewController:self.viewController];

    //DBの準備
    g_dbCommon = [[DBCommon alloc] init];
    if (![g_dbCommon loadDb]){
        return NO;
    }
    //DB接続
    [g_dbCommon openDb];
    
    // ナビゲーションコントローラのビューをウィンドウに貼付ける
    [self.window addSubview:naviController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
