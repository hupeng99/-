//
//  hp_CommentTableViewCell.m
//  baisi
//
//  Created by 胡鹏 on 16/5/29.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_CommentTableViewCell.h"
#import "hp_Comment.h"
#import "hp_User.h"
#import <UIImageView+WebCache.h>
#import "UIimage+hp.h"
#import "UIimageView+hp.h"

@interface hp_CommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation hp_CommentTableViewCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setComment:(hp_Comment *)comment{
    _comment = comment;
    
    [self.profileImageView setCircleHeader:comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

-(void)setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.size.width -= 2 * 10;
    [super setFrame:frame];
}
@end
