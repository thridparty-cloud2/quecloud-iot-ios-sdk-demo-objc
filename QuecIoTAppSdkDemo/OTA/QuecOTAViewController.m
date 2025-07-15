#import "QuecOTAViewController.h"
#import <QuecOTAUpgradeKit/QuecOTAUpgradeKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>
#import "QuecOtaPlanModel.h"

@interface QuecOTAViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray<QuecOtaPlanModel *> *otaPlansList;

@end

@implementation QuecOTAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"OTA列表";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self loadOTAPlanData];
    @quec_weakify(self);
    [QuecOTAManager.sharedInstance addStateListener:self state:^(QuecOTAStateModel * _Nonnull stateModel) {
        @quec_strongify(self);
        NSString *deviceId = [NSString stringWithFormat:@"%@@%@", stateModel.pk, stateModel.dk];
        for (QuecOtaPlanModel *planModel in self.otaPlansList) {
            NSString *lastDeviceId = [NSString stringWithFormat:@"%@@%@", planModel.pk, planModel.dk];
            if ([deviceId isEqualToString:lastDeviceId]) {
                planModel.progress = stateModel.progress;
                planModel.state = stateModel.state;
                break;
            }
        }
        [self.tableView reloadData];
    }];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [QuecOTAManager.sharedInstance removeStateListener:self];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.otaPlansList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
    }
    QuecOtaPlanModel *planInfo = [self.otaPlansList quec_safeObjectAtIndex:indexPath.row];
    if ([planInfo isKindOfClass:QuecOtaPlanModel.class]) {
        cell.textLabel.text = planInfo.planInfoModel.deviceName;
        NSString *desc = @"";
        NSLog(@"==============>state: %d   progress: %.2f", planInfo.state, planInfo.progress);
        switch (planInfo.state) {
            case QuecOTAUpgrading:
                desc = [NSString stringWithFormat:@"升级中: %.0f%@", planInfo.progress *100., @"%"];
                break;
            case QuecOTAUpgradeSuccess:
                desc = @"升级成功";
                break;
            case QuecOTAUpgradeFailure:
            case QuecOTAUpgradeExpired:
                desc = @"升级失败";
                break;
            default:
                desc = @"待升级";
                break;
        }
        cell.detailTextLabel.text = desc;
    }
    
    cell.textLabel.textColor = UIColor.blackColor;
    cell.detailTextLabel.textColor = UIColor.lightGrayColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /// Simulate the OTA upgrade
    QuecOtaPlanModel *planInfo = [self.otaPlansList quec_safeObjectAtIndex:indexPath.row];
    if ([planInfo isKindOfClass:QuecOtaPlanModel.class] && planInfo.state == QuecOTAUpgradeEmpty) {
        [QuecOTAManager.sharedInstance startOtaWithPlanInfoModel:planInfo.planInfoModel];
    }
}

- (void)loadOTAPlanData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    @quec_weakify(self);
    [QuecOTAManager.sharedInstance checkAllVersionWithPage:1 pageSize:10 planListBlock:^(NSArray<QuecOtaPlanInfoModel *> * _Nonnull planInfos) {
        @quec_strongify(self);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (planInfos.count) {
            self.otaPlansList = [planInfos quec_map:^id _Nonnull(QuecOtaPlanInfoModel * _Nonnull obj) {
                QuecOtaPlanModel *planModel = QuecOtaPlanModel.new;
                planModel.planId = obj.planId;
                planModel.pk = obj.productKey;
                planModel.dk = obj.deviceKey;
                planModel.planInfoModel = obj;
                
                NSInteger deviceStatus = obj.deviceStatus;
                QuecOTAStateModel *statusModel = [QuecOTAManager.sharedInstance getOtaStateWithProductKey:obj.productKey deviceKey:obj.deviceKey];
                if (statusModel.state == QuecOTAUpgrading) {
                    planModel.state = QuecOTAUpgrading;
                    planModel.progress = statusModel.progress;
                }else {
                    planModel.state = deviceStatus == QuecOTAUpgradeFailure ? QuecOTAUpgradeEmpty : (QuecOTAState)deviceStatus;
                    planModel.progress = obj.upgradeProgress;
                }
                return planModel;
            }];
            [self.tableView reloadData];
        }else{
            [self.view makeToast:@"empty ota plans" duration:3 position:CSToastPositionCenter];
        }
    }];
}

@end
