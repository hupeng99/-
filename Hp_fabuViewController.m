//
//  Hp_fabuViewController.m
//  百思不得姐
//
//  Created by 胡鹏 on 16/5/20.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "Hp_fabuViewController.h"
#import "POP.h"
#import "hp_button.h"
@interface Hp_fabuViewController ()
@end

@implementation Hp_fabuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled=YES;
    UIImageView* image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shareBottomBackground"]];
    image.frame=self.view.frame;
    [self.view addSubview:image];
    [self setButton];
    
}
-(void)setButton
{
    UIButton* quxiao=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
    quxiao.backgroundColor=[UIColor whiteColor];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [quxiao addTarget:self  action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quxiao];
    
    UIImageView* biao=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    biao.frame=CGRectMake(80, 100, 200, 30);
    [biao sizeToFit];
    [self.view addSubview:biao];
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    CGFloat buttonW=72;
    CGFloat buttonH=buttonW+30;
    CGFloat buttonX=20;
    CGFloat buttonY=([UIScreen mainScreen].bounds.size.height-2*buttonH)*0.5;
    CGFloat kong=([UIScreen mainScreen].bounds.size.width-2*buttonX-3*buttonW)/2;
    for (int i=0; i<titles.count; i++)
    {
        hp_button* button=[[hp_button alloc]init];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        int row = (int)(i / 3);
        int col = i % 3;
        CGFloat buttonx = buttonX + col * (kong + buttonW);
        CGFloat buttonEndY = buttonY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - [UIScreen mainScreen].bounds.size.height;
        
        POPSpringAnimation* anim=[POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue=[NSValue valueWithCGRect:CGRectMake(buttonx, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonx, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = 10;
        anim.springSpeed = 10;
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        [button pop_addAnimation:anim forKey:nil];
    }
}
-(void)buttonClick:(UIButton*)button
{
     [self cancelWithCompletionBlock:nil];
}
-(void)cancelWithCompletionBlock:(void (^)())completionBlock {
    self.view.userInteractionEnabled = NO;
    int beginIndex = 2;
    for (int i = beginIndex; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.center.y + [UIScreen mainScreen].bounds.size.height;
        // 动画的执行节奏(一开始很慢, 后面很快)
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.center.x, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * 0.1;
        [subview pop_addAnimation:anim forKey:nil];
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelWithCompletionBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}
-(void)quxiao
{
   [self cancelWithCompletionBlock:^{
       [self dismissViewControllerAnimated:YES completion:nil];
   }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
