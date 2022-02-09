//
//  DBCommon.m
//  MosoTalk
//
//  Created by 田中郁也 on 2013/06/08.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "DBCommon.h"

@implementation DBCommon

// 定数定義
NSString * const DB_FILE_NAME_FULL   = @"mosodb.sqlite";
NSString * const DB_FILE_NAME   = @"mosodb";
NSString * const DB_FILE_EXT   = @"sqlite";


@synthesize database;


- (BOOL)loadDb
{
	//起動時にDBファイルの準備
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
	NSString *storePath = [basePath stringByAppendingPathComponent: DB_FILE_NAME_FULL];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// 端末内にDBファイルが存在しない場合、リソースからコピーする
	if (![fileManager fileExistsAtPath:storePath]) {
		NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:DB_FILE_NAME ofType:DB_FILE_EXT];
        NSError *error;
        if (![fileManager copyItemAtPath:defaultStorePath toPath:storePath error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            return NO;  // Fail
		}
	}
    
    return YES;
}

- (void)openDb
{
    //DBのオープン
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
	NSString *path = [basePath stringByAppendingPathComponent: DB_FILE_NAME_FULL];
    
    database = nil;
    if( sqlite3_open([ path UTF8String ], &database ) != SQLITE_OK ) {
        // DB ファイルオープン失敗
        sqlite3_close( database );
        NSLog( @"Failed to open databese with following message '%s'.", sqlite3_errmsg( database ));
        database = nil;
        
    }
}

- (NSMutableArray *)getFriend
{    
    // DB からフレーズを取得
    sqlite3_stmt *statement = NULL;
//
//    const char *sqlcnt = "SELECT COUNT(*) FROM catchphrase";
//    
//    int statuscnt = sqlite3_prepare_v2( database, sqlcnt, -1, &statement, NULL );
//    
//    int cnt = 0;
//    if( statuscnt == SQLITE_OK ) {
//        sqlite3_reset(statement);
//        
//        if (sqlite3_step( statement ) == SQLITE_ROW ) {
//            
//            // データが存在する場合は、メッセージを抽出する
//            cnt = sqlite3_column_int(statement, 0 );
//            NSLog(@"%d",cnt);
//
//            
//        }
//    } else {
//        NSLog( @"Failed to prepare statement with '%s'.", sqlite3_errmsg( g_dbCommon.database ));
//    }
//    sqlite3_finalize( statement );
//
//    //乱数初期化
//    srand(time(nil));
//    int key = rand()%cnt;
    
    
    const char *sql = "select friend_id, friend_name, friend_sex, friend_img from friend_info";
    
    int status = sqlite3_prepare_v2( database, sql, -1, &statement, NULL );
    
    NSMutableArray *friendList = [[NSMutableArray alloc] init];
    if( status == SQLITE_OK ) {
        sqlite3_reset(statement);
//        sqlite3_bind_int(statement, 1, key);

        while (sqlite3_step(statement) == SQLITE_ROW) {
            [friendList addObject:@[[self dbtext:statement index:0],
                                    [self dbtext:statement index:1],
                                    [self dbtext:statement index:2],
                                    [self dbtext:statement index:3]]];
        }
        
    } else {
        NSLog( @"Failed to prepare statement with '%s'.", sqlite3_errmsg( g_dbCommon.database ));
    }
    sqlite3_finalize( statement );
    
    return friendList;
}

- (void)addFriend:(NSString *) name :(int)sex;
{
    // DB からフレーズを取得
    sqlite3_stmt *statement = NULL;
    
    //const char *sql = "insert into friend_info values (null, '田中くん', '0', 'tanaka.png');";
    const char *sql = "insert into friend_info values (null, ?, ?, ?);";
    
    int status = sqlite3_prepare_v2( database, sql, -1, &statement, NULL );
    if( status == SQLITE_OK ) {
        sqlite3_clear_bindings(statement);
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 2, sex);
        sqlite3_step(statement);
    } else {
        NSLog( @"Failed to prepare statement with '%s'.", sqlite3_errmsg( g_dbCommon.database ));
    }

    sqlite3_finalize( statement );
}

- (NSString *) dbtext:(sqlite3_stmt *) statement index:(int)i
{
    char *value = (char *)sqlite3_column_text(statement, i);
    if (value == nil) {
        //DBにnullが設定されている場合、空文字に変更
        NSString *str = @"";
        value = (char *)[str UTF8String];
    }
    NSLog(@"%@", [NSString stringWithUTF8String:value]);
    return [NSString stringWithUTF8String:value];
}

@end
