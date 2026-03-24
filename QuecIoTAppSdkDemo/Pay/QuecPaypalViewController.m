//
//  QuecPaypalViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by quectel.tank on 3/12/26.
//

#import "QuecPaypalViewController.h"
#import <QuecPaymentSdk/QuecPaymentSdk.h>
#import <QuecPayKit/QuecPayKit.h>

@interface QuecPaypalViewController ()

@property (nonatomic, strong) UITextField *merchantNoField;
@property (nonatomic, strong) UITextField *bssAppIdField;
@property (nonatomic, strong) UITextField *orderIdField;
@property (nonatomic, strong) UIButton *payButton;

@end

@implementation QuecPaypalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"PayPal支付";
    
    CGFloat width = self.view.bounds.size.width - 40;
    CGFloat textHeight = 40;
    CGFloat startY = 100;
    CGFloat spacing = 20;
    
    // 商户 Code
    self.merchantNoField = [[UITextField alloc] initWithFrame:CGRectMake(20, startY, width, textHeight)];
    self.merchantNoField.borderStyle = UITextBorderStyleRoundedRect;
    self.merchantNoField.placeholder = @"商户号";
    [self.view addSubview:self.merchantNoField];
    
    // BSS App Id
    self.bssAppIdField = [[UITextField alloc] initWithFrame:CGRectMake(20, startY + (textHeight + spacing), width, textHeight)];
    self.bssAppIdField.borderStyle = UITextBorderStyleRoundedRect;
    self.bssAppIdField.placeholder = @"BSS Id";
    [self.view addSubview:self.bssAppIdField];
    
    // 订单号
    self.orderIdField = [[UITextField alloc] initWithFrame:CGRectMake(20, startY + 2*(textHeight + spacing), width, textHeight)];
    self.orderIdField.borderStyle = UITextBorderStyleRoundedRect;
    self.orderIdField.placeholder = @"订单号";
    [self.view addSubview:self.orderIdField];
    
    // 去支付按钮
    self.payButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.payButton.frame = CGRectMake(20, startY + 3*(textHeight + spacing) + 10, width, textHeight);
    [self.payButton setTitle:@"去支付" forState:UIControlStateNormal];
    self.payButton.backgroundColor = UIColor.systemBlueColor;
    [self.payButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.payButton.layer.cornerRadius = 6;
    [self.payButton addTarget:self action:@selector(payButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payButton];
}

- (void)payButtonTapped {
    NSLog(@"商户 Code: %@", self.merchantNoField.text);
    NSLog(@"BSS App Id: %@", self.bssAppIdField.text);
    NSLog(@"订单号: %@", self.orderIdField.text);
    /// 环境类型根据当前登录环境选择 ==> pro, fat, dev, pro-eu, pro-us
    [QuecUnifiedPayManager.sharedManager setEnvType:@"pro"];
    [QuecUnifiedPayManager.sharedManager setBssClientAppId:self.bssAppIdField.text ?: @""];
    [QuecUnifiedPayManager.sharedManager payWithPaypal:self.orderIdField.text success:^(BOOL result) {
        NSLog(@"result ==> %@", result ? @"Yes" : @"No");
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error ==> %@", error);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
