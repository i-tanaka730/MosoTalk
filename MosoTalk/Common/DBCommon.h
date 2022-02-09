//
//  DBCommon.h
//  MosoTalk
//
//  Created by 田中郁也 on 2013/06/08.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

@interface DBCommon : NSObject {
    sqlite3 *database;

}
@property sqlite3 *database;

- (BOOL)loadDb;
- (void) openDb;
- (NSMutableArray *)getFriend;
- (void)addFriend:(NSString *) name :(int)sex;
- (NSString *)dbtext:(sqlite3_stmt *) statement index:(int)i ;

@end
