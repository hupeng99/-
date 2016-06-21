//
//  hp_CommentHeader.m
//  baisi
//
//  Created by 胡鹏 on 16/5/29.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_CommentHeader.h"
#import "UIView+XMGExtension.h"

@interface hp_CommentHeader ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation hp_CommentHeader
+(instancetype)headerViewTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    hp_CommentHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[self alloc] initWithReuseIdentifier:ID];
        
    }
    return header;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = HPColor(233, 233, 233);
        UILabel *label = [[UILabel alloc] init];
        label.xmg_x = 10;
        label.xmg_width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.textColor = HPColor(67, 67, 67);
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

-(void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

@end
