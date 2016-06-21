//
//  hp_Comment.h
//  baisi
//
//  Created by 胡鹏 on 16/5/25.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class hp_User;
@interface hp_Comment : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) hp_User *user;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, copy) NSString *voiceuri;//声音文件路径
@end
