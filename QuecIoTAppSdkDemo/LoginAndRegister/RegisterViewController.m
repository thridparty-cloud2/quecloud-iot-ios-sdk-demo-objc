//
//  RegisterViewController.m
//  QuecUserKitExample
//
//  Created by quectel.steven on 2021/9/3.
//

#import "RegisterViewController.h"
#import <Toast/Toast.h>
#import <QuecUserKit/QuecUserKit.h>
#import "QueryDataViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface RegisterViewController () <QueryDataViewControllerDelegate>
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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"手机号注册";
    self.nationId = 0;
    self.languageId = 0;
    self.timeZoneId = 0;
    CGFloat viewWidth = self.view.frame.size.width;
    
    CGFloat buttonWidth = (viewWidth - 80) / 3.0;
    self.nationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nationButton setTitle:@"国家" forState:UIControlStateNormal];
    self.nationButton.frame = CGRectMake(30, 150,buttonWidth, 30);
    [self.nationButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.nationButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.nationButton addTarget:self action:@selector(nationButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nationButton];

    self.languageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.languageButton setTitle:@"语言" forState:UIControlStateNormal];
    self.languageButton.frame = CGRectMake((viewWidth - buttonWidth) / 2.0, 150,buttonWidth, 30);
    [self.languageButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.languageButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.languageButton addTarget:self action:@selector(languageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.languageButton];

    self.timeZoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.timeZoneButton setTitle:@"时区" forState:UIControlStateNormal];
    self.timeZoneButton.frame = CGRectMake(viewWidth - buttonWidth - 30 , 150,buttonWidth, 30);
    [self.timeZoneButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.timeZoneButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.timeZoneButton addTarget:self action:@selector(timeZoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timeZoneButton];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200,viewWidth - 200, 50)];
    self.phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneTextField.placeholder = @"请输入手机号";
    self.phoneTextField.textColor = [UIColor lightGrayColor];
    self.phoneTextField.font = [UIFont systemFontOfSize:16];
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.phoneTextField];
    
    UIButton *checkPhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkPhoneButton setTitle:@"检验手机号+国家码" forState:UIControlStateNormal];
    checkPhoneButton.frame = CGRectMake(viewWidth - 150, 210, 120, 30);
    [checkPhoneButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    checkPhoneButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [checkPhoneButton addTarget:self action:@selector(checkPhoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkPhoneButton];
    
    self.smsTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 280,viewWidth - 210, 50)];
    self.smsTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.smsTextField.placeholder = @"请输入验证码";
    self.smsTextField.textColor = [UIColor lightGrayColor];
    self.smsTextField.font = [UIFont systemFontOfSize:16];
    self.smsTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.smsTextField];
    
    UIButton *smsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [smsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    smsButton.frame = CGRectMake(viewWidth - 110, 290, 80, 30);
    [smsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    smsButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [smsButton addTarget:self action:@selector(smsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:smsButton];
    
    UIButton *checksmsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checksmsButton setTitle:@"校验验证码" forState:UIControlStateNormal];
    checksmsButton.frame = CGRectMake(viewWidth - 180, 290, 70, 30);
    [checksmsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    checksmsButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [checksmsButton addTarget:self action:@selector(checksmsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checksmsButton];
    
    
    self.pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 360,viewWidth - 30, 50)];
    self.pswTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.pswTextField.placeholder = @"请输入密码";
    self.pswTextField.textColor = [UIColor lightGrayColor];
    self.pswTextField.font = [UIFont systemFontOfSize:16];
    self.pswTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.pswTextField];
    
  
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.layer.cornerRadius = 10.0;
    registerButton.layer.borderColor = [UIColor grayColor].CGColor;
    registerButton.layer.borderWidth = 0.5;
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.frame = CGRectMake(30, 510, viewWidth - 60, 44);
    [registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
}

- (void)nationButtonClick {
    QueryDataViewController *dataVc = [[QueryDataViewController alloc] init];
    dataVc.type = 1;
    dataVc.delegate = self;
    [self.navigationController pushViewController:dataVc animated:YES];
}

- (void)languageButtonClick {
    QueryDataViewController *dataVc = [[QueryDataViewController alloc] init];
    dataVc.type = 2;
    dataVc.delegate = self;
    [self.navigationController pushViewController:dataVc animated:YES];
}

- (void)timeZoneButtonClick {
    QueryDataViewController *dataVc = [[QueryDataViewController alloc] init];
    dataVc.type = 3;
    dataVc.delegate = self;
    [self.navigationController pushViewController:dataVc animated:YES];
}
- (void)checkPhoneButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] validateInternationalPhone:self.phoneTextField.text internationalCode:@"86" success:^(NSDictionary *data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"手机号验证成功" duration:3 position:CSToastPositionCenter];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}
- (void)checksmsButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] validateSmsCode:self.phoneTextField.text smsCode:self.smsTextField.text internationalCode:@"86" type:1 success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"短信验证码有效" duration:3 position:CSToastPositionCenter];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}

- (void)registerButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] registerByPhone:self.phoneTextField.text code:self.smsTextField.text password:self.pswTextField.text internationalCode:@"86" nationality:0 lang:0 timezone:0 success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"注册成功" duration:3 position:CSToastPositionCenter];
        [self.navigationController popoverPresentationController];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}

- (void)smsButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] sendVerifyCodeByPhone:self.phoneTextField.text internationalCode:@"86" type:3 ssid:nil stid:nil success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"验证码发送成功" duration:3 position:CSToastPositionCenter];
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
