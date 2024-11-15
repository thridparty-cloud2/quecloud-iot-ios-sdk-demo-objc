//
//  HomeViewController.m
//  QuecUserKitExample
//
//  Created by quectel.steven on 2021/9/4.
//

#import "HomeViewController.h"
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "DeviceControlViewController.h"
#import "ShareInfoViewController.h"
#import "BleDeviceListViewController.h"
#import "QuecOTAViewController.h"
#import "QuecDeviceOTAStatusManager.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, QuecDeviceDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *deviceDatas;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *otaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [otaButton setTitle:@"OTA" forState:UIControlStateNormal];
    otaButton.frame = CGRectMake(0, 0, 50, 50);
    [otaButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    otaButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [otaButton addTarget:self action:@selector(otaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:otaButton];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0, 0, 50, 50);
    [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    _deviceDatas = @{}.mutableCopy;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)otaButtonClick {
    QuecOTAViewController *vc = [[QuecOTAViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addButtonClick {
    [self showActionSheet];
}

// WIFI设备绑定
- (void)jumpToAuthCodeDKPK{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"WIFI设备绑定" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *authCode = alertVc.textFields[0].text;
        NSString *dk = alertVc.textFields[1].text;
        NSString *pk = alertVc.textFields[2].text;
        NSString *name = alertVc.textFields[3].text;
        if (authCode.length == 0) {
            [self.view makeToast:@"请输入authCode" duration:1.0f position:CSToastPositionCenter];
            [self presentViewController:alertVc animated:true completion:nil];
            return;
        }
        if (dk.length == 0) {
            [self.view makeToast:@"请输入dk" duration:1.0f position:CSToastPositionCenter];
            [self presentViewController:alertVc animated:true completion:nil];
            return;
        }
        if (pk.length == 0) {
            [self.view makeToast:@"请输入pk" duration:1.0f position:CSToastPositionCenter];
            [self presentViewController:alertVc animated:true completion:nil];
            return;
        }
        [self requestBindDeviceByAuthCode:authCode pk:pk dk:dk name:name];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入authCode";
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入dk";
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入pk";
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入设备名称, 可以不输入";
    }];
    [alertVc addAction:sureAction];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:true completion:nil];
}
// 分享设备绑定
- (void)jumpToShare_code{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"分享设备绑定" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *share_code = alertVc.textFields[0].text;
        if (share_code.length == 0) {
            [self.view makeToast:@"请输入share_code" duration:1.0f position:CSToastPositionCenter];
            [self presentViewController:alertVc animated:true completion:nil];
            return;
        }
        [self requestBindDeviceByShare_code:share_code];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入share_code";
    }];
    [alertVc addAction:sureAction];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:true completion:nil];
}
// SN设备绑定
- (void)jumpToSNAndPK{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"SN设备绑定" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *sn = alertVc.textFields[0].text;
        NSString *pk = alertVc.textFields[1].text;
        NSString *name = alertVc.textFields[2].text;
        if (sn.length == 0) {
            [self.view makeToast:@"请输入sn" duration:1.0f position:CSToastPositionCenter];
            [self presentViewController:alertVc animated:true completion:nil];
            return;
        }
        if (pk.length == 0) {
            [self.view makeToast:@"请输入pk" duration:1.0f position:CSToastPositionCenter];
            [self presentViewController:alertVc animated:true completion:nil];
            return;
        }
        [self requestBindDeviceBySn:sn pk:pk name:name];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入sn";
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入pk";
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入设备名称, 可以不输入";
    }];
    [alertVc addAction:sureAction];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:true completion:nil];
}

// WIFI/蓝牙设备
- (void)jumpToAddBle {
    BleDeviceListViewController *addVc = [[BleDeviceListViewController alloc] init];
    addVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVc animated:YES];
}

