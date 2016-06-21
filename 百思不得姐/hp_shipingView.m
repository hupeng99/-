//
//  hp_shipingView.m
//  baisi
//
//  Created by 胡鹏 on 16/5/25.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_shipingView.h"
#import "hp_tiezi.h"
#import <UIImageView+WebCache.h>
#import "hp_seeBigViewController.h"
#import "hp_MovieViewController.h"
@interface   hp_shipingView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)AVmovie:(id)sender;

@end
@implementation hp_shipingView
-(void)awakeFromNib
{
    self.autoresizingMask=UIViewAutoresizingNone;
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
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:tiezi.large_image]];
    self.playCountLabel.text=[NSString stringWithFormat:@"%zd播放", tiezi.playcount];
    NSInteger minute=tiezi.videotime/60;
    NSInteger second=tiezi.videotime%60;
    self.videoTimeLabel.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
- (IBAction)AVmovie:(id)sender {

//    hp_MovieViewController *seeBig = [[hp_MovieViewController alloc] init];
//    seeBig.tiezi = self.tiezi;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
    [MBProgressHUD showError:@"小主无能为力"];
}
@end
