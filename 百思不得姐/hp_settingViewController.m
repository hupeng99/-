//
//  hp_settingViewController.m
//  百思不得姐
//
//  Created by 胡鹏 on 16/5/21.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_settingViewController.h"
#import "MBProgressHUD+MJ.h"
@interface hp_settingViewController ()
@property(nonatomic,strong)NSArray* array;
@property(nonatomic,copy)NSString* cun;
@end

@implementation hp_settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionFooterHeight=0;
//    self.tableView.sectionHeaderHeight=;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.navigationItem.title=@"设置";
    self.cun=@"清除缓存(1.15M)";
    

    // Do any additional setup after loading the view.
}
-(NSArray*)array
{
    if (!_array)
    {
      
        _array=[[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"SettingList.plist" ofType:nil]];
    }
    return _array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 2;
    else
        return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID=@"cell";
    
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    if (indexPath.section==0)
    {
        cell.textLabel.text=self.array[indexPath.section][indexPath.row];
        UISwitch* swit=[[UISwitch alloc]initWithFrame:CGRectMake(315,7, 0, 0)];
        [cell addSubview:swit];
    }
    else if(indexPath.section==1 && indexPath.row==0)
    {
        cell.textLabel.text=self.cun;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.textLabel.text=self.array[indexPath.section][indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) return @"功能设置";
    else  return @"其他";
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1&&indexPath.row==0)
    {
        self.cun=@"清除缓存";
        [MBProgressHUD showSuccess:@"清除缓存成功!"];
        NSArray * array=[NSArray arrayWithObject:indexPath];
        [tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationLeft];
    }
}
@end
