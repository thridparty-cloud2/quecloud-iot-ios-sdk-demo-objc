//
//  QuecBleOTAViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/12.
//

#import "QuecBleOTAViewController.h"
#import <QuecOTAUpgradeKit/QuecOTAUpgradeKit.h>
#import "QuecOTAPlanInfoModel.h"
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <QuecFoundationKit/QuecFoundationKit.h>
#import <QuecCommonUtil/QuecCommonUtil.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>

@interface QuecBleOTAViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation QuecBleOTAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 50, 50);
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    @quec_weakify(self);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadPureBLEDeviceData:^(NSArray * _Nullable array) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        @quec_strongify(self);
        if (array) {
            self.dataArray = [NSArray arrayWithArray:array];
        }
        [self.tableView reloadData];
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self addListener];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self removeListener];
}

- (void)backButtonClick {
    if ([QuecBleOTAManager.sharedInstance checkForUpgradableDevices]) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"确认退出" message:@"退出当前页面，蓝牙设备的升级会中断，确认退出吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVc addAction:sureAction];
        [alertVc addAction:cancleAction];
        [self presentViewController:alertVc animated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    QuecOTAPlanInfoModel *model = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = model.deviceName;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    QuecBleStateModel *bleStateModel = [QuecBleOTAManager.sharedInstance getDeviceProgressAndState:quec_deviceId(model.pk, model.dk)];
    model.upgradeProgress = bleStateModel.progress;
    model.otaStatus = bleStateModel.otaState;
    
    if (model.otaStatus == 0) {
        cell.detailTextLabel.text = @"待更新";
    }else if (model.otaStatus == 1){
        int progress = (int)(model.upgradeProgress * 100);
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d%s",progress, "%"];
    }else if (model.otaStatus == 2){
        cell.detailTextLabel.text = @"更新成功";
    }else if (model.otaStatus == 3){
        cell.detailTextLabel.text = @"重试";
    }else if (model.otaStatus == 4){
        cell.detailTextLabel.text = @"更新失败";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuecOTAPlanInfoModel *model = self.dataArray[indexPath.row];
    if (model.otaStatus == 2 || model.otaStatus == 4 || model.otaStatus == 1) {
        return;
    }
    
    if (model == nil) {
        return;
    }
    
    NSMutableArray *planList = [NSMutableArray array];
    QuecBleOTAInfoModel *infoModel = [QuecBleOTAManager.sharedInstance getBleOTAInfoModel:quec_deviceId(model.pk, model.dk)];
    if (infoModel != nil) {
        [planList addObject:infoModel];
    }
    
    if (planList.count) {
        [QuecBleOTAManager.sharedInstance startOTAWithInfoList:planList.copy];
    }
    
}

#pragma mark - private method
- (void)loadPureBLEDeviceData:(void (^)(NSArray<QuecOTAPlanInfoModel *> * _Nullable array))success {
    // 获取连接的蓝牙设备列表
    NSArray<NSDictionary<NSString *, NSString *> *> *bleList = [QuecDevice getConnectedBleList];
    if (!bleList || bleList.count == 0) {
        // 如果没有连接的设备，直接返回空数组
        NSLog(@"loadPureBLEDeviceData--bleList is null");
        success(nil);
        return;
    }
    
    // 创建存储 OTA 计划数据的数组
    NSMutableArray<QuecOTAPlanInfoModel *> *dataArray = [NSMutableArray array];
    dispatch_group_t dispatchGroup = dispatch_group_create();

    for (NSDictionary<NSString *, NSString *> *dict in bleList) {
        // 从字典中提取 pk 和 dk 的值
        NSString *pk = dict[@"pk"];
        NSString *dk = dict[@"dk"];
        if (!pk || !dk) {
            // 跳过当前循环
            continue;
        }
        
        // Enter the group before starting the async task
        dispatch_group_enter(dispatchGroup);
        
        [QuecBleOTAManager.sharedInstance checkVersionWithProductKey:pk deviceKey:dk infoBlock:^(QuecBleOTAInfoModel * _Nullable infoModel) {
            if (infoModel) {
                QuecOTAPlanInfoModel *otaModel = [[QuecOTAPlanInfoModel alloc] init];
                otaModel.dk = infoModel.dk;
                otaModel.pk = infoModel.pk;
                otaModel.des = infoModel.info;
                otaModel.versionInfo = infoModel.targetVersion;
                otaModel.otaStatus = 0;
                otaModel.planId = [NSString stringWithFormat:@"%ld", (long)infoModel.planId];
                otaModel.userConfirmStatus = 0;
                otaModel.isPureBLEDevice = YES;

                QuecDevice *device = [[QuecDevice alloc] initWithId:quec_deviceId(infoModel.pk, infoModel.dk)];
                if (device) {
                    otaModel.deviceName = device.model.deviceName;
                    otaModel.productIcon = device.model.logoImage != nil ? device.model.logoImage : (device.model.productIcon != nil ? device.model.productIcon : @"");
                }
                [dataArray addObject:otaModel];
            } else {
                NSLog(@"No info model received.");
            }
            
            dispatch_group_leave(dispatchGroup);
        }];
    }
    
    // When all tasks have completed, the group will be notified and the success closure will be called
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
        if (dataArray.count > 0) { // 确保有数据
            success(dataArray.copy);
        } else {
            success(nil);
        }
    });
}

- (void)addListener {
    @quec_weakify(self);
    
    // 添加进度监听器
    [QuecBleOTAManager.sharedInstance addProgressListener:self progressListener:^(NSString * _Nonnull pk, NSString * _Nonnull dk, CGFloat progress) {
        // 处理进度更新
        NSLog(@"Progress - PK: %@, DK: %@, Progress: %f", pk, dk, progress);
        @quec_strongify(self);
        [self.tableView reloadData];
    }];
    
    // 添加状态监听器
    [QuecBleOTAManager.sharedInstance addStateListener:self onSuccess:^(NSString * _Nonnull pk, NSString * _Nonnull dk, long waitTime) {
        // 处理成功状态更新
        NSLog(@"Success - PK: %@, DK: %@", pk, dk);
        @quec_strongify(self);
        [self.tableView reloadData];
        
    } onFail:^(NSString * _Nonnull pk, NSString * _Nonnull dk, int code) {
        @quec_strongify(self);
        NSLog(@"Fail - PK: %@, DK: %@", pk, dk);
        [self.tableView reloadData];
    }];
    
}

- (void)removeListener {
    [QuecBleOTAManager.sharedInstance removeProgressListener:self];
    [QuecBleOTAManager.sharedInstance removeStateListener:self];
    //注意：当退出纯蓝牙OTA升级页面时调用releaseAll--清空缓存数据；如果是从ota列表页跳转到某个设备的OTA升级详情页面，不可调用releaseAll，需要根据实际业务自行处理
    [QuecBleOTAManager.sharedInstance releaseAll];
}


@end
