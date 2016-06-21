//
//  hp_Mebutton.m
//  baisi
//
//  Created by 胡鹏 on 16/5/23.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_Mebutton.h"
#import "hp_square.h"
#import <UIButton+WebCache.h>
@implementation hp_Mebutton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.xmg_y = self.xmg_height * 0.15;
    self.imageView.xmg_height = self.xmg_height * 0.5;
    self.imageView.xmg_width = self.imageView.xmg_height;
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    
    self.titleLabel.xmg_x = 0;
    self.titleLabel.xmg_y = self.imageView.xmg_bottom;
    self.titleLabel.xmg_width = self.xmg_width;
    self.titleLabel.xmg_height = self.xmg_height - self.titleLabel.xmg_y;
}

- (void)setSquare:(hp_square *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
}



@end
