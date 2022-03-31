//
//  DeviceDetailViewController.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/10/28.
//

#import "DeviceDetailViewController.h"
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYModel/YYModel.h>

@interface DeviceDetailViewController () {
    UITextView *_textView;
    UITextView *_shareTextView;
}

@end

@implementation DeviceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备详情";
    self.view.backgroundColor = [UIColor whiteColor];
    _textView = [[UITextView alloc] init];
    _textView.textColor = [UIColor lightGrayColor];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.frame = CGRectMake(20, 20, self.view.frame.size.width - 40, 400);
    [self.view addSubview:_textView];
    
    [self getData];
}

- (void)getData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.dataModel.deviceType == 1) {
        [[QuecDeviceService sharedInstance] getDeviceInfoByDeviceKey:self.dataModel.deviceKey productKey:self.dataModel.productKey success:^(QuecDeviceModel *deviceModel) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self->_textView.text = deviceModel.yy_modelToJSONString;
            } failure:^(NSError *error) {
                [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
    }
    else {
        [[QuecDeviceService sharedInstance] getDeviceInfoByShareCode:self.dataModel.shareCode ? (self.dataModel.shareCode) : (@"") success:^(QuecDeviceModel *deviceModel) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self->_textView.text = deviceModel.yy_modelToJSONString;
            } failure:^(NSError *error) {
                [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
    }
   
   
}



@end
