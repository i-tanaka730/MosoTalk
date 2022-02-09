//
//  AddFriendViewController.h
//  MosoTalk
//
//  Created by 田中郁也 on 2013/06/03.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MosoTalkViewController.h"
#import "AlertUtil.h"

@interface AddFriendViewController : UIViewController
<
    UIImagePickerControllerDelegate,
    UITextFieldDelegate
>
{
    IBOutlet UITextField            *txtName_;
    IBOutlet UIImageView            *ivFriend_;
    IBOutlet UISegmentedControl     *segCntrl_;
	UIAlertView                     *indicatorAlert_;
}

// キャンセルボタン押下時
- (IBAction)btnCancel:(id)sender;
// カメラボタン押下時
- (IBAction)btnCamClick:(id)sender;
// 選択ボタン押下時
- (IBAction)btnFileClick:(id)sender;
// 登録ボタン押下時
- (IBAction)btnRegistClick:(id)sender;

@end
