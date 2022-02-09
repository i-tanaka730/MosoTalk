//
//  MosoTalkViewController.h
//  MosoTalk
//
//  Created by 田中郁也 on 2013/06/08.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewController.h"

@interface MosoTalkViewController : UIViewController
<
    UITextFieldDelegate
>
{
	IBOutlet UITableView    *tvTalk_;
	NSMutableArray          *messages_;
}

// ボタン1押下時
- (IBAction)btnMsg1:(id)sender;
// ボタン2押下時
- (IBAction)btnMsg2:(id)sender;
// ボタン3押下時
- (IBAction)btnMsg3:(id)sender;

@end
