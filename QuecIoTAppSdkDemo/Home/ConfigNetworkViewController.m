//
//  ConfigNetworkViewController.m
//  QuecBleChannelKitExample
//
//  Created by quectel.steven on 2021/11/22.
//

#import "ConfigNetworkViewController.h"
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "WifiBleDeviceBindViewController.h"

@interface ConfigNetworkViewController ()<QuecBleManagerDelegate>

@property (nonatomic, strong) UITextField *wifiNameTextField;
@property (nonatomic, strong) UITextField *wifiPsdTextField;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) NSString *pk;
@property (nonatomic, copy) NSString *dk;
@property (nonatomic, copy) NSString *authCode;

@end

@implementation ConfigNetworkViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[QuecBleManager sharedInstance] addListener:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[QuecBleManager sharedInstance] disconnectPeripheral:self.currentConnectdevice];
    [[QuecBleManager sharedInstance] removeListener:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"网络配置";
    
    _wifiNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200, self.view.frame.size.width - 60, 50)];
    _wifiNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _wifiNameTextField.placeholder = @"请输入wifi名称";
    [self.view addSubview:_wifiNameTextField];
    
    _wifiPsdTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 280, self.view.frame.size.width - 60, 50)];
    _wifiPsdTextField.borderStyle = UITextBorderStyleRoundedRect;
    _wifiPsdTextField.placeholder = @"请输入wifi密码";
    [self.view addSubview:_wifiPsdTextField];
    
    UIButton *config = [UIButton buttonWithType:UIButtonTypeCustom];
    [config setTitle:@"配网" forState:UIControlStateNormal];
    [config setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    config.titleLabel.font = [UIFont systemFontOfSize:18];
    config.frame = CGRectMake(30, 360, self.view.frame.size.width - 60, 50);
    [config addTarget:self action:@selector(startConfig) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:config];
    
//    [[QuecConfigureNetworkManager sharedInstance] getConnectWifiName:^(NSString *wifiName) {
//        self.wifiNameTextField.text = wifiName;
//       }];
}

- (void)startConfig {
    if (!self.wifiNameTextField.text.length) {
        [self.view makeToast:@"请输入wifi名称" duration:3 position:CSToastPositionCenter];
        return;
    }
    if (!self.wifiPsdTextField.text.length) {
        [self.view makeToast:@"请输入wifi密码" duration:3 position:CSToastPositionCenter];
        return;
    }
    [self.wifiNameTextField resignFirstResponder];
    [self.wifiPsdTextField resignFirstResponder];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)bindDevice{

    
    
}


@end

