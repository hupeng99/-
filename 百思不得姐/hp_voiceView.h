//
//  hp_voiceView.h
//  baisi
//
//  Created by 胡鹏 on 16/5/25.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class hp_tiezi;
@interface hp_voiceView : UIView
@property(nonatomic,strong)hp_tiezi* tiezi;
+(instancetype)voiceView;
@end
