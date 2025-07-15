//
//  DeviceListViewController.m
//  QuecConfigureNetworkKitExample
//
//  Created by quectel.steven on 2021/11/24.
//

#import "BleDeviceListViewController.h"
#import "ConfigNetworkViewController.h"
#import "BleDeviceListTableViewCell.h"
#import <QuecSmartConfigKit/QuecSmartConfigKit.h>
#import <Toast/Toast.h>
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <QuecSmartHomeKit/QuecSmartHomeKit.h>

@interface BleDeviceListViewController ()<UITableViewDelegate, UITableViewDataSource, QuecBleManagerDelegate, QuecPairingDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<BleDeviceBindModel *> *dataArray;
@property (nonatomic, copy) NSString *ssid;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *fid; // 当前家庭id

@end

@implementation BleDeviceListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[QuecDevicePairingService sharedInstance] addPairingListener:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[QuecDevicePairingService sharedInstance] removePairingListener:self];
    [[QuecDevicePairingService sharedInstance] cancelAllDevicePairing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设备列表";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:BleDeviceListTableViewCell.class forCellReuseIdentifier:NSStringFromClass(BleDeviceListTableViewCell.class)];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.dataArray = @[].mutableCopy;
    self.fid = [QuecSmartHomeService sharedInstance].currentFamily.fid;
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"扫描" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0, 0, 50, 50);
    [addButton setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [addButton addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
//    self.ssid = @"no_connect";
//    self.pwd = @"123456123";
}

- (void)startScan {
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    /// 需要打开系统及App蓝牙权限
    [QuecDevicePairingService.sharedInstance scanWithFilier:nil];
}

- (void)stopScan {
    [[QuecDevicePairingService sharedInstance] stopScan];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BleDeviceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BleDeviceListTableViewCell.class) forIndexPath:indexPath];
    BleDeviceBindModel *model = [self.dataArray quec_safeObjectAtIndex:indexPath.row];
    [cell configureModel:model indexPath:indexPath];
    @quec_weakify(self);
    cell.bindAction = ^(NSIndexPath * _Nonnull indexPath) {
        @quec_strongify(self);
        if ([self isSupportBtBind:model.peripheral]){
            [self startBinding:indexPath];
            return;
        }
        [self configWifiWithIndex:indexPath];
    };
    return cell;
}

- (BOOL)isSupportBtBind:(QuecPairingPeripheral *)pairingPeripheral{
    BOOL pureBt = pairingPeripheral.peripheralModel.capabilitiesBitmask == 4;
    BOOL capabilitEnable = ((pairingPeripheral.peripheralModel.capabilitiesBitmask & 4) == 4) && pairingPeripheral.activeBluetooth;
    return pureBt || capabilitEnable;
}

- (void)startBinding:(NSIndexPath *)indexPath{
    BleDeviceBindModel *model = [self.dataArray quec_safeObjectAtIndex:indexPath.row];
    [self stopScan];
    [QuecDevicePairingService.sharedInstance startPairingWithDevices:@[model.peripheral] ssid:self.ssid pwd:self.pwd];
    model.bindState = QuecBinding;
    [self.tableView reloadData];
    
}

#pragma mark - QuecPairingDelegate

- (void)didUpdatePairingStatus:(QuecPairingPeripheral *)pairingPeripheral progress:(CGFloat)progress{
    NSLog(@"deviceName:%@--------progress:%.2f", pairingPeripheral.deviceName, progress);
}

- (void)didUpdatePairingResult:(QuecPairingPeripheral *)pairingPeripheral result:(BOOL)result error:(NSError *)error{
    NSLog(@"deviceName:%@--------result:%d-----error: %@", pairingPeripheral.deviceName, result, error);
    NSInteger row = 99999;
    for (int i = 0; i < self.dataArray.count; i++) {
        BleDeviceBindModel *model = [self.dataArray quec_safeObjectAtIndex:i];
        if ([pairingPeripheral.peripheralModel.uuid isEqualToString:model.peripheral.peripheralModel.uuid]){
            row = i;
            break;
        }
    }
    if (row != 99999){
        BleDeviceBindModel *model = [self.dataArray quec_safeObjectAtIndex:row];
        if (result){
            model.bindState = QuecBindingSucc;
        }else{
            model.bindState = QuecBindingFail;
            model.errorMsg = error.localizedDescription;
        }
        [self.tableView reloadData];
    }
}

- (void)centralDidDiscoverPairingPeripheral:(QuecPairingPeripheral *)pairingPeripheral{
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL isExist = NO;
        for (int i = 0; i < self.dataArray.count; i ++) {
            BleDeviceBindModel *model = [self.dataArray quec_safeObjectAtIndex:i];
            if ([model.peripheral.peripheralModel.uuid isEqualToString:pairingPeripheral.peripheralModel.uuid]) {
                isExist = YES;
            }
        }
        if (!isExist) {
            BleDeviceBindModel *model = BleDeviceBindModel.new;
            model.peripheral = pairingPeripheral;
            model.bindState = QuecWaitingBind;
            [self.dataArray quec_safeAddObject:model];
            [self.tableView reloadData];
        }
    });
}

- (void)configWifiWithIndex:(NSIndexPath *)index{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请输入wifi信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.ssid = alertVc.textFields[0].text;
        self.pwd = alertVc.textFields[1].text;
        if (self.ssid.length == 0) {
            [self.view makeToast:@"请输入wifi名称" duration:1.0f position:CSToastPositionCenter];
            [self presentViewController:alertVc animated:true completion:nil];
            return;
        }
        [self startBinding:index];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入wifi名称";
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入wifi密码";
    }];
    [alertVc addAction:sureAction];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:true completion:nil];
}


@end
