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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecBleManager sharedInstance] sendCommand:[QuecBleCommandModel getCommadnWithCommand:0x7010 payload:@[[QuecPayloadDataModel getPayloadWithId:1 dataType:QuecPlaloadDataTypeBinary value:[self.wifiNameTextField.text dataUsingEncoding:NSUTF8StringEncoding]],[QuecPayloadDataModel getPayloadWithId:2 dataType:QuecPlaloadDataTypeBinary value:[self.wifiPsdTextField.text dataUsingEncoding:NSUTF8StringEncoding]]] writeWithResponse:YES] completion:^(BOOL timeout, QuecBleReceiveModel *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!timeout) {
                self.pk = @"";
                self.dk = @"";
                self.authCode = @"";
                for (int i = 0; i < response.payload.count; i ++) {
                    QuecPayloadDataModel *payloadModel = response.payload[i];
                    if (payloadModel.Id == 7) {
                        self.pk = [[NSString alloc] initWithData:payloadModel.value encoding:NSUTF8StringEncoding];
                        NSLog(@"pk: %@",self.pk);
                    }
                    else if (payloadModel.Id == 8) {
                        self.dk = [[NSString alloc] initWithData:payloadModel.value encoding:NSUTF8StringEncoding];
                        NSLog(@"dk: %@",self.dk);
                    }
                    else if (payloadModel.Id == 9) {
                        self.authCode = [[NSString alloc] initWithData:payloadModel.value encoding:NSUTF8StringEncoding];
                        NSLog(@"authCode: %@",self.authCode);
                    }
                }
                QuecPayloadDataModel *model = response.payload.firstObject;
                if (![model.value boolValue]) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self.view makeToast:@"配网失败" duration:3 position:CSToastPositionCenter];
                }
                else {
                    
                    self.count = 1;
                    self.timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self  selector:@selector(bindDevice) userInfo:nil  repeats:YES];
                    [self.timer fire];
                    
                }
                return;
            }
        });
    }];
}

- (void)bindDevice{
    [[QuecDeviceService sharedInstance] bindDeviceByAuthCode:self.authCode productKey:self.pk deviceKey:self.dk deviceName:self.dk success:^{
            [self.timer invalidate];
            self.timer = nil;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"配网成功" duration:3 position:CSToastPositionCenter];
            [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];

        } failure:^(NSError *error) {
            
    }];
    
    if (_count >= 10) {
        [_timer invalidate];
        _timer = nil;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"配网失败" duration:3 position:CSToastPositionCenter];
        [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
    }
    _count++;
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

@end

