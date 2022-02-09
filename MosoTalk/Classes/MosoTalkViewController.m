//
//  MosoTalkViewController.m
//  MosoTalk
//
//  Created by 田中郁也 on 2013/06/08.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "MosoTalkViewController.h"

@implementation MosoTalkViewController

/**
 * インスタンス化時
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    // トークを開始する
    [self startTalk];
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
	NavigationViewController *viewController = [[NavigationViewController alloc] init];
	[viewController setNavigation:self :@"友達選択" :nil :nil];
}

/**
 * トークを開始する
 */
- (void)startTalk
{
    // メッセージ初期設定
    messages_ = [[NSMutableArray alloc] initWithObjects:nil];
    // 背景色設定
	tvTalk_.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:226.0/255.0 blue:237.0/255.0 alpha:1.0];
}

- (void)btnMsg1:(id)sender {
    [self addMsg:@"はい"];
}

- (void)btnMsg2:(id)sender {
    [self addMsg:@"いいえ"];
}

- (void)btnMsg3:(id)sender {
    [self addMsg:@"知らん！"];
}
     
- (void)addMsg:(NSString *)msg {
    if(msg != nil && ![msg isEqualToString:@""]){
        [messages_ addObject:msg];
        [tvTalk_ reloadData];
        NSUInteger index = [messages_ count] - 1;
        [tvTalk_ scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messages_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
	UIImageView *balloonView;
	UILabel *label;
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		balloonView = [[UIImageView alloc] initWithFrame:CGRectZero];
		balloonView.tag = 1;
		
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.tag = 2;
		label.numberOfLines = 0;
		label.lineBreakMode = NSLineBreakByWordWrapping;
		label.font = [UIFont systemFontOfSize:14.0];
		
		UIView *message = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height)];
		message.tag = 0;
		[message addSubview:balloonView];
		[message addSubview:label];
		[cell.contentView addSubview:message];
	}
	else
	{
		balloonView = (UIImageView *)[[cell.contentView viewWithTag:0] viewWithTag:1];
		label = (UILabel *)[[cell.contentView viewWithTag:0] viewWithTag:2];
	}
	
	NSString *text = [messages_ objectAtIndex:indexPath.row];
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0f, 480.0f) lineBreakMode:NSLineBreakByWordWrapping ];
	
	UIImage *balloon;
	
	if(indexPath.row % 2 == 0)
	{
		balloonView.frame = CGRectMake(320.0f - (size.width + 28.0f), 2.0f, size.width + 28.0f, size.height + 15.0f);
		balloon = [[UIImage imageNamed:@"green.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
		label.frame = CGRectMake(307.0f - (size.width + 5.0f), 8.0f, size.width + 5.0f, size.height);
	}
	else
	{
		balloonView.frame = CGRectMake(0.0, 2.0, size.width + 28, size.height + 15);
		balloon = [[UIImage imageNamed:@"grey.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
		label.frame = CGRectMake(16, 8, size.width + 5, size.height);
	}
	
	balloonView.image = balloon;
	label.text = text;
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *body = [messages_ objectAtIndex:indexPath.row];
	CGSize size = [body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0, 480.0) lineBreakMode:NSLineBreakByWordWrapping ];
	return size.height + 15;
}

@end
