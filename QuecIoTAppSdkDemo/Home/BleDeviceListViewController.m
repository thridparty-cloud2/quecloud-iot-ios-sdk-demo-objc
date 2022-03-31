//
//  DeviceListViewController.m
//  QuecConfigureNetworkKitExample
//
//  Created by quectel.steven on 2021/11/24.
//

#import "BleDeviceListViewController.h"
#import <QuecBleChannelKit/QuecBleChannelKit.h>
#import "ConfigNetworkViewController.h"

@interface BleDeviceListViewController ()<UITableViewDelegate, UITableViewDataSource, QuecBleManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) QuecPeripheralModel *currentConnectDevice;

@end

@implementation BleDeviceListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[QuecBleManager sharedInstance] addListener:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[QuecBleManager sharedInstance] removeListener:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设备列表";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
    }
    QuecPeripheralModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = model.mac;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[QuecBleManager sharedInstance] connectPeripheral:self.dataArray[indexPath.row]];
    self.currentConnectDevice = self.dataArray[indexPath.row];
    [[QuecBleManager sharedInstance] stopScan];
}

#pragma mark - QuecBleManagerDelegate
- (void)centralDidUpdateState:(CBManagerState)state {
    if (state == CBManagerStatePoweredOn) {
        [self startScan];
    }
}

- (void)centralDidDiscoverPeripheral:(QuecPeripheralModel *)peripheral {
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL isExist = NO;
        for (int i = 0; i < self.dataArray.count; i ++) {
            QuecPeripheralModel *model = self.dataArray[i];
            if ([model.uuid isEqualToString:peripheral.uuid]) {
                isExist = YES;
            }
        }
        if (!isExist) {
            [self.dataArray addObject:peripheral];
            [self.tableView reloadData];
        }
    });
}

- (void)peripheralDidUpdateConnectState:(BOOL)connectState {
    NSLog(@"peripheralDidUpdateConnectState:%ld",connectState);
    if (connectState) {
        ConfigNetworkViewController *configVc = [[ConfigNetworkViewController alloc] init];
        configVc.currentConnectdevice = self.currentConnectDevice;
        [self.navigationController pushViewController:configVc animated:YES];
    }
}

- (void)didReceivePeripheralData:(QuecBleReceiveModel *)data {
    
}

@end
