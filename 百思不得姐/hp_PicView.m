//
//  hp_PicView.m
//  baisi
//
//  Created by 胡鹏 on 16/5/25.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_PicView.h"
#import <UIImageView+WebCache.h>
#import "hp_tiezi.h"
#import <AFNetworking.h>
#import <DALabeledCircularProgressView.h>
#import "hp_seeBigViewController.h"
@interface   hp_PicView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end


@implementation hp_PicView
-(void)awakeFromNib
{
    self.autoresizingMask=UIViewAutoresizingNone;
    self.progressView.roundedCorners=5;
    self.progressView.progressLabel.textColor=[UIColor whiteColor];
    
    self.imageView.userInteractionEnabled=YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
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

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:tiezi.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // receivedSize:已经接收的图片大小
        // expectedSize:图片的总大小
        CGFloat progress=1.0* receivedSize/expectedSize;
        self.progressView.progress=progress;
        self.progressView.hidden=NO;
        self.progressView.progressLabel.text=[NSString stringWithFormat:@"%.0f%%", progress * 100];} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.progressView.hidden=YES;
            [self.imageView setNeedsDisplay];
        }];
    self.gifView.hidden=!tiezi.is_gif;
    
    if (tiezi.isBigPicture)
    {
        self.seeBigButton.hidden=NO;
        self.imageView.contentMode=UIViewContentModeTop;
        self.imageView.clipsToBounds=YES;//超过父视图的部分剪掉
    }else{
        self.seeBigButton.hidden=YES;
        self.imageView.contentMode=UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds=NO;
    }
}



@end
