//
//  NavigationViewController.h
//  MosoTalk
//
//  Created by 田中郁也 on 2013/06/08.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UIViewController
{
	UIViewController *controller_;
}

- (void)setNavigation:(UIViewController *)controller :(NSString *)title :(NSString *)lBtnName :(NSString *)rBtnName;

@end
