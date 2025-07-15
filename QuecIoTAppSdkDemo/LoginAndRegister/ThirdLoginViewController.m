//
//  QuecThirdLoginViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by quectel.steven on 2023/6/15.
//

#import "ThirdLoginViewController.h"
#import <Toast/Toast.h>
#import <QuecUserKit/QuecUserKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "HomeViewController.h"
#import "MyCenterViewController.h"
#import "AppDelegate.h"

@interface ThirdLoginViewController ()
@property (nonatomic, strong) UITextField *countryCodeField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *pswTextField;
@end

@implementation ThirdLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第三方登录";
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat viewWidth = self.view.frame.size.width;
    
    self.countryCodeField = [[UITextField alloc] initWithFrame:CGRectMake(30, 150,viewWidth - 60, 50)];
    self.countryCodeField.borderStyle = UITextBorderStyleRoundedRect;
    self.countryCodeField.placeholder = @"请输入国家码";
    self.countryCodeField.keyboardType = UIKeyboardTypeNumberPad;
    self.countryCodeField.textColor = [UIColor lightGrayColor];
    self.countryCodeField.font = [UIFont systemFontOfSize:16];
    self.countryCodeField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.countryCodeField];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 230,viewWidth - 60, 50)];
    self.phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneTextField.placeholder = @"请输入authCode";
    self.phoneTextField.textColor = [UIColor lightGrayColor];
    self.phoneTextField.font = [UIFont systemFontOfSize:16];
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.phoneTextField];
    
    
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
    
}

- (void)loginButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecUserService sharedInstance] loginByAuthCode:self.phoneTextField.text success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"登录成功" duration:3 position:CSToastPositionCenter];
        [[QuecIoTAppSDK sharedInstance] setCountryCode:self.countryCodeField.text.length ? self.countryCodeField.text : @"86"];
        [[NSUserDefaults standardUserDefaults] setObject:self.countryCodeField.text.length ? self.countryCodeField.text : @"86" forKey:@"QuecCountryCode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self loginSuccess];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
    }];
    
}


- (void)loginSuccess {
    [UIApplication sharedApplication].keyWindow.rootViewController = [AppDelegate getMainController];;
}


@end