- (void)showActionSheet {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请选择设备类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    QuecWeakSelf(self);
    
    UIAlertAction *authCodeDKPKAction = [UIAlertAction actionWithTitle:@"WIFI设备绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        QuecStrongSelf(self);
        [self jumpToAuthCodeDKPK];
    }];
    [alertVc addAction:authCodeDKPKAction];
    
    UIAlertAction *share_codeAction = [UIAlertAction actionWithTitle:@"分享设备绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        QuecStrongSelf(self);
        [self jumpToShare_code];
    }];
    [alertVc addAction:share_codeAction];
    
    UIAlertAction *jumpSNAndPKAction = [UIAlertAction actionWithTitle:@"SN设备绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        QuecStrongSelf(self);
        [self jumpToSNAndPK];
    }];
    [alertVc addAction:jumpSNAndPKAction];
    
    UIAlertAction *bleAction = [UIAlertAction actionWithTitle:@"WIFI/蓝牙设备" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        QuecStrongSelf(self);
        [self jumpToAddBle];
    }];
    [alertVc addAction:bleAction];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:true completion:nil];
}

- (void)getData {
    QuecWeakSelf(self);
    [[QuecDeviceService sharedInstance] getDeviceListWithPageNumber:1 pageSize:100 success:^(NSArray<QuecDeviceModel *> *list, NSInteger total) {
        QuecStrongSelf(self);
        self.dataArray = list.copy;
        [self addDevicesToDeviceKit];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"getDeviceList error:%@", error.localizedDescription);
    }];
}

- (void)addDevicesToDeviceKit{
    if (self.dataArray.count <= 0) {
        return;
    }
    [QuecIotCacheService.sharedInstance addDeviceModelList:self.dataArray];
    for (QuecDeviceModel *deviceModel in self.dataArray) {
        QuecDevice *device = [QuecDevice deviceWithId:deviceModel.deviceId];
        device.delegate = self;
        [device connect];
        [_deviceDatas quec_safeSetObject:device forKey:deviceModel.deviceId];
        NSLog(@"getDeviceList-deviceModel:%@", deviceModel);
        if (deviceModel.upgradeStatus == 1 || (deviceModel.upgradeStatus == 0 && deviceModel.userConfirmStatus == 1)) {
            [QuecDeviceOTAStatusManager.sharedInstance writeDeviceStateWithProductKey:deviceModel.productKey deviceKey:deviceModel.deviceKey planId:[NSString stringWithFormat:@"%ld",deviceModel.planId] state:1 userConfirmStatus:0];
        }
    }
}

#pragma mark - QuecDeviceDelegate
- (void)device:(QuecDevice *)device onlineUpdate:(NSUInteger)onlineState {
    [self.dataArray enumerateObjectsUsingBlock:^(QuecDeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.deviceId isEqualToString:device.model.deviceId]) {
            obj.onlineChannelState = onlineState;
            quec_async_on_main(^{
                [self.tableView reloadData];
            });
            *stop = true;
        }
    }];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
    }
    QuecDeviceModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.deviceName;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = model.onlineChannelState ?  @"在线" : @"离线";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self jumpTpDetainWithRow:indexPath.row];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //重命名
    QuecWeakSelf(self)
    UITableViewRowAction *renameRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"重命名" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        QuecStrongSelf(self)
        [self updateDeviceNameWithRow:indexPath.row];
    }];
    renameRowAction.backgroundColor = [UIColor lightGrayColor];
    //解绑
    UITableViewRowAction *unbindRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"解绑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        QuecStrongSelf(self)
        [self unbindDeviceWithRow:indexPath.row];
    }];
    unbindRowAction.backgroundColor = [UIColor blueColor];
    //分享
    UITableViewRowAction *shareRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"分享" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        QuecStrongSelf(self)
        ShareInfoViewController *shareInfoVc = [[ShareInfoViewController alloc] init];
        shareInfoVc.hidesBottomBarWhenPushed = YES;
        shareInfoVc.dataModel = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:shareInfoVc animated:YES];
    }];
    shareRowAction.backgroundColor = [UIColor orangeColor];
    return @[unbindRowAction, shareRowAction, renameRowAction];
}

