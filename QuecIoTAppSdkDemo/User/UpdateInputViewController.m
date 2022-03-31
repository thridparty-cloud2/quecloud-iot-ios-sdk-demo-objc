//
//  UpdateInputViewController.m
//  QuecUserKitExample
//
//  Created by quectel.steven on 2021/9/6.
//

#import "UpdateInputViewController.h"
#import <QuecUserKit/QuecUserKit.h>
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface UpdateInputViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation UpdateInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"修改";
    CGFloat viewWidth = self.view.frame.size.width;
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200,viewWidth - 60, 50)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.textColor = [UIColor lightGrayColor];
    self.textField.font = [UIFont systemFontOfSize:16];
    self.textField.placeholder = @"请输入";
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.layer.cornerRadius = 10.0;
    sureButton.layer.borderColor = [UIColor grayColor].CGColor;
    sureButton.layer.borderWidth = 0.5;
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.frame = CGRectMake(30, 510, viewWidth - 60, 44);
    [sureButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
}
- (void)sureButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    switch (self.type) {
        case 1: {
            [[QuecUserService sharedInstance] updateUserNickName:self.textField.text success:^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.view makeToast:@"修改成功" duration:3 position:CSToastPositionCenter];
                [self.navigationController popViewControllerAnimated:YES];
                        } failure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
                        }];
        }
            break;
        case 2: {
            [[QuecUserService sharedInstance] updateUserAddress:self.textField.text success:^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.view makeToast:@"修改成功" duration:3 position:CSToastPositionCenter];
                [self.navigationController popViewControllerAnimated:YES];
                        } failure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
                        }];
        }
            break;
        
            
        default:
            break;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [self.textField resignFirstResponder];
    return YES;
}

@end
