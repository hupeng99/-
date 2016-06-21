//
//  hp_tuijianTableViewCell.m
//  baisi
//
//  Created by 胡鹏 on 16/5/27.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_tuijianTableViewCell.h"
#import "hp_tuijian.h"
#import "UIImageView+WebCache.h"
#import "UIimageView+hp.h"
@interface hp_tuijianTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *theme_name;
@property (weak, nonatomic) IBOutlet UILabel *sub_name;
@property (weak, nonatomic) IBOutlet UIButton *dingyue;
- (IBAction)dingyue:(id)sender;

@end

@implementation hp_tuijianTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame {
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}
-(void)setTuijian:(hp_tuijian *)tuijian
{
    _tuijian = tuijian;
    
    [self.image setCircleHeader:tuijian.image_list];
    self.theme_name.text = tuijian.theme_name;
    NSString *fansCount = nil;
    if (tuijian.sub_number < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人订阅",tuijian.sub_number];
    } else {//>= 10000
        fansCount = [NSString stringWithFormat:@"%.1f万人订阅",tuijian.sub_number / 10000.0];
    }
    self.sub_name.text = fansCount;
}

- (IBAction)dingyue:(id)sender {
    [MBProgressHUD showSuccess:@"订阅成功"];
}
@end
