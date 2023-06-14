//
//  DeviceListViewController.m
//  QuecConfigureNetworkKitExample
//
//  Created by quectel.steven on 2021/11/24.
//

#import "BleDeviceListViewController.h"
#import <QuecBleChannelKit/QuecBleChannelKit.h>
#import "ConfigNetworkViewController.h"
#import "BleDeviceListTableViewCell.h"
#import <QuecSmartConfigKit/QuecSmartConfigKit.h>

@interface BleDeviceListViewController ()<UITableViewDelegate, UITableViewDataSource, QuecBleManagerDelegate, QuecSmartConfigDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BleDeviceListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[QuecBleManager sharedInstance] addListener:self];
    [[QuecSmartConfigService sharedInstance] addSmartConfigDelegate:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[QuecBleManager sharedInstance] removeListener:self];
    [[QuecSmartConfigService sharedInstance] cancelConfigDevices];
    [[QuecSmartConfigService sharedInstance] removeSmartConfigDelegate:self];
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
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"扫描" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0, 0, 50, 50);
    [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [addButton addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
}

- (void)startScan {
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    [[QuecBleManager sharedInstance] startScanWithFilier:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        [[QuecBleManager sharedInstance] stopScan];
    });
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
        [self startBinding:indexPath];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)startBinding:(NSIndexPath *)indexPath{
    BleDeviceBindModel *model = [self.dataArray quec_safeObjectAtIndex:indexPath.row];
    [[QuecSmartConfigService sharedInstance] startConfigDevices:@[model.peripheralModel] ssid:@"QUEC_WIFI_TEST" password:@"12332112"];
    model.bindState = QuecBinding;
    [self.tableView reloadData];
}

#pragma mark - QuecSmartConfigDelegate
- (void)didUpdateConfigResult:(QuecPeripheralModel *)device result:(BOOL)result error:(NSError *)error{
    NSLog(@"deviceName:%@--------result:%d-----error: %@", device.name, result, error);
    NSInteger row = 99999;
    for (int i = 0; i < self.dataArray.count; i++) {
        BleDeviceBindModel *model = [self.dataArray quec_safeObjectAtIndex:i];
        if ([device.uuid isEqualToString:model.peripheralModel.uuid]){
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

#pragma mark - QuecBleManagerDelegate
- (void)centralDidUpdateState:(CBManagerState)state {
    if (state == CBManagerStatePoweredOn) {
        [self startScan];
    }
}

- (void)centralDidDiscoverPeripheral:(QuecPeripheralModel *)peripheral {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![peripheral.name hasPrefix:@"QUEC"]) {
            return;
        }
        BOOL isExist = NO;
        for (int i = 0; i < self.dataArray.count; i ++) {
            BleDeviceBindModel *model = [self.dataArray quec_safeObjectAtIndex:i];
            if ([model.peripheralModel.uuid isEqualToString:peripheral.uuid]) {
                isExist = YES;
            }
        }
        if (!isExist) {
            BleDeviceBindModel *model = BleDeviceBindModel.new;
            model.peripheralModel = peripheral;
            model.bindState = QuecWaitingBind;
            [self.dataArray quec_safeAddObject:model];
            [self.tableView reloadData];
        }
    });
}


@end
