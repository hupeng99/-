//
//  SQLManger.h
//  baisi
//
//  Created by 胡鹏 on 16/5/26.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLManger : NSObject
+ (instancetype)shareIntance;

- (BOOL)openDB;
- (BOOL)closeDB;
- (BOOL)execSQL:(NSString *)sql;
- (BOOL)insertValues:(NSString* )sql;
- (NSArray *)querySQL:(NSString *)querySQL;
@end