- (void)updateDeviceNameWithRow:(NSInteger)row {
    QuecDeviceModel *model = self.dataArray[row];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"修改名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateDeviceNameWithName:alertVc.textFields.firstObject.text row:row];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入名称";
        textField.text = model.deviceName;
      
    }];
    [alertVc addAction:sureAction];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:true completion:nil];
}

- (void)updateDeviceNameWithName:(NSString *)deviceName row:(NSInteger)row {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    QuecDeviceModel *model = self.dataArray[row];
    QuecWeakSelf(self)
    if (model.deviceType == 1) {
        [[QuecDeviceService sharedInstance] updateDeviceName:deviceName productKey:model.productKey deviceKey:model.deviceKey success:^{
            QuecStrongSelf(self)
            [self.view makeToast:@"修改成功" duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self getData];
        } failure:^(NSError *error) {
            QuecStrongSelf(self)
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    else {
        [[QuecDeviceService sharedInstance] updateDeviceNameByShareUserWithDeviceName:deviceName shareCode:model.shareCode success:^{
            QuecStrongSelf(self)
            [self.view makeToast:@"修改成功" duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self getData];
        } failure:^(NSError *error) {
            QuecStrongSelf(self)
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
  
}

- (void)unbindDeviceWithRow:(NSInteger)row {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    QuecDeviceModel *model = [self.dataArray quec_safeObjectAtIndex:row];
    @quec_weakify(self);
    [QuecDevice batchRemoveWithFid:@"" isInit:NO deviceList:@[model] success:^{
        @quec_strongify(self);
        [self.view makeToast:@"解绑成功" duration:3 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self getData];
    } failure:^(NSError * _Nonnull error) {
        @quec_strongify(self);
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)jumpTpDetainWithRow:(NSInteger)row {
    DeviceControlViewController *deviceControlVc = [[DeviceControlViewController alloc] init];
    deviceControlVc.dataModel = self.dataArray[row];
    deviceControlVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:deviceControlVc animated:YES];
}

// 发起蓝牙设备绑定
- (void)requestBindDeviceByAuthCode:(NSString *)authCode pk:(NSString *)pk dk:(NSString *)dk passwod:(NSString *)password name:(NSString *)name{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    QuecWeakSelf(self)
//    [[QuecDeviceService sharedInstance] bindDeviceByAuthCode:authCode productKey:pk deviceKey:dk password:password deviceName:name success:^{
//        QuecStrongSelf(self)
//        [self.view makeToast:@"绑定成功" duration:3 position:CSToastPositionCenter];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [self getData];
//    } failure:^(NSError *error) {
//        QuecStrongSelf(self)
//        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
}
// 发起WIFI设备绑定
- (void)requestBindDeviceByAuthCode:(NSString *)authCode pk:(NSString *)pk dk:(NSString *)dk name:(NSString *)name{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    QuecWeakSelf(self)
    [[QuecDeviceService sharedInstance] bindDeviceByAuthCode:authCode productKey:pk deviceKey:dk deviceName:name success:^{
        QuecStrongSelf(self)
        [self.view makeToast:@"绑定成功" duration:3 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self getData];
    } failure:^(NSError *error) {
        QuecStrongSelf(self)
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
// 发起分享设备绑定
- (void)requestBindDeviceByShare_code:(NSString *)share_code{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    QuecWeakSelf(self)
    [[QuecDeviceService sharedInstance] acceptShareByShareUserWithShareCode:share_code deviceName:@"Test Share Bind" success:^{
        QuecStrongSelf(self)
        [self.view makeToast:@"绑定成功" duration:3 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self getData];
    } failure:^(NSError *error) {
        QuecStrongSelf(self)
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
// 发起SN设备绑定
- (void)requestBindDeviceBySn:(NSString *)sn pk:(NSString *)pk name:(NSString *)name{
    QuecWeakSelf(self)
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecDeviceService sharedInstance] bindDeviceBySerialNumber:sn productKey:pk deviceName:name success:^(NSString *productKey, NSString *deviceKey){
        QuecStrongSelf(self)
        [self.view makeToast:@"绑定成功" duration:3 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self getData];
    } failure:^(NSError *error) {
        QuecStrongSelf(self)
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

@end
