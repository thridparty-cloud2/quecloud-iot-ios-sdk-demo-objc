//
//  QuecOTAViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/11.
//

#import "QuecOTAViewController.h"
#import <QuecOTAUpgradeKit/QuecOTAUpgradeKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>
#import "QuecOTAPlanInfoModel.h"
#import "QuecBleOTAViewController.h"
#import "QuecHttpOTAViewController.h"

@interface QuecOTAViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation QuecOTAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.dataArray = @[@"查询HTTP-OTA是否有待升级设备", @"查询BLE-OTA是否有待升级设备"];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
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
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self loadHttpOTAData];
    }else {
        [self loadBleOTAData];
    }
}

- (void)loadHttpOTAData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    @quec_weakify(self);
    [QuecHttpOTAService.sharedInstance getUserlsHaveDeviceUpgrade:@"" success:^(NSInteger number) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        @quec_strongify(self);
        if (number > 0) {
            QuecHttpOTAViewController *vc = [[QuecHttpOTAViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            [self.view makeToast:@"没有待升级的HTTP-OTA设备" duration:3 position:CSToastPositionCenter];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        NSLog(@"QuecOTAViewController--loadHttpOTAData--error: %@",error);
    }];
}

- (void)loadBleOTAData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    @quec_weakify(self);
    [self loadPureBLEDeviceData:^(NSInteger number) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        @quec_strongify(self);
        if (number > 0) {
            QuecBleOTAViewController *vc = [[QuecBleOTAViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            [self.view makeToast:@"没有待升级的BLE-OTA设备" duration:3 position:CSToastPositionCenter];
        }
    }];
}

- (void)loadPureBLEDeviceData:(void (^)(NSInteger))success {
    // 获取连接的蓝牙设备列表
    NSArray *bleList = [QuecDevice getConnectedBleList];
    if (!bleList || bleList.count == 0) {
        // 如果没有连接的设备，直接返回空数组
        NSLog(@"loadPureBLEDeviceData--bleList is null");
        success(0);
        return;
    }

    // 创建存储 OTA 计划数据的数组
    NSMutableArray *dataArray = [NSMutableArray array];
    dispatch_group_t dispatchGroup = dispatch_group_create();

    for (NSDictionary *dict in bleList) {
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
            if (infoModel != nil) {
                [dataArray addObject:infoModel];
            } else {
                NSLog(@"No info model received.");
            }
            
            dispatch_group_leave(dispatchGroup);
        }];

    }
    
    // When all tasks have completed, the group will be notified and the success closure will be called
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
        success([dataArray count]);
    });
}


@end
