//
//  hp_NewViewController.m
//  百思不得姐
//
//  Created by 胡鹏 on 16/5/20.
//  Copyright © 2016年 胡鹏. All rights reserved.
//

#import "hp_NewViewController.h"

@interface hp_NewViewController ()<UIImagePickerControllerDelegate>

@end

@implementation hp_NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNagitionbar];
    // Do any additional setup after loading the view.
}
-(void)setNagitionbar
{
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"camera"] style:UIBarButtonItemStylePlain target:self action:@selector(camera)];
}
-(void)camera
{
    [self openPics];
}
//-(void)OpenCream
//{
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame= CGRectMake(0, 0, 80, 120);
//    imageView.backgroundColor= [UIColor greenColor];
//    imageView.tag= 101;
//    [self.view addSubview:imageView];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame= CGRectMake(0, 200, 100, 30);
//    [button setTitle:@"打开相册"forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(openPics)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button]; 
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button2.frame = CGRectMake(0, 300, 100, 30);
//    [button2 setTitle:@"打开相机"forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(openCamera)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button2];
//}
//- (void)openCamera {
//    UIImagePickerControllerCameraDeviceRear;  //后置摄像头
//    UIImagePickerControllerCameraDeviceFront;  //前置摄像头
//    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
//    if(!isCamera) {
//        NSLog(@"没有摄像头");
//        return;
//    }
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    imagePicker.sourceType= UIImagePickerControllerSourceTypeCamera;
//    imagePicker.delegate= self;
//    //    编辑模式
//    imagePicker.allowsEditing= YES;
//    [self presentViewController:imagePicker animated:YES completion:^{ }];
//    
//}
// 打开相册
- (void)openPics {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate= self;
    [self presentViewController:imagePicker animated:YES
     completion:^{
 
     }];
}
// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:101];
//    UIImagePickerControllerOriginalImage 原始图片
//    UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    imageView.image= image;
//    [picker dismissViewControllerAnimated:YES completion:NULL];
}
// //取消相册
//- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker {
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//}
//- (void)Open:(id)sender {
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
//        picker.mediaTypes = temp_MediaTypes;
//        picker.delegate = self;
//        picker.allowsImageEditing = YES;
//    }
//    [self presentModalViewController:picker animated:YES];
//}


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
