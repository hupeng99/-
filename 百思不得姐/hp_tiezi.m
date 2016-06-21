//
//  hp_tiezi.m
//  baisi
//
//  Created by 胡鹏 on 16/5/25.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_tiezi.h"
#import "hp_Comment.h"
#import "hp_User.h"

@implementation hp_tiezi
// 屏幕宽度 == 375
// 图片显示出来的宽度 == 355
// 图片显示出来的高度 == 355 * 300 / 710
// 服务器返回的图片宽度 == 710
// 服务器返回的图片高度 == 300
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"top_cmt" : @"top_cmt[0]",
             @"ID":@"id",
             };
}
+(NSDictionary *)mj_objectClassInArray {
    return @{@"top_cmt" : @"hp_Coment"};
}
-(CGFloat)cellHeight
{
    if (_cellHeight) {
        return _cellHeight;
    }
    _cellHeight=55;
    
    CGFloat textMaxW=[UIScreen mainScreen].bounds.size.width-4*10;
    CGSize textMaxS=CGSizeMake(textMaxW, MAXFLOAT);
    
    CGSize textsize=[self .text boundingRectWithSize:textMaxS options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    _cellHeight+=textsize.height+10;
    
    if (self.type!=hp_tiezitext)
    {
        CGFloat contentH=textMaxW*self.height/self.width;
        if (contentH>=[UIScreen mainScreen].bounds.size.height)
        {
            contentH=200;
            self.bigPicture=YES;
        }
        self.contentF=CGRectMake(10, _cellHeight, textMaxW, contentH);
        _cellHeight+=contentH+10;
    }
    if (self.top_cmt)
    {
        _cellHeight+=20;
        NSString* content=self.top_cmt.content;
        if (self.top_cmt.voiceuri.length)
            content=@"[语音评论]";
        NSString* topCmtContent=[NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, content];
        CGSize topCmtContentSize=[topCmtContent boundingRectWithSize:textMaxS options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        _cellHeight+=topCmtContentSize.height+10;
    }
    _cellHeight+=35+10+30;
    return _cellHeight;
}
@end
