//
//  AddViewController.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/10/27.
//

#import "AddViewController.h"
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface AddViewController ()
@property (nonatomic, strong) UITextField *pkTextField;
@property (nonatomic, strong) UITextField *snTextField;
@property (nonatomic, strong) UITextField *authCodeTextField;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *bindModeTextField;
@property (nonatomic, strong) UITextField *shareCodeTextField;
@property (nonatomic, strong) UITextField *dkTextField;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加设备";
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat viewWidth = self.view.frame.size.width;
    
    self.pkTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100,viewWidth - 60, 40)];
    self.pkTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.pkTextField.placeholder = @"请输入PK";
    self.pkTextField.textColor = [UIColor lightGrayColor];
    self.pkTextField.font = [UIFont systemFontOfSize:16];
    self.pkTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.pkTextField];
    
    self.snTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 160,viewWidth - 60, 40)];
    self.snTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.snTextField.placeholder = @"请输入SN(SN+PK可绑定设备)";
    self.snTextField.textColor = [UIColor lightGrayColor];
    self.snTextField.font = [UIFont systemFontOfSize:14];
    self.snTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.snTextField];
    
    self.dkTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 220,viewWidth - 60, 40)];
    self.dkTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.dkTextField.placeholder = @"请输入DK";
    self.dkTextField.textColor = [UIColor lightGrayColor];
    self.dkTextField.font = [UIFont systemFontOfSize:16];
    self.dkTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.dkTextField];
    
    self.authCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 280,viewWidth - 60, 40)];
    self.authCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.authCodeTextField.placeholder = @"请输入authCode(authCode+DK+PK可绑定设备)";
    self.authCodeTextField.textColor = [UIColor lightGrayColor];
    self.authCodeTextField.font = [UIFont systemFontOfSize:16];
    self.authCodeTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.authCodeTextField];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 340,viewWidth - 60, 40)];
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.placeholder = @"请输入名称";
    self.nameTextField.textColor = [UIColor lightGrayColor];
    self.nameTextField.font = [UIFont systemFontOfSize:16];
    self.nameTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.nameTextField];
    
    self.bindModeTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 400,viewWidth - 60, 40)];
    self.bindModeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.bindModeTextField.placeholder = @"请输入password(PSW+DK+PK+authCode可绑定设备)";
    self.bindModeTextField.textColor = [UIColor lightGrayColor];
    self.bindModeTextField.font = [UIFont systemFontOfSize:16];
    self.bindModeTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.bindModeTextField];
    
    self.shareCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 480,viewWidth - 60, 40)];
    self.shareCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.shareCodeTextField.placeholder = @"输入分享码可直接添加设备";
    self.shareCodeTextField.textColor = [UIColor lightGrayColor];
    self.shareCodeTextField.font = [UIFont systemFontOfSize:16];
    self.shareCodeTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.shareCodeTextField];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.layer.cornerRadius = 10.0;
    addButton.layer.borderColor = [UIColor grayColor].CGColor;
    addButton.layer.borderWidth = 0.5;
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(30, 540, viewWidth - 60, 44);
    [addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
}

- (void)addButtonClick {
    if (self.shareCodeTextField.text.length) {
        [[QuecDeviceService sharedInstance] acceptShareByShareUserWithShareCode:self.shareCodeTextField.text deviceName:@"Test Share Bind" success:^{
            [self.view makeToast:@"绑定成功" duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        return;
    };
    if (self.pkTextField.text.length == 0) {
        [self.view makeToast:@"请输入PK" duration:3 position:CSToastPositionCenter];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.authCodeTextField.text.length) {
        if (self.bindModeTextField.text.length) {
            [[QuecDeviceService sharedInstance] bindDeviceByAuthCode:self.authCodeTextField.text productKey:self.pkTextField.text deviceKey:self.dkTextField.text password:self.bindModeTextField.text deviceName:self.nameTextField.text success:^{
                [self.view makeToast:@"绑定成功" duration:3 position:CSToastPositionCenter];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            } failure:^(NSError *error) {
                [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
        }
        else {
            [[QuecDeviceService sharedInstance] bindDeviceByAuthCode:self.authCodeTextField.text productKey:self.pkTextField.text deviceKey:self.dkTextField.text deviceName:self.nameTextField.text success:^{
                [self.view makeToast:@"绑定成功" duration:3 position:CSToastPositionCenter];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            } failure:^(NSError *error) {
                [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
        }
        
    }
    else {
        [[QuecDeviceService sharedInstance] bindDeviceBySerialNumber:self.snTextField.text productKey:self.pkTextField.text deviceName:self.nameTextField.text success:^(NSString *productKey, NSString *deviceKey) {
                    [self.view makeToast:@"绑定成功" duration:3 position:CSToastPositionCenter];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                } failure:^(NSError *error) {
                    [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                }];
    }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.authCodeTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.pkTextField resignFirstResponder];
    [self.dkTextField resignFirstResponder];
    [self.snTextField resignFirstResponder];
    [self.bindModeTextField resignFirstResponder];
    [self.shareCodeTextField resignFirstResponder];
}

@end
