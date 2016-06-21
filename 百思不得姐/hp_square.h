//
//  hp_square.h
//  baisi
//
//  Created by 胡鹏 on 16/5/23.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hp_square : NSObject<NSCoding>
/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 路径 */
@property (nonatomic, copy) NSString *url;
@end
