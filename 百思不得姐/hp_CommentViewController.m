//
//  hp_CommentViewController.m
//  baisi
//
//  Created by 胡鹏 on 16/5/29.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_CommentViewController.h"
#import "hp_tieziTableViewCell.h"
#import "hp_tiezi.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "hp_Comment.h"
#import "MJExtension.h"
#import "hp_CommentTableViewCell.h"
#import "hp_CommentViewController.h"
#import "SVProgressHUD.h"
#import "hp_CommentHeader.h"

@interface hp_CommentViewController ()
//工具条底部间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//最热评论
@property (nonatomic, strong) NSArray *hotComments;
//最新评论
@property (nonatomic, strong) NSMutableArray *lastestComments;
//保存top_cmt
@property (nonatomic, strong) hp_Comment *saved_top_cmt;
//保存当前页码
@property (nonatomic, assign) NSInteger page;
@end

@implementation hp_CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupHeader];
    [self setupRefresh];
}


-(void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

-(void)loadNewComments {
    [ [AFHTTPSessionManager manager].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"hot"] = @"1";
    params[@"data_id"] = self.tiezi.ID;
    [ [AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //页码
        self.page = 1;
        //说明没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        //最热评论
        self.hotComments = [hp_Comment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.lastestComments = [hp_Comment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastestComments.count > total) { //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
//        [SVProgressHUD showErrorWithStatus:@"加载数据失败!" maskType:SVProgressHUDMaskTypeBlack];
        [MBProgressHUD showError:@"加载数据失败"];
    }];
}

-(void)loadMoreComments {
    
    NSInteger page = self.page + 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.tiezi.ID;
    hp_Comment *comment = [self.lastestComments lastObject];
    params[@"lastid"] = comment.ID;
    params[@"page"] = @(page);
   
    [ [AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //说明没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return ;
        }
        
        //最新评论
        NSArray *newComments = [hp_Comment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.lastestComments addObjectsFromArray:newComments];
        
        [self.tableView reloadData];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastestComments.count > total) { //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else { //数据满了，结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"加载数据失败"];
    }];
}

-(void)setupHeader {
    UIView *header = [[UIView alloc] init];
    
    //清空top_cmt
    if (self.tiezi.top_cmt) {
        self.saved_top_cmt = self.tiezi.top_cmt;
        self.tiezi.top_cmt = nil;
        [self.tiezi setValue:@0 forKey:@"cellHeight"];
    }
    
    hp_tieziTableViewCell *cell = [hp_tieziTableViewCell viewFromXib];
    cell.tiezi = self.tiezi;;
    cell.xmg_height = self.tiezi.cellHeight;
    cell.xmg_width = [UIScreen mainScreen].bounds.size.width;
    [header addSubview:cell];
    header.xmg_height = self.tiezi.cellHeight + 10;
    self.tableView.tableHeaderView = header;
    self.tableView.backgroundColor = HPColor(233, 233, 233);
}

-(void)setupBasic {
    self.navigationItem.title = @"评论";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 65;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([hp_CommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"comment"];
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

-(void)keyboardWillChangeFrame:(NSNotification *)notification {
    //键盘显示/隐藏完毕的frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastestCount = self.lastestComments.count;
    if (hotCount) return 2; //有最热评论+最新评论  2组
    if (lastestCount) return 1; //最新评论  1组
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastestCount = self.lastestComments.count;
    
    tableView.mj_footer.hidden = (lastestCount == 0);
    if (section == 0) {
        return hotCount ? hotCount : self.lastestComments.count;
    }
    return self.lastestComments.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //先从缓存池中找
    hp_CommentHeader *header = [hp_CommentHeader headerViewTableView:tableView];
    
    if (section == 0) {
        header.title = self.hotComments.count ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"评论";
    }
    
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    hp_CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}
-(NSArray *)commentInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.lastestComments;
    }
    return self.lastestComments;
}

-(hp_Comment *)commentInIndexPath:(NSIndexPath *)indexPath {
    return [self commentInSection:indexPath.section][indexPath.row];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //回复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.tiezi.top_cmt = self.saved_top_cmt;
        [self.tiezi setValue:@0 forKey:@"cellHeight"];
    }
    //取消所有任务
    [ [AFHTTPSessionManager manager] invalidateSessionCancelingTasks:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


-(NSMutableArray *)lastestComments{
    if (_lastestComments == nil) {
        _lastestComments = [[NSMutableArray alloc] init];
    }
    return _lastestComments;
}

@end
