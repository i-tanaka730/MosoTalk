//
//  AlertUtil.h
//  MosoTalk
//
//  Created by 田中郁也 on 2013/06/08.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertUtil : NSObject
{

}

+ (void)showAlert:(NSString *)title message:(NSString *)message;
+ (void)showOkCancel:(NSString *)title message:(NSString *)message delegate:(id)delegate;
+ (UIAlertView *)showIndicator:(NSString *)title message:(NSString *)message;
+ (void)dismissIndicator:(UIAlertView *)alert animated:(BOOL)animated;

@end
