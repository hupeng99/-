//
//  hp_tiezi.h
//  baisi
//
//  Created by 胡鹏 on 16/5/25.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, hp_tieziType) {
    hp_tieziAll= 1,         //全部
    hp_tieziPicture= 10,    //图片
    hp_tiezitext= 29,       //段子
    hp_tieziVoice= 31,      //声音
    hp_tiezishiping= 41     //视频
};

@class hp_Comment;

@interface hp_tiezi : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *text;//帖子的文字内容
@property (nonatomic, copy) NSString *created_at;//帖子审核通过的时间
@property (nonatomic, assign) NSInteger ding;
@property (nonatomic, assign) NSInteger cai;
@property (nonatomic, assign) NSInteger repost;//转发/分享数量
@property (nonatomic, assign) NSInteger comment;//评论数量
@property (nonatomic, strong) hp_Comment *top_cmt;//最热评论
@property (nonatomic, assign) hp_tieziType type;//帖子类型
@property (nonatomic, assign) CGFloat width;//图片的真实宽度
@property (nonatomic, assign) CGFloat height;//图片的真实高度
@property (nonatomic, copy) NSString *small_image;//小图
@property (nonatomic, copy) NSString *middle_image;// 中图
@property (nonatomic, copy) NSString *large_image;//大图
@property (nonatomic, assign) CGFloat cellHeight;//cell高
@property (nonatomic, assign) NSInteger voicetime;//音频时长
@property (nonatomic, assign) NSInteger videotime;//视频时长
@property (nonatomic, assign) NSInteger playcount;//播放次数
@property (nonatomic, assign) BOOL is_gif;//是否为gif动画图片
@property (nonatomic, assign) CGRect contentF;//中间内容的frame
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;//是否为超长图片
@property(nonatomic,copy)NSString *videouri;
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
@property(nonatomic,copy)NSString* theme_name;//标签
@end
