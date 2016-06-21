//
//  hp_square.m
//  baisi
//
//  Created by 胡鹏 on 16/5/23.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_square.h"

@implementation hp_square
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self->_icon=[aDecoder decodeObjectForKey:@"icon"];
    self->_name=[aDecoder decodeObjectForKey:@"name"];
    self->_url=[aDecoder decodeObjectForKey:@"url"];
    return self;
    
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self->_name forKey:@"name"];
    [aCoder encodeObject:self->_url forKey:@"url"];
    [aCoder encodeObject:self->_icon forKey:@"icon"];
}
@end
