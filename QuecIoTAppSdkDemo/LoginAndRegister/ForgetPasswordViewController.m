//
//  ForgetPasswordViewController.m
//  QuecUserKitExample
//
//  Created by quectel.steven on 2021/9/4.
//

#import "ForgetPasswordViewController.h"
#import <Toast/Toast.h>
#import <QuecUserKit/QuecUserKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ForgetPasswordViewController ()
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *smsTextField;
@property (nonatomic, strong) UITextField *pswTextField;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"忘记密码";
    CGFloat viewWidth = self.view.frame.size.width;
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200,viewWidth - 60, 50)];
    self.phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    if (self.type == 1) {
        self.phoneTextField.placeholder = @"请输入手机号";
    }
    else {
        self.phoneTextField.placeholder = @"请输入邮箱";
    }
    self.phoneTextField.textColor = [UIColor lightGrayColor];
    self.phoneTextField.font = [UIFont systemFontOfSize:16];
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.phoneTextField];
    
    self.smsTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 280,viewWidth - 180, 50)];
    self.smsTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.smsTextField.placeholder = @"请输入验证码";
    self.smsTextField.textColor = [UIColor lightGrayColor];
    self.smsTextField.font = [UIFont systemFontOfSize:16];
    self.smsTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.smsTextField];
    
    UIButton *smsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [smsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    smsButton.frame = CGRectMake(viewWidth - 120, 290, 90, 30);
    [smsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    smsButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [smsButton addTarget:self action:@selector(smsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:smsButton];
    
    
    self.pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 360,viewWidth - 60, 50)];
    self.pswTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.pswTextField.placeholder = @"请输入密码";
    self.pswTextField.textColor = [UIColor lightGrayColor];
    self.pswTextField.font = [UIFont systemFontOfSize:16];
    self.pswTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.pswTextField];
    
    
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
    if (self.type == 1) {
        [[QuecUserService sharedInstance] resetPasswordByPhone:self.phoneTextField.text ? : @"" code:self.smsTextField.text ? : @"" internationalCode:@"86" password:self.pswTextField.text ? : @"" success:^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"密码设置成功" duration:3 position:CSToastPositionCenter];
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            }];
    }
    else {
        [[QuecUserService sharedInstance] resetPasswordByEmail:self.phoneTextField.text ? : @"" code:self.smsTextField.text ? : @"" internationalCode:@"86" password:self.pswTextField.text ? : @"" success:^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"密码设置成功" duration:3 position:CSToastPositionCenter];
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            }];
    }
}

- (void)smsButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.type == 1) {
        [[QuecUserService sharedInstance] sendVerifyCodeByPhone:self.phoneTextField.text ? : @"" internationalCode:@"86" type:1 ssid:nil stid:nil success:^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"验证码发送成功" duration:3 position:CSToastPositionCenter];
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            }];
    }
    else {
        [[QuecUserService sharedInstance] sendVerifyCodeByEmail:self.phoneTextField.text ? : @"" type:2 success:^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"验证码发送成功" duration:3 position:CSToastPositionCenter];
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            }];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneTextField resignFirstResponder];
    [self.pswTextField resignFirstResponder];
}

@end
