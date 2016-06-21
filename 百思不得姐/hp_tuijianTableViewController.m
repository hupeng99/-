//
//  hp_tuijianTableViewController.m
//  baisi
//
//  Created by 胡鹏 on 16/5/24.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_tuijianTableViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "hp_tuijian.h"
#import "hp_tuijianTableViewCell.h"

@interface hp_tuijianTableViewController ()
@property (nonatomic, strong) NSArray *tags;
@end

@implementation hp_tuijianTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    [self loadTags];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 设置表格
-(void)setTableView {
    self.navigationItem.title = @"推荐标签";
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([hp_tuijianTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"tuijian"];
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark 加载数据
-(void)loadTags {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.tags = [hp_tuijian mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"加载标签数据失败!"];
//        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    hp_tuijianTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"tuijian"];
    Cell.tuijian = self.tags[indexPath.row];
    return Cell;
}
@end
