//
//  UpdatePhoneViewController.m
//  QuecUserKitExample
//
//  Created by quectel.steven on 2021/9/6.
//

#import "UpdatePhoneViewController.h"
#import <Toast/Toast.h>
#import <QuecUserKit/QuecUserKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface UpdatePhoneViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *oldPhoneTextField;
@property (nonatomic, strong) UITextField *oldSmsTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *smsTextField;
@end

@implementation UpdatePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"修改手机号";
    CGFloat viewWidth = self.view.frame.size.width;
    self.oldPhoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 170,viewWidth - 200, 50)];
    self.oldPhoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.oldPhoneTextField.placeholder = @"请输入当前手机号";
    self.oldPhoneTextField.textColor = [UIColor lightGrayColor];
    self.oldPhoneTextField.font = [UIFont systemFontOfSize:16];
    self.oldPhoneTextField.returnKeyType = UIReturnKeyDone;
    self.oldPhoneTextField.delegate = self;
    [self.view addSubview:self.oldPhoneTextField];
    
    self.oldSmsTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 250,viewWidth - 140, 50)];
    self.oldSmsTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.oldSmsTextField.placeholder = @"请输入当前手机号验证码";
    self.oldSmsTextField.textColor = [UIColor lightGrayColor];
    self.oldSmsTextField.font = [UIFont systemFontOfSize:16];
    self.oldSmsTextField.returnKeyType = UIReturnKeyDone;
    self.oldSmsTextField.delegate = self;
    [self.view addSubview:self.oldSmsTextField];
    
    UIButton *oldSmsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [oldSmsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [oldSmsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    oldSmsButton.frame = CGRectMake(viewWidth - 110, 260, 80, 30);
    oldSmsButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [oldSmsButton addTarget:self action:@selector(oldSmsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oldSmsButton];
    
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 330,viewWidth - 200, 50)];
    self.phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneTextField.placeholder = @"请输入新手机号";
    self.phoneTextField.textColor = [UIColor lightGrayColor];
    self.phoneTextField.font = [UIFont systemFontOfSize:16];
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    self.phoneTextField.delegate = self;
    [self.view addSubview:self.phoneTextField];
    
    self.smsTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 410,viewWidth - 140, 50)];
    self.smsTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.smsTextField.placeholder = @"请输入新手机号验证码";
    self.smsTextField.textColor = [UIColor lightGrayColor];
    self.smsTextField.font = [UIFont systemFontOfSize:16];
    self.smsTextField.returnKeyType = UIReturnKeyDone;
    self.smsTextField.delegate = self;
    [self.view addSubview:self.smsTextField];
    
    UIButton *smsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [smsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [smsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    smsButton.frame = CGRectMake(viewWidth - 110, 420, 80, 30);
    smsButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [smsButton addTarget:self action:@selector(smsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:smsButton];
    
  
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

- (void)smsButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] sendVerifyCodeByPhone:self.phoneTextField.text internationalCode:@"86" type:2 ssid:nil stid:nil success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"验证码发送成功" duration:3 position:CSToastPositionCenter];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}

- (void)oldSmsButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] sendVerifyCodeByPhone:self.oldPhoneTextField.text internationalCode:@"86" type:QuecVerifyCodeTypeLogout ssid:nil stid:nil success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"验证码发送成功" duration:3 position:CSToastPositionCenter];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}
- (void)sureButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] updatePhone:self.phoneTextField.text newInternationalCode:@"86" newPhoneCode:self.smsTextField.text oldPhone:self.oldPhoneTextField.text oldInternationalCode:@"86" oldPhoneCode:self.oldSmsTextField.text success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"手机号修改成功" duration:3 position:CSToastPositionCenter];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneTextField resignFirstResponder];
    [self.smsTextField resignFirstResponder];
    [self.oldPhoneTextField resignFirstResponder];
    [self.oldSmsTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
