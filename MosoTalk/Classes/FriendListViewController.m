//
//  FriendListViewController.m
//  MosoTalk
//
//  Created by 田中郁也 on 2013/05/30.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "FriendListViewController.h"

@implementation FriendListViewController

/**
 * インスタンス化時
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 * メモリ警告時
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * View表示直前
 */
- (void)viewWillAppear:(BOOL)animated
{
	// ナビゲーションバーの設定
	NavigationViewController *viewController = [NavigationViewController alloc];
	[viewController setNavigation:self :@"友達選択" :@"削除" :@"友達追加"];

    // 友達一覧表示
    [self setFriend];
}

/**
 * 友達削除ボタン押下時
 */
- (void)btnLeft:(id)sender
{
    // TODO:友達を削除する
}

/**
 * 友達追加ボタン押下時
 */
- (void)btnRight:(id)sender
{
    // 友達追加画面を表示する
	AddFriendViewController *viewController = [[AddFriendViewController alloc] initWithNibName:@"AddFriendViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:NULL];
}

/**
 * 友達リスト設定
 */
- (void)setFriend
{
    // DBから友達リストの取得
    friendAry_ = [[NSMutableArray alloc] init];
    friendAry_ = [g_dbCommon getFriend];
    NSLog(@"%@", friendAry_);
}

/**
 * リストの行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [friendAry_ count];
}

/**
 * リストにCGIより取得した値を表示する
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// テーブルビューの線の色を設定
	table_.separatorColor = LINE_COLOR_GREEN;
	
	// テーブルビューのセルに表示する
	UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleDefault
                             reuseIdentifier:@"cell"];

	// フォント設定
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];

	// テキスト設定
    cell.textLabel.text = friendAry_[indexPath.row][1];
	
	return cell;
}

/**
 * テーブルビューのセル押下時
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // トーク画面を表示する
    MosoTalkViewController *viewController = [[MosoTalkViewController alloc] initWithNibName:@"MosoTalkViewController" bundle:nil];
	[self.navigationController pushViewController:viewController animated:YES];
}

@end
