//
//  hp_Follow_ViewController.m
//  百思不得姐
//
//  Created by 胡鹏 on 16/5/21.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_Follow_ViewController.h"
#import "hp_lognViewController.h"
#import "hp_tuijianTableViewController.h"
@interface hp_Follow_ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button_logn;
@property (weak, nonatomic) IBOutlet UIButton *button_zhuce;
- (IBAction)logn:(id)sender;
- (IBAction)zhuce:(id)sender;

@end

@implementation hp_Follow_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNagitionbar];
    [self setButton];
    // Do any additional setup after loading the view from its nib.
}
-(void)setButton
{
    self.button_logn.layer.cornerRadius=5;
    self.button_zhuce.layer.cornerRadius=5;
    self.button_zhuce.layer.borderWidth=1;
    self.button_zhuce.layer.borderColor=[UIColor redColor].CGColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setNagitionbar
{
    self.navigationItem.title=@"我的关注";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(tuijianguanzhu)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"订阅" style:UIBarButtonItemStylePlain target:self action:@selector(dingyue)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor darkTextColor]];
}
-(void)tuijianguanzhu
{
    
}
-(void)dingyue
{
    [self.navigationController pushViewController:[[hp_tuijianTableViewController alloc]init] animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logn:(id)sender {
    [self presentViewController:[[hp_lognViewController alloc]init] animated:YES completion:nil];
}

- (IBAction)zhuce:(id)sender {
    [self presentViewController:[[hp_lognViewController alloc]init] animated:YES completion:nil];
}
@end
