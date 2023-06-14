//
//  LoginViewController.m
//  QuecUserKitExample
//
//  Created by quectel.steven on 2021/9/3.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "MyCenterViewController.h"
#import "SmsLogingViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "DeviceGroupViewController.h"
#import "EmailLoginViewController.h"
#import <QuecUserKit/QuecUserKit.h>
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface LoginViewController ()

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *pswTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"密码登录";
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200,viewWidth - 110, 50)];
    self.phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneTextField.placeholder = @"请输入手机号";
    self.phoneTextField.textColor = [UIColor lightGrayColor];
    self.phoneTextField.font = [UIFont systemFontOfSize:16];
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.phoneTextField];
    
    UIButton *phoneCheckButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneCheckButton setTitle:@"校验" forState:UIControlStateNormal];
    phoneCheckButton.frame = CGRectMake(viewWidth - 80, 200, 50, 50);
    [phoneCheckButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    phoneCheckButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [phoneCheckButton addTarget:self action:@selector(phoneCheckButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneCheckButton];
    
    
    self.pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 280,viewWidth - 60, 50)];
    self.pswTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.pswTextField.placeholder = @"请输入密码";
    self.pswTextField.textColor = [UIColor lightGrayColor];
    self.pswTextField.font = [UIFont systemFontOfSize:16];
    self.pswTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.pswTextField];
    
    UIButton *smsLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [smsLoginButton setTitle:@"验证码登录" forState:UIControlStateNormal];
    smsLoginButton.frame = CGRectMake(30, 350, 100, 30);
    [smsLoginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    smsLoginButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [smsLoginButton addTarget:self action:@selector(smsLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:smsLoginButton];
    
    UIButton *emailLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [emailLoginButton setTitle:@"邮箱登录" forState:UIControlStateNormal];
    emailLoginButton.frame = CGRectMake((viewWidth - 100) / 2.0, 350, 100, 30);
    [emailLoginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    emailLoginButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [emailLoginButton addTarget:self action:@selector(emailLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emailLoginButton];
    
    UIButton *forgetPswButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPswButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPswButton.frame = CGRectMake(viewWidth - 130, 350, 100, 30);
    [forgetPswButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    forgetPswButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetPswButton addTarget:self action:@selector(forgetPswButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPswButton];
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.layer.cornerRadius = 10.0;
    loginButton.layer.borderColor = [UIColor grayColor].CGColor;
    loginButton.layer.borderWidth = 0.5;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(30, 430, viewWidth - 60, 44);
    [loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
    registerButton.frame = CGRectMake(30, viewHeight - 74 , viewWidth - 60, 30);
    [registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
}

- (void)phoneCheckButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] queryPhoneIsRegister:self.phoneTextField.text internationalCode:@"86" success:^(BOOL isRegister) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isRegister) {
            [self.view makeToast:@"手机号已注册" duration:3 position:CSToastPositionCenter];
        }
        else {
            [self.view makeToast:@"手机号未注册" duration:3 position:CSToastPositionCenter];
        }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}

- (void)smsLoginButtonClick {
    [self.navigationController pushViewController:[[SmsLogingViewController alloc] init] animated:YES];
}
- (void)forgetPswButtonClick {
    ForgetPasswordViewController *forgetVc = [[ForgetPasswordViewController alloc] init];
    forgetVc.type = 1;
    [self.navigationController pushViewController:forgetVc animated:YES];
}

- (void)emailLoginButtonClick {
    [self.navigationController pushViewController:[[EmailLoginViewController alloc] init] animated:YES];
}

- (void)loginButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] loginByPhone:self.phoneTextField.text password:self.pswTextField.text internationalCode:@"86" success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"登录成功" duration:3 position:CSToastPositionCenter];
        [[QuecIoTAppSDK sharedInstance] setCountryCode:@"86"];
        [self loginSuccess];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}

- (void)registerButtonClick {
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneTextField resignFirstResponder];
    [self.pswTextField resignFirstResponder];
}

- (void)loginSuccess {
    UITabBarController *tabbarVc = [[UITabBarController alloc] init];
    HomeViewController *homeVc=[[HomeViewController alloc]init];
    homeVc.tabBarItem.title=@"首页";
    homeVc.view.backgroundColor = [UIColor whiteColor];
    
    DeviceGroupViewController *groupVc=[[DeviceGroupViewController alloc]init];
    groupVc.tabBarItem.title=@"分组";
    groupVc.view.backgroundColor = [UIColor whiteColor];
    
    MyCenterViewController *myVc=[[MyCenterViewController alloc]init];
    myVc.tabBarItem.title=@"我的";
    myVc.view.backgroundColor = [UIColor whiteColor];

    tabbarVc.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:homeVc],[[UINavigationController alloc] initWithRootViewController:groupVc],[[UINavigationController alloc] initWithRootViewController:myVc]];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarVc;
}


@end
