//
//  NavigationViewController.m
//  MosoTalk
//
//  Created by 田中郁也 on 2013/06/08.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "NavigationViewController.h"

@implementation NavigationViewController

/**
 * ナビゲーションバーをセットする
 */
- (void)setNavigation:(UIViewController *)controller :(NSString *)title :(NSString *)lBtnName :(NSString *)rBtnName
{
	// ナビゲーションバー表示
	controller.navigationController.navigationBarHidden = NO;

    // タイトル
    if(rBtnName != nil && ![rBtnName isEqualToString:@""]){
        controller.title = title;
    }

    // 左ボタン
    if(lBtnName != nil && ![lBtnName isEqualToString:@""]){
        controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                       initWithTitle:lBtnName
                                                       style:UIBarButtonItemStyleBordered
                                                       target:controller
                                                       action:@selector(btnLeft:)];
    }
    
    // 右ボタン
    if(rBtnName != nil && ![rBtnName isEqualToString:@""]){
        controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                        initWithTitle:rBtnName
                                                        style:UIBarButtonItemStyleBordered
                                                        target:controller
                                                        action:@selector(btnRight:)];
    }
}

@end
