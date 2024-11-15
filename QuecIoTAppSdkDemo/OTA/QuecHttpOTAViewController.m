//
//  QuecHttpOTAViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/12.
//

#import "QuecHttpOTAViewController.h"
#import <QuecOTAUpgradeKit/QuecOTAUpgradeKit.h>
#import "QuecOTAPlanInfoModel.h"
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <QuecFoundationKit/QuecFoundationKit.h>
#import <QuecCommonUtil/QuecCommonUtil.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>
#import "QuecDeviceOTAStatusManager.h"
#import <QuecOTAUpgradeKit/QuecOTAPlanParamModel.h>

@interface QuecHttpOTAViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation QuecHttpOTAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.dataArray = [NSMutableArray array];
    
    [self loadData];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    @quec_weakify(self);
    [QuecDeviceOTAStatusManager.sharedInstance addHandlerOTAState:self listener:^{
        @quec_strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [QuecDeviceOTAStatusManager.sharedInstance removeHandlerOTAState:self];
    [QuecDeviceOTAStatusManager.sharedInstance cleanFailAndSuccessState];
}

- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    @quec_weakify(self);
    // 接口支持分页，业务层自行处理刷新和加载
    [QuecHttpOTAService.sharedInstance otaDeviceListWithFId:@"" page:1 pageSize:10 success:^(QuecOTADeviceListModel *listModel) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        @quec_strongify(self);
        if (listModel && listModel.list.count) {
            for (QuecOTADeviceModel *model in listModel.list) {
                QuecOTAPlanInfoModel *infoModel = [[QuecOTAPlanInfoModel alloc]init];
                infoModel.dk = model.deviceKey;
                infoModel.pk = model.productKey;
                infoModel.deviceName = model.deviceName;
                infoModel.des = model.desc;
                infoModel.productIcon = model.productIcon;
                infoModel.versionInfo = model.version;
                infoModel.otaStatus = (int)model.deviceStatus;
                infoModel.planId = [NSString stringWithFormat:@"%lld",model.planId];
                infoModel.userConfirmStatus = (int)model.userConfirmStatus;
                [self.dataArray addObject:infoModel];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    QuecOTAPlanInfoModel *model = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = model.deviceName;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    int otaState = [QuecDeviceOTAStatusManager.sharedInstance readDeviceStateWithProductKey:model.pk deviceKey:model.dk planId:model.planId];
    model.otaStatus = otaState;
    
    if (model.otaStatus == 0) {
        cell.detailTextLabel.text = @"待更新";
    }else if (model.otaStatus == 1){
        float upgradeProgress = [QuecDeviceOTAStatusManager.sharedInstance readDeviceUpdateProgressWithProductKey:model.pk deviceKey:model.dk];
        int progress = (int)(upgradeProgress * 100);
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
    int isUpgrade = [QuecDeviceOTAStatusManager.sharedInstance readDeviceStateWithProductKey:model.pk deviceKey:model.dk planId:model.planId];
    if ((isUpgrade == 0 || isUpgrade == 3) && model.pk.length > 0 && model.dk.length > 0) {//可升级
        QuecOTAPlanParamModel *paramModel = [[QuecOTAPlanParamModel alloc]init];
        paramModel.pk = model.pk;
        paramModel.dk = model.dk;
        paramModel.planId = [model.planId longLongValue];
        paramModel.operType = model.otaStatus == 3 ? 5 : 1;
        @quec_weakify(self);
        [QuecHttpOTAService.sharedInstance userBatchConfirmUpgradeWithList:@[paramModel] success:^(NSDictionary *data) {
            @quec_strongify(self);
            quec_async_on_main(^{
                [QuecDeviceOTAStatusManager.sharedInstance writeDeviceStateWithProductKey:model.pk deviceKey:model.dk planId:model.planId state:1 userConfirmStatus:0];
                [self.tableView reloadData];
            });
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}


@end
