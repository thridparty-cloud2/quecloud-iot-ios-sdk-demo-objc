//
//  DeviceSelectViewController.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/11/1.
//

#import "DeviceSelectViewController.h"
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYModel/YYModel.h>
@interface DeviceSelectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DeviceSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加设备";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self getDeviceList];
}

- (void)getDeviceList {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    @weakify(self);
    [[QuecDeviceService sharedInstance] getDeviceListWithPageNumber:1 pageSize:100 success:^(NSArray<QuecDeviceModel *> *list, NSInteger total) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        weak_self.dataArray = list.copy;
        [weak_self.tableView reloadData];
        [self getGroupList];
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)getGroupList {
    for (int  i = 0; i < self.dataArray.count; i ++) {
        QuecDeviceModel *model = self.dataArray[i];
        [[QuecDeviceService sharedInstance] getDeviceGroupListWithDeviceKey:model.deviceKey productKey:model.productKey success:^(NSArray<QuecDeviceGroupInfoModel *> *list) {
                    
                } failure:^(NSError *error) {
                    
                }];
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
    QuecDeviceModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.deviceName;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = model.deviceStatus;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //添加
    UITableViewRowAction *unbindRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"加入分组" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self addDeviceToGroupWithRow:indexPath.row];
    }];
    unbindRowAction.backgroundColor = [UIColor orangeColor];
    return @[unbindRowAction];
}

- (void)addDeviceToGroupWithRow:(NSInteger)row {
    QuecDeviceModel *model = self.dataArray[row];
    [[QuecDeviceService sharedInstance] addDeviceToGroupWithDeviceGroupId:self.dataModel.dgid deviceList:@[@{@"dk":model.deviceKey, @"pk": model.productKey}] success:^(NSDictionary *data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"添加成功" duration:3 position:CSToastPositionCenter];
        [self getDeviceList];
        } failure:^(NSError *error) {
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
}



@end
