//
//  hp_button.m
//  baisi
//
//  Created by 胡鹏 on 16/5/27.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_button.h"
#import "UIView+XMGExtension.h"
@implementation hp_button

-(void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib {
    [self setup];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //调整图片
    self.imageView.xmg_x = 0;
    self.imageView.xmg_y = 0;
    self.imageView.xmg_width = self.xmg_width;
    self.imageView.xmg_height = self.imageView.xmg_width;
    //调整文字
    self.titleLabel.xmg_x = 0;
    self.titleLabel.xmg_y = self.imageView.xmg_height;
    self.titleLabel.xmg_height = self.xmg_height;
    self.titleLabel.xmg_height = self.xmg_height - self.titleLabel.xmg_y;
}

@end
