//
//  RegisterViewController.m
//  QuecUserKitExample
//
//  Created by quectel.steven on 2021/9/3.
//

#import "RegisterViewController.h"
#import <Toast/Toast.h>
#import <QuecUserKit/QuecUserKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface RegisterViewController ()
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *smsTextField;
@property (nonatomic, strong) UITextField *pswTextField;
@property (nonatomic, strong) UIButton *nationButton;
@property (nonatomic, strong) UIButton *languageButton;
@property (nonatomic, strong) UIButton *timeZoneButton;
@property (nonatomic, assign) NSInteger nationId;
@property (nonatomic, assign) NSInteger languageId;
@property (nonatomic, assign) NSInteger timeZoneId;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = QLS(@"title_phone_register");
    self.nationId = 0;
    self.languageId = 0;
    self.timeZoneId = 0;
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat buttonWidth = (viewWidth - 80) / 3.0;
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200,viewWidth - 200, 50)];
    self.phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneTextField.placeholder = QLS(@"placeholder_phone");
    self.phoneTextField.textColor = [UIColor lightGrayColor];
    self.phoneTextField.font = [UIFont systemFontOfSize:16];
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.phoneTextField];
    
    UIButton *checkPhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkPhoneButton setTitle:QLS(@"btn_check_phone_country") forState:UIControlStateNormal];
    checkPhoneButton.frame = CGRectMake(viewWidth - 150, 210, 120, 30);
    [checkPhoneButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    checkPhoneButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [checkPhoneButton addTarget:self action:@selector(checkPhoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkPhoneButton];
    
    self.smsTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 280,viewWidth - 210, 50)];
    self.smsTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.smsTextField.placeholder = QLS(@"placeholder_sms_code");
    self.smsTextField.textColor = [UIColor lightGrayColor];
    self.smsTextField.font = [UIFont systemFontOfSize:16];
    self.smsTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.smsTextField];
    
    UIButton *smsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [smsButton setTitle:QLS(@"btn_get_sms_code") forState:UIControlStateNormal];
    smsButton.frame = CGRectMake(viewWidth - 110, 290, 80, 30);
    [smsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    smsButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [smsButton addTarget:self action:@selector(smsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:smsButton];
    
    UIButton *checksmsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checksmsButton setTitle:QLS(@"btn_verify_sms") forState:UIControlStateNormal];
    checksmsButton.frame = CGRectMake(viewWidth - 180, 290, 70, 30);
    [checksmsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    checksmsButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [checksmsButton addTarget:self action:@selector(checksmsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checksmsButton];
    
    
    self.pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 360,viewWidth - 30, 50)];
    self.pswTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.pswTextField.placeholder = QLS(@"placeholder_password");
    self.pswTextField.textColor = [UIColor lightGrayColor];
    self.pswTextField.font = [UIFont systemFontOfSize:16];
    self.pswTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.pswTextField];
    
  
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.layer.cornerRadius = 10.0;
    registerButton.layer.borderColor = [UIColor grayColor].CGColor;
    registerButton.layer.borderWidth = 0.5;
    [registerButton setTitle:QLS(@"btn_register") forState:UIControlStateNormal];
    registerButton.frame = CGRectMake(30, 510, viewWidth - 60, 44);
    [registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
}

- (void)checkPhoneButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [QuecUserService.sharedInstance validateInternationalPhone:self.phoneTextField.text ? : @""
                                             internationalCode:@"86"
                                                       success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:QLS(@"msg_phone_valid") duration:3 position:CSToastPositionCenter];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
    }];
}
- (void)checksmsButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] validateSmsCode:self.phoneTextField.text ? : @"" smsCode:self.smsTextField.text ? : @"" internationalCode:@"86" type:1 success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:QLS(@"msg_sms_valid") duration:3 position:CSToastPositionCenter];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}

- (void)registerButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [QuecUserService.sharedInstance registerByPhone:self.phoneTextField.text ? : @""
                                               code:self.smsTextField.text ? : @""
                                           password:self.pswTextField.text ? : @""
                                  internationalCode:@"86"
                                            success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:QLS(@"msg_register_success") duration:3 position:CSToastPositionCenter];
        [self.navigationController popoverPresentationController];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
    }];
}

- (void)smsButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [QuecUserService.sharedInstance sendVerifyCodeByPhone:self.phoneTextField.text ? : @""
                                        internationalCode:@"86"
                                                     type:QuecVerifyCodeTypeRegister
                                                  success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:QLS(@"msg_sms_sent") duration:3 position:CSToastPositionCenter];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneTextField resignFirstResponder];
    [self.smsTextField resignFirstResponder];
    [self.pswTextField resignFirstResponder];
}

#pragma mark - QueryDataViewControllerDelegate
- (void)selectId:(NSInteger)itemId value:(NSString *)value type:(NSInteger)type {
    switch (type) {
        case 1: {
            self.nationId = itemId;
            [self.nationButton setTitle:[NSString stringWithFormat:@"国家: %@",value] forState:UIControlStateNormal];
        }
            break;
        case 2: {
            self.languageId = itemId;
            [self.languageButton setTitle:[NSString stringWithFormat:@"语言: %@",value] forState:UIControlStateNormal];
        }
            break;
        case 3: {
            self.timeZoneId = itemId;
            [self.timeZoneButton setTitle:[NSString stringWithFormat:@"时区: %@",value] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}
@end
