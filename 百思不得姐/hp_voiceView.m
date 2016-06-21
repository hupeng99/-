//
//  hp_voiceView.m
//  baisi
//
//  Created by 胡鹏 on 16/5/25.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_voiceView.h"
#import "hp_tiezi.h"
#import <UIImageView+WebCache.h>
#import "hp_seeBigViewController.h"
@interface hp_voiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation hp_voiceView
-(void)awakeFromNib
{
    HPLog(@"wocuo");
    self.autoresizingMask=UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled=YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBig)]];
}
-(void)seeBig
{
    hp_seeBigViewController *seeBig = [[hp_seeBigViewController alloc] init];
    seeBig.tiezi = self.tiezi;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}
-(void)setTiezi:(hp_tiezi *)tiezi
{
    _tiezi=tiezi;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:tiezi.large_image]];
    self.playCountLabel.text=[NSString stringWithFormat:@"%zd播放", tiezi.playcount];
    NSInteger minute=tiezi.videotime/60;
    NSInteger second=tiezi.videotime%60;
    self.voiceTimeLabel.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
+(instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
