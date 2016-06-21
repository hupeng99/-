//
//  HptabbarViewController.m
//  百思不得姐
//
//  Created by 胡鹏 on 16/5/20.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "HptabbarViewController.h"
#import "Hp_fabuViewController.h"
#import "hp_MeViewController.h"
#import "hp_NewViewController.h"
#import "hp_Follow_ViewController.h"
#import "hp_EssenceViewController.h"
#import "hp_tabbar.h"
#import "hp_navigationController.h"
#import "Hp_fabuViewController.h"
@interface HptabbarViewController ()
@property(strong,nonatomic)UIButton* button_fabu;
@end

@implementation HptabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabbarButtonArrtibute];
    [self setViewController];
    [self setValue:[[hp_tabbar alloc]init] forKeyPath:@"tabBar"];
        // Do any additional setup after loading the view.
}
-(void)setViewController
{
    [self setChildViewController:[[HP_navigationController alloc]initWithRootViewController:[[hp_EssenceViewController alloc]init]] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setChildViewController:[[HP_navigationController alloc]initWithRootViewController:[[hp_NewViewController alloc]init]] title:@"最新" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setChildViewController:[[HP_navigationController alloc]initWithRootViewController:[[hp_Follow_ViewController alloc]init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setChildViewController:[[HP_navigationController alloc]initWithRootViewController:[[hp_MeViewController alloc]initWithStyle:UITableViewStyleGrouped]] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_new_click_icon"];
}
-(void)setTabbarButtonArrtibute
{
    UITabBarItem* item=[UITabBarItem appearance];
    //普通模式
    NSMutableDictionary* attribute=[NSMutableDictionary dictionary];
    attribute[NSFontAttributeName]=[UIFont systemFontOfSize:14];
    attribute[NSForegroundColorAttributeName]=[UIColor grayColor];//文字颜色
    [item setTitleTextAttributes:attribute forState:UIControlStateNormal];
    //选中模式下
    NSMutableDictionary* selectAttribute=[NSMutableDictionary dictionary];
    selectAttribute[NSForegroundColorAttributeName]=[UIColor darkTextColor];
    [item setTitleTextAttributes:selectAttribute forState:UIControlStateSelected];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.view.backgroundColor=[UIColor grayColor];
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:image];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    [self addChildViewController:vc];
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
