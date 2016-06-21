//
//  hp_MeViewController.m
//  百思不得姐
//
//  Created by 胡鹏 on 16/5/20.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_MeViewController.h"
#import "hp_settingViewController.h"
#import "hp_table_foot.h"
#import "hp_lognViewController.h"
#import <DKNightVersion/DKNightVersion.h>

@interface hp_MeViewController ()

@end

@implementation hp_MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.sectionFooterHeight=10;
    self.tableView.sectionHeaderHeight=0;
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    self.tableView.tableFooterView=[[hp_table_foot alloc]init];
    [self setNagitionbar];
    // Do any additional setup after loading the view.
}
-(void)setNagitionbar
{
    self.navigationItem.title=@"我的";
    UIButton* button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [button1 addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [button1 sizeToFit];
    UIBarButtonItem* item1=[[UIBarButtonItem alloc]initWithCustomView:button1];
    
    UIButton* button2=[UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(moonmodal) forControlEvents:UIControlEventTouchUpInside];
    [button2 sizeToFit];
    UIBarButtonItem* item2=[[UIBarButtonItem alloc]initWithCustomView:button2];
    self.navigationItem.rightBarButtonItems=@[item1,item2];
}

-(void)setting
{
    [self.navigationController pushViewController:[[hp_settingViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}
-(void)moonmodal
{
    [MBProgressHUD showError:@"功能正在完善"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID=@"cell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0)
    {
        cell.textLabel.text=@"登录/注册";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section==1)
    {
        cell.textLabel.text=@"离线下载";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
        [self presentViewController:[[hp_lognViewController alloc]init] animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
