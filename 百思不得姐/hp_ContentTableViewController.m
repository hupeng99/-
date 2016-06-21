//
//  hp_ContentTableViewController.m
//  baisi
//
//  Created by 胡鹏 on 16/5/24.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_ContentTableViewController.h"
#import "hp_tiezi.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "hp_tieziTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "hp_NewViewController.h"
#import "MJRefresh.h"
#import "hp_shuaxinFooter.h"
#import "hp_CommentViewController.h"
@interface hp_ContentTableViewController ()
@property (nonatomic, strong) NSMutableArray<hp_tiezi *> *tiezis;
@property(nonatomic,strong)UIImageView* image;
@property(nonatomic,copy)NSString* maxtime;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSDictionary* parmas;
@end

@implementation hp_ContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTable];
    [self setshuaxin];
}
-(void)setTable
{
    self.tableView.separatorStyle=UITableViewCellAccessoryNone;
    self.tableView.contentInset=UIEdgeInsetsMake(64+35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets=self.tableView.contentInset;
    [self.tableView registerNib:[UINib nibWithNibName:@"hp_tieziTableViewCell" bundle:nil] forCellReuseIdentifier:@"tiezi"];
}
- (NSString *)aParam
{
    if (self.parentViewController.class==[hp_NewViewController class])
        return @"newlist";
    return @"list";
}
-(void)setshuaxin
{
//    self.tableView.mj_header=[hp_shuaxinHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadtiezi)];
//    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadtiezi)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[hp_shuaxinFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoretiezi)];
}
-(void)loadtiezi
{
    HPLog(@"%@",NSHomeDirectory());
    [self.tableView.mj_footer endRefreshing];
    //参数
    NSString* sql=@"create table tiedata(id text primary key not null,name text,profile_image text,text text,created_at text,ding integer,cai interger,repost interger,comment interger,width numeric,height numeric,image0 text,image2 text,image1 text,cellHeight numeric,voicetime integer,videotime integer,playcount integer,is_gif interger,bigPicture interger,videouri text);";
    [[SQLManger shareIntance]execSQL:sql];
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    params[@"a"]=self.aParam;
    params[@"c"]=@"data";
    params[@"type"]=@(self.type);
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime=responseObject[@"info"][@"maxtime"];
        self.tiezis=[hp_tiezi mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        for (hp_tiezi* tie in self.tiezis)
        {
            NSString* sqll=[NSString stringWithFormat:@"insert into tiedata (id,name,profile_image,text,created_at,ding,cai,repost,comment,width,height,image0,image2,image1,cellHeight,voicetime,videotime,playcount,is_gif,bigPicture,videouri) values('%@','%@','%@','%@','%@','%ld','%ld','%ld','%ld','%f','%f','%@','%@','%@','%f','%ld','%ld','%ld','%d','%d','%@')",tie.ID, tie.name, tie.profile_image, tie.text, tie.created_at, tie.ding,tie.cai,tie.repost,tie.comment,tie.width,tie.height,tie.small_image,tie.middle_image,tie.large_image,tie.cellHeight,tie.voicetime,tie.videotime,tie.playcount,tie.is_gif,tie.bigPicture,tie.videouri];
            [[SQLManger shareIntance]execSQL:sqll];
//            NSLog(@"%d", [[SQLManger shareIntance]execSQL:sqll]);
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* sql=@"select * from tiedata";
        NSArray* array=[[SQLManger shareIntance]querySQL:sql];
//        NSLog(@"%@",array[0]);
        self.tiezis=[hp_tiezi mj_objectArrayWithKeyValuesArray:array];
//        NSLog(@"%@",_tiezis[0].large_image);
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        }];
}
-(void)loadMoretiezi
{
    //取消所有请求
//    [[AFHTTPSessionManager manager].tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    params[@"a"]=self.aParam;
    params[@"c"]=@"data";
    params[@"maxtime"]=self.maxtime;
    params[@"type"]=@(self.type);
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime=responseObject[@"info"][@"maxtime"];
        NSArray *newtiezi=[hp_tiezi mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tiezis addObjectsFromArray:newtiezi];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tiezis.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    hp_tieziTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"tiezi"];
    cell.tiezi=self.tiezis[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    hp_tiezi *tiezi = self.tiezis[indexPath.row];
    return tiezi.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    hp_CommentViewController *comment = [[hp_CommentViewController alloc] init];
    comment.tiezi = self.tiezis[indexPath.row];
    [self.navigationController pushViewController:comment animated:YES];
}
-(NSMutableArray *)tiezis{
    if (_tiezis == nil) {
        _tiezis = [[NSMutableArray alloc] init];
    }
    return _tiezis;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
