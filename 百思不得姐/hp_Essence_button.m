//
//  hp_Essence_button.m
//  baisi
//
//  Created by 胡鹏 on 16/5/24.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_Essence_button.h"

@implementation hp_Essence_button

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

@end
