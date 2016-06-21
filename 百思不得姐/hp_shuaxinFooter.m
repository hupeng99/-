//
//  hp_shuaxinFooter.m
//  baisi
//
//  Created by 胡鹏 on 16/5/25.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_shuaxinFooter.h"

@implementation hp_shuaxinFooter
- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor grayColor];
    [self setTitle:@"没有啦" forState:MJRefreshStateNoMoreData];
    [self setTitle:@"" forState:MJRefreshStateIdle];
}
@end
