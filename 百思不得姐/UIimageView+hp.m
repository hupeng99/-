//
//  UIimageView+hp.m
//  baisi
//
//  Created by 胡鹏 on 16/5/25.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "UIimageView+hp.h"
#import <UIImageView+WebCache.h>
#import "UIimage+hp.h"
@implementation UIImageView (hp)
-(void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
}
-(void)setCircleHeader:(NSString*)url
{
    UIImage* placeholder=[UIImage circleImage:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image==nil)return ;
        self.image=[image circleImage];
    }];
}
-(void)setRectHeader:(NSString*)url
{
    UIImage* placeholder=[UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}
@end
