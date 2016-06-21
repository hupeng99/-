//
//  hp_tabbar.m
//  百思不得姐
//
//  Created by 胡鹏 on 16/5/21.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_tabbar.h"
#import "Hp_fabuViewController.h"
@interface hp_tabbar()
@property (nonatomic, weak) UIButton *button_fabu;
@end

@implementation hp_tabbar

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat subviewW=self.frame.size.width/5;
    CGFloat subviewH=self.frame.size.height;
    int index=0;
    CGFloat subviewY=0;
    for (UIView* subview in self.subviews)
    {
        if (subview.class!= NSClassFromString(@"UITabBarButton"))  continue;
        CGFloat subviewX=index* subviewW;
        if (index >= 2)  subviewX += subviewW;
        subview.frame=CGRectMake(subviewX, subviewY, subviewW, subviewH);
        index++;
    }
    CGRect frame=self.button_fabu.frame;
    frame.size=CGSizeMake(subviewW , subviewH);
    self.button_fabu.frame=frame;
    self.button_fabu.center =CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
}
-(UIButton*)button_fabu
{
    if (!_button_fabu) {
        UIButton *button_fabu = [UIButton buttonWithType:UIButtonTypeCustom];
        [button_fabu setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button_fabu setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button_fabu addTarget:self action:@selector(fabu) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button_fabu];
        _button_fabu = button_fabu;
    }
    return _button_fabu;
}
-(void)fabu
{
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[Hp_fabuViewController alloc]init] animated:YES completion:nil];
}
@end
