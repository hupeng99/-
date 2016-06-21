//
//  hp_CommentHeader.h
//  baisi
//
//  Created by 胡鹏 on 16/5/29.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hp_CommentHeader : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *title;
+(instancetype)headerViewTableView:(UITableView *)tableView;
@end
