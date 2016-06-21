//
//  hp_table_foot.m
//  百思不得姐
//
//  Created by 胡鹏 on 16/5/22.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_table_foot.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "hp_square.h"
#import <SafariServices/SafariServices.h>
#import "hp_Mebutton.h"

@interface hp_table_foot ()
@property(nonatomic,strong)NSArray* array;
@end
@implementation hp_table_foot

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        NSMutableDictionary* dic=[NSMutableDictionary dictionary];
        dic[@"a"]=@"square";
        dic[@"c"]=@"topic";
        [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:dic  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [responseObject writeToFile:@"/Users/hupeng/Desktop/data.plist" atomically:YES];
            NSArray* square=[hp_square mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            self.array=[NSArray arrayWithArray:square];
            NSMutableArray* arr=[[NSMutableArray alloc]init];
            [arr addObject:_array[0]];
            for (int i=1;i<self.array.count;i++)
            {
                if (![[self.array[i] valueForKey:@"name"] isEqualToString:[arr.lastObject valueForKey:@"name"] ])
                    [arr addObject:self.array[i]];
            }
            [self arrayoffile:arr];
            [self setbutton:arr];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString* path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data"];
            self.array=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
            [self setbutton:self.array];
            HPLog(@"请求失败 - %@", error);}];
    }
    return self;
}
-(void)arrayoffile:(NSArray*)arr
{
    NSString* path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data"];
    [NSKeyedArchiver archiveRootObject:arr toFile:path];
}
-(void)setbutton:(NSArray* )square
{
    NSUInteger count = square.count;
    
    NSUInteger maxColsCount = 4;
    CGFloat buttonW = self.frame.size.width / maxColsCount;
    CGFloat buttonH = buttonW;
    
    // 创建所有的方块
    for (NSUInteger i = 0; i < count; i++) {
        hp_Mebutton *button = [hp_Mebutton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        button.xmg_x = (i % maxColsCount) * buttonW;
        button.xmg_y = (i / maxColsCount) * buttonH;
        button.xmg_width = buttonW;
        button.xmg_height = buttonH;
        
        button.square = square[i];
    }
    
    self.xmg_height = self.subviews.lastObject.xmg_bottom;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData]; // 重新刷新数据(会重新计算contentSize)

}
-(void)buttonClick:(hp_Mebutton *)button
{
    
}
@end
