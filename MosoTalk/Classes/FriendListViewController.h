//
//  FriendListViewController.h
//  MosoTalk
//
//  Created by 田中郁也 on 2013/06/06.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddFriendViewController.h"
#import "NavigationViewController.h"

@interface FriendListViewController : UIViewController
{
    IBOutlet UITableView	*table_;
    NSMutableArray          *friendAry_;
}

@end

