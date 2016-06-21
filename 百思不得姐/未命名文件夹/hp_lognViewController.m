

#import "hp_lognViewController.h"
//#import "XMGLoginRegisterTextField.h"

@interface hp_lognViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (weak, nonatomic) IBOutlet UITextField *shoujihao;
@property (weak, nonatomic) IBOutlet UITextField *mima;
@end

@implementation hp_lognViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)showLoginOrRegister:(UIButton *)button {

    [self.view endEditing:YES];
    
    if (self.leftMargin.constant) {
        self.leftMargin.constant = 0;
        button.selected = NO;
    } else {
        self.leftMargin.constant = - self.view.frame.size.width;
        button.selected = YES;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)denglu:(id)sender {
}
- (IBAction)zhuce:(id)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
