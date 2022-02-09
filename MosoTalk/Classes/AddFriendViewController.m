//
//  AddFriendViewController.m
//  MosoTalk
//
//  Created by 田中郁也 on 2013/06/03.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "AddFriendViewController.h"

@implementation AddFriendViewController

/**
 * インスタンス化時
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    // テキストフィールドのデリゲートを設定
    txtName_.delegate = self;
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
- (void)viewWillAppear:(BOOL)animated {
    // ナビゲーションバー非表示
    self.navigationController.navigationBarHidden = YES;
}

/**
 * キャンセルボタン押下時
 */
- (void)btnCancel:(id)sender
{
	// 画面を閉じる
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/**
 * カメラボタン押下
 */
- (IBAction)btnCamClick:(id)sender
{    
	// カメラアプリを呼び出せるかをチェック
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[AlertUtil showAlert:@"error" message:@"カメラが使用できません。"];
		return;
	}
    
	// インジケータ表示
	indicatorAlert_ = [AlertUtil showIndicator:@"起動中..." message:@""];
    
	// 別スレッドにてカメラアプリを起動
	[self performSelectorInBackground:@selector(cameraThread) withObject:nil];
}

/**
 * 画像選択ボタン押下
 */
- (IBAction)btnFileClick:(id)sender
{
	// 画像選択アプリを呼び出せるかをチェック
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		[AlertUtil showAlert:@"error" message:@"画像が選択できません。"];
		return;
	}
    
	// 別スレッドにて画像選択アプリを起動
	[self performSelectorInBackground:@selector(fileListThread) withObject:nil];
}

/**
 * 登録ボタン押下
 */
- (IBAction)btnRegistClick:(id)sender
{
    // 入力チェック
    if (![self isValidInput]) {
        return;
    }
    
    // TODO:名前、性別をDBに登録
    NSLog(@"%@", txtName_.text);
    NSLog(@"%d", segCntrl_.selectedSegmentIndex);
    
    // TODO:画像を端末に登録
    [g_dbCommon addFriend:txtName_.text :segCntrl_.selectedSegmentIndex];
    
    // 画面を閉じる
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/**
 * キーボードリターン時
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/**
 * 共通入力チェック
 */
- (BOOL)isValidInput
{
    // 名前の入力内容をトリム
    txtName_.text = [txtName_.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // 未入力チェック
	if ([txtName_.text isEqualToString:@""]) {
		[AlertUtil showAlert:@"error" message:@"名前を入力してください。"];
		return NO;
	}
    
    return YES;
}

/**
 * カメラスレッド
 */
- (void)cameraThread
{
	// カメラアプリ呼び出し
	[self callImagePicker:UIImagePickerControllerSourceTypeCamera];
	
	// スレッド終了処理
	[self performSelectorOnMainThread:@selector(finalizeThread) withObject:nil waitUntilDone:YES];
}

/**
 * ファイルスレッド
 */
- (void)fileListThread
{
	// 画像選択アプリ呼び出し
	[self callImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
	
	// スレッド終了処理
    indicatorAlert_ = nil;
	[self performSelectorOnMainThread:@selector(finalizeThread) withObject:nil waitUntilDone:YES];
}

/**
 * スレッドの共通終了処理
 */
- (void)finalizeThread
{
	// インジケータを非表示にする
	if (indicatorAlert_ != nil) {
		[AlertUtil dismissIndicator:indicatorAlert_ animated:YES];
	}
}

/**
 * イメージピッカー呼び出しを行う
 */
- (void)callImagePicker:(UIImagePickerControllerSourceType)sourceType
{
	UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = sourceType;
	imagePicker.delegate = (id)self;
    [self presentViewController:imagePicker animated:YES completion: nil];
}

/**
 * カメラ撮影後
 */
- (void)imagePickerController:(UIImagePickerController*)picker	didFinishPickingImage:(UIImage*)image editingInfo:(NSDictionary*)info
{
	ivFriend_.image = image;
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
