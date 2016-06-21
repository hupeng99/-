//
//  UIimage+hp.m
//  baisi
//
//  Created by 胡鹏 on 16/5/25.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "UIimage+hp.h"

@implementation UIImage (hp)
-(instancetype)circleImage
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGRect rect=CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage * image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+(instancetype)circleImage:(NSString *)name
{
    return [[self imageNamed:name]circleImage];
}
@end
