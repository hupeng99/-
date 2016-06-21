//
//  hp_tuijian.h
//  baisi
//
//  Created by 胡鹏 on 16/5/27.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hp_tuijian : NSObject
@property (nonatomic, copy) NSString *image_list;
@property (nonatomic, copy) NSString *theme_id;
@property (nonatomic, copy) NSString *theme_name;
@property (nonatomic, assign) NSInteger is_sub;
@property (nonatomic, assign) NSInteger is_default;
@property (nonatomic, assign) NSInteger sub_number;
@end
