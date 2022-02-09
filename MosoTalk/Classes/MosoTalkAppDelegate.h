//
//  MosoTalkAppDelegate.h
//  MosoTalk
//
//  Created by 田中郁也 on 2013/05/30.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendListViewController;

@interface MosoTalkAppDelegate : UIResponder
<UIApplicationDelegate> {
    UINavigationController *naviController;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FriendListViewController *viewController;

@end
