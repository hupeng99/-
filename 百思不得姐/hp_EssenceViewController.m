//
//  hp_EssenceViewController.m
//  百思不得姐
//
//  Created by 胡鹏 on 16/5/20.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_EssenceViewController.h"
#import "hp_Essence_button.h"
#import "hp_ContentTableViewController.h"
#import "hp_tuijianTableViewController.h"
@interface hp_EssenceViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView* scroll;
@property(nonatomic,weak)hp_Essence_button* Selectbutton;
@property(nonatomic,weak)UIView* india;
@property(nonatomic,weak)UIView* titleView;
@end

@implementation hp_EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNagitionbar];
    [self setChildViewController];
    [self setScrollView];
    [self setTilteView];
    [self addChildView];
    // Do any additional setup after loading the view.
}
-(void)setChildViewController
{
    hp_ContentTableViewController * all=[[hp_ContentTableViewController alloc]init];
    all.type=hp_tieziAll;
    [self addChildViewController:all];
    
    hp_ContentTableViewController * shipin=[[hp_ContentTableViewController alloc]init];
    shipin.type=hp_tiezishiping;
    [self addChildViewController:shipin];
    
    hp_ContentTableViewController * voice=[[hp_ContentTableViewController alloc]init];
    voice.type=hp_tieziVoice;
    [self addChildViewController:voice];
    
    hp_ContentTableViewController * pic=[[hp_ContentTableViewController alloc]init];
    pic.type=hp_tieziPicture;
    [self addChildViewController:pic];
    
    hp_ContentTableViewController * text=[[hp_ContentTableViewController alloc]init];
    text.type=hp_tiezitext;
    [self addChildViewController:text];
    
}
-(void)setScrollView
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIScrollView* scrollview=[[UIScrollView alloc]init];
    scrollview.frame=self.view.bounds;
    scrollview.pagingEnabled = YES;
    scrollview.showsHorizontalScrollIndicator=NO;
    scrollview.showsVerticalScrollIndicator=NO;
    scrollview.contentSize = CGSizeMake(self.childViewControllers.count * scrollview.xmg_width, 0);
    [self.view addSubview:scrollview];
    self.scroll=scrollview;
    self.scroll.delegate=self;
}
-(void)setTilteView
{
    UIView* Essence_view=[[UIView alloc]init];
    Essence_view.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.8];
    self.titleView=Essence_view;
    Essence_view.frame=CGRectMake(0,64, self.view.frame.size.width, 35);
    [self.view addSubview:Essence_view];//加入标题视图
    
    NSArray* array=[NSArray arrayWithObjects:@"全部",@"视频",@"声音",@"图片",@"段子", nil];
    CGFloat buttonW=Essence_view.xmg_width/array.count;
    CGFloat buttonH=Essence_view.xmg_height;
    for (int i=0; i<array.count; i++)
    {
        hp_Essence_button* button=[hp_Essence_button buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(buttonW*i, 0, buttonW, buttonH);
        button.tag=i;
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button addTarget:self  action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [Essence_view addSubview:button];
    }
    hp_Essence_button* firstTitleButton=Essence_view.subviews.firstObject;
 
    UIView* india=[[UIView alloc]init];
    india.backgroundColor=[firstTitleButton titleColorForState:UIControlStateSelected];
    india.xmg_height=1;
    india.xmg_y=Essence_view.xmg_height-india.xmg_height;
    
    [firstTitleButton.titleLabel sizeToFit];
    india.xmg_width=firstTitleButton.titleLabel.xmg_width;
    india.xmg_centerX=firstTitleButton.xmg_centerX;
    
    self.india=india;
    [Essence_view addSubview:india];

    firstTitleButton.selected=YES;//设置默认点击button
    self.Selectbutton=firstTitleButton;
    
}
-(void)buttonClick:(hp_Essence_button*)button
{
    self.Selectbutton.selected=NO;
    button.selected=YES;
    self.Selectbutton=button;//切换button
    
    [UIView animateWithDuration:0.1 animations:^{
        self.india.xmg_width = button.titleLabel.xmg_width;
        self.india.xmg_centerX = button.xmg_centerX;
    }];//底部View切换
    
    CGPoint move = self.scroll.contentOffset;
    move.x = button.tag * self.scroll.xmg_width;
    [self.scroll setContentOffset:move animated:YES];
}
-(void)addChildView
{
    NSUInteger index=self.scroll.contentOffset.x/self.scroll.xmg_width;
    hp_ContentTableViewController * childViewControl=self.childViewControllers[index];
    if ([childViewControl isViewLoaded]) return;
    childViewControl.view.frame = self.scroll.bounds;
    [self.scroll addSubview:childViewControl.view];
}
-(void)setNagitionbar
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MainTagSubIconClick"] style:UIBarButtonItemStylePlain target:self action:@selector(MainTagSub)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_coin_icon_click"] style:UIBarButtonItemStylePlain target:self action:@selector(coin)];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    hp_Essence_button *titleButton = self.titleView.subviews[index];
    [self buttonClick:titleButton];
    [self addChildView];
} 
-(void)MainTagSub
{
    [self.navigationController pushViewController:[[hp_tuijianTableViewController alloc]init] animated:YES];
}
-(void)coin
{
    [MBProgressHUD showMessage:@"小主正在努力创作中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
