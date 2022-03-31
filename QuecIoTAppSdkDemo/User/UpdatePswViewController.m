//
//  UpdatePswViewController.m
//  QuecUserKitExample
//
//  Created by quectel.steven on 2021/9/6.
//

#import "UpdatePswViewController.h"
#import <Toast/Toast.h>
#import <QuecUserKit/QuecUserKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface UpdatePswViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *firstTextField;
@property (nonatomic, strong) UITextField *secondTextField;
@end

@implementation UpdatePswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"修改密码";
    self.navigationController.navigationBar.hidden = NO;
    self.hidesBottomBarWhenPushed = YES;
    CGFloat viewWidth = self.view.frame.size.width;
    self.firstTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200,viewWidth - 60, 50)];
    self.firstTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.firstTextField.placeholder = @"请输入旧密码";
    self.firstTextField.textColor = [UIColor lightGrayColor];
    self.firstTextField.font = [UIFont systemFontOfSize:16];
    self.firstTextField.returnKeyType = UIReturnKeyDone;
    self.firstTextField.delegate = self;
    [self.view addSubview:self.firstTextField];
    
    self.secondTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 280,viewWidth - 60, 50)];
    self.secondTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.secondTextField.placeholder = @"请输入新密码";
    self.secondTextField.textColor = [UIColor lightGrayColor];
    self.secondTextField.font = [UIFont systemFontOfSize:16];
    self.secondTextField.returnKeyType = UIReturnKeyDone;
    self.secondTextField.delegate = self;
    [self.view addSubview:self.secondTextField];
    

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
    [[QuecUserService sharedInstance] updatePassword:self.secondTextField.text oldPassword:self.firstTextField.text success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"密码修改成功" duration:3 position:CSToastPositionCenter];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
