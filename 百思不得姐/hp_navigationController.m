//
//  hp_navigationController.m
//  百思不得姐
//
//  Created by 胡鹏 on 16/5/21.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_navigationController.h"

@interface HP_navigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HP_navigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate=self;
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count>0)
    {
        UIButton* backbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [backbutton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backbutton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backbutton setTitle:@"返回" forState:UIControlStateNormal];
        [backbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backbutton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backbutton sizeToFit];
        backbutton.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
        [backbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backbutton];
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
}
-(void)back
{
    [self popToRootViewControllerAnimated:YES];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count>1;
}
@end
