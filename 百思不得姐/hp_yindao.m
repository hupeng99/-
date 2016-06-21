//
//  hp_yindao.m
//  baisi
//
//  Created by 胡鹏 on 16/5/27.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_yindao.h"

@implementation hp_yindao

+(instancetype)pushGuideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

+(void)show {
    NSString *key = @"CFBundleShortVersionString";
    //获得当前软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //沙盒中版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:lastVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        hp_yindao *pushGuide = [hp_yindao pushGuideView];
        pushGuide.frame = window.bounds;
        [window addSubview:pushGuide];
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)closeBtn:(UIButton *)sender {
    [self removeFromSuperview];
}

@end
