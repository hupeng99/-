//
//  hp_tieziTableViewCell.m
//  baisi
//
//  Created by 胡鹏 on 16/5/24.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_tieziTableViewCell.h"
#import "hp_tiezi.h"
#import <UIImageView+WebCache.h>
#import "hp_Comment.h"
#import "hp_User.h"
#import "hp_PicView.h"
#import "hp_shipingView.h"
#import "hp_voiceView.h"
#import "UIimageView+hp.h"
@interface hp_tieziTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *biaoqian;
@property (weak, nonatomic) IBOutlet UIImageView *jiav;
- (IBAction)ding:(id)sender;
//最热评论
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
@property (nonatomic, weak) hp_PicView *pictureView;
@property (nonatomic, weak) hp_voiceView *voiceView;
@property (nonatomic, weak) hp_shipingView *shipingView;

@end

@implementation hp_tieziTableViewCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}
-(hp_PicView*)pictureView
{
    if (!_pictureView) {
        hp_PicView* pic=[hp_PicView viewFromXib];
        [self.contentView addSubview:pic];
        _pictureView=pic;
    }
    return _pictureView;
}
-(hp_shipingView*)shipingView
{
    if (!_shipingView) {
        hp_shipingView* shiping=[hp_shipingView viewFromXib];
        [self.contentView addSubview:shiping];
        _shipingView=shiping;
    }
    return _shipingView;
}
-(hp_voiceView*)voiceView
{
    if (!_voiceView) {
        hp_voiceView* voice=[hp_voiceView voiceView];
        [self.contentView addSubview:voice];
        _voiceView=voice;
    }
    return _voiceView;
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= 2 * 10;
    frame.size.height = self.tiezi.cellHeight - 10;
    frame.origin.y += 10;
    [super setFrame:frame];
}
-(void)setTiezi:(hp_tiezi *)tiezi
{
    _tiezi=tiezi;
    self.biaoqian.text=@"搞笑 创意 美女";
    self.jiav.hidden = !tiezi.is_gif;
    [self.profileImageView setHeader:tiezi.profile_image];
    self.nameLabel.text=tiezi.name;
    self.createdAtLabel.text=tiezi.created_at;
    self.text_label.text=tiezi.text;
    
    [self setButton:self.dingButton number:tiezi.ding placeholder:@"100"];
    [self setButton:self.caiButton number:tiezi.cai placeholder:@"100"];
    [self setButton:self.repostButton number:tiezi.repost placeholder:@"100"];
    [self setButton:self.commentButton number:tiezi.comment placeholder:@"100"];
    
    if (tiezi.top_cmt)
    {
        self.topCmtView.hidden=NO;
        NSString* username=tiezi.top_cmt.user.username;
        NSString* concent=tiezi.top_cmt.content;
        if (tiezi.top_cmt.voiceuri.length)
        {
            concent=@"[语音评论]";
        }
        self.topCmtContentLabel.text=[NSString stringWithFormat:@"%@ : %@",username,concent];
    }
    else
    {
        self.topCmtView.hidden=YES;
    }
    if (tiezi.type==hp_tieziPicture)
    {
        self.pictureView.hidden=NO;
        self.pictureView.frame=tiezi.contentF;
        self.pictureView.tiezi=tiezi;
        self.shipingView.hidden=YES;
        self.voiceView.hidden=YES;
    }else if (tiezi.type==hp_tiezishiping)
    {
        self.shipingView.hidden=NO;
        self.shipingView.frame=tiezi.contentF;
        self.shipingView.tiezi=tiezi;
        self.voiceView.hidden=YES;
        self.pictureView.hidden=YES;
    }else if (tiezi.type==hp_tiezitext)
    {
        self.voiceView.hidden=YES;
        self.pictureView.hidden=YES;
        self.shipingView.hidden=YES;
    }else if (tiezi.type==hp_tieziVoice)
    {
        self.voiceView.hidden = NO;
        self.voiceView.frame = tiezi.contentF;
        self.voiceView.tiezi = tiezi;
        self.shipingView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    
}
-(void)setButton:(UIButton*)button number:(NSInteger)number placeholder:(NSString*)placeholder
{
    if (number>10000)
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number/10000.0] forState:UIControlStateNormal];
    else
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
}
- (IBAction)more {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet  showInView:self.window];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ding:(id)sender {
}
@end
