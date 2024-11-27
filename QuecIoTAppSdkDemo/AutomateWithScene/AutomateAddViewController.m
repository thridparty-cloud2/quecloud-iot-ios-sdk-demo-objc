//
//  AutomateAddViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/26.
//

#import "AutomateAddViewController.h"
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <QuecAutomateKit/QuecAutomateKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>
#import <QuecSmartHomeKit/QuecSmartHomeKit.h>
#import "SceneSelectedViewController.h"
#import <QuecCommonUtil/QuecCommonUtil.h>
#import "AutomateAbilityPublishedVC.h"

@interface AutomateAddViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataOneArray;
@property (nonatomic, strong) NSArray *dataOneDeviceArray;
@property (nonatomic, strong) NSArray *dataTwoArray;
@property (nonatomic, strong) NSArray *dataTwoDeviceArray;

@property (nonatomic, strong) QuecAutomationConditionModel *timeConditionModel;
@property (nonatomic, strong) QuecAutomationActionModel *timeActionModel;

@end

@implementation AutomateAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"添加自动化";
    self.dataOneDeviceArray = @[].copy;
    self.dataTwoDeviceArray = @[].copy;
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"保存" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0, 0, 60, 50);
    [addButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];

}

- (void)addButtonClick {
    
    if (self.timeConditionModel == nil || self.dataOneArray.count == 0) {
        [self.view makeToast:@"请至少点击选择一个触发事件" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    if (self.dataTwoArray.count == 0) {
        [self.view makeToast:@"请至少选择一个执行设备" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    BOOL doCondition = YES;
    for (QuecAutomationConditionModel *conditionModel in self.dataOneArray) {
        if (conditionModel.property == nil) {
            doCondition = NO;
            break;;
        }
    }
    
    if (!doCondition) {
        [self.view makeToast:@"触发事件中的设备请设置执行动作" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    BOOL doAction= YES;
    for (QuecAutomationActionModel *actionModel in self.dataTwoArray) {
        if (actionModel.property == nil) {
            doAction = NO;
            break;
        }
    }
    
    if (!doAction) {
        [self.view makeToast:@"执行任务中的设备请设置执行动作" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    NSString *fid = @"";
    if (QuecSmartHomeService.sharedInstance.enable) {
        fid = [QuecSmartHomeService sharedInstance].currentFamily.fid;
    }
    
    QuecAutomationPreconditionModel *preconditionModel = [[QuecAutomationPreconditionModel alloc]init];
    preconditionModel.timeZone = quec_TimeDifferenceWithGMT(quec_LocalTimeZoneName());
    preconditionModel.effectDateType = QuecAutomateEffectDateTypeEveryday;
    preconditionModel.effectTimeType = QuecAutomateEffectTimeTypeWholeDay;
    preconditionModel.location = @"";
    
    QuecAutomateModel *model = [[QuecAutomateModel alloc]init];
    model.fid = fid;
    model.conditionType = QuecAutomateConditionRuleAny;
    model.nameType = 2;
    model.precondition = preconditionModel;
    if (self.dataOneArray.count) {
        model.conditions = [NSArray arrayWithArray:self.dataOneArray];
    }
    model.actions = [NSArray arrayWithArray:self.dataTwoArray];
    
    long long timestamp = (long long)quec_TimestampMSEC();//获取毫秒级时间戳
    model.name = [NSString stringWithFormat:@"%@%lld",@"随意命名_",timestamp];
    
    [QuecAutomateService addAutomationWithModel:model success:^{
        [self.view makeToast:@"创建成功" duration:3 position:CSToastPositionCenter];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataOneArray.count;
    }
    return self.dataTwoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 20)];
        label.font = [UIFont boldSystemFontOfSize:12.0];
        label.textColor = UIColor.blackColor;
        label.text = @"触发事件";
        [view addSubview:label];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(20, 50, 80, 30);
        btn1.backgroundColor = UIColor.systemBlueColor;
        [btn1 setTitle:@"定时" forState:UIControlStateNormal];
        [btn1 setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btn1Action:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [view addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(120, 50, 80, 30);
        btn2.backgroundColor = UIColor.systemBlueColor;
        [btn2 setTitle:@"设备" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(btn2Action:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [view addSubview:btn2];
        
        return view;
    }else {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 20)];
        label.font = [UIFont boldSystemFontOfSize:12.0];
        label.textColor = UIColor.blackColor;
        label.text = @"执行任务";
        [view addSubview:label];
        
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(20, 50, 80, 30);
        btn3.backgroundColor = UIColor.systemBlueColor;
        [btn3 setTitle:@"执行设备" forState:UIControlStateNormal];
        [btn3 setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        [btn3 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(btn3Action:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn3];
        
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn4.frame = CGRectMake(120, 50, 80, 30);
        btn4.backgroundColor = UIColor.systemBlueColor;
        [btn4 setTitle:@"开启场景" forState:UIControlStateNormal];
        [btn4 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn4 addTarget:self action:@selector(btn4Action:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn4];
        
        UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn5.frame = CGRectMake(220, 50, 80, 30);
        btn5.backgroundColor = UIColor.systemBlueColor;
        [btn5 setTitle:@"添加延时" forState:UIControlStateNormal];
        [btn5 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn5 addTarget:self action:@selector(btn5Action:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn5];
        
        return view;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        QuecAutomationConditionModel *conditionModel = self.dataOneArray[indexPath.row];
        cell.textLabel.text = conditionModel.name;
        cell.detailTextLabel.textColor = UIColor.orangeColor;
        if (conditionModel.property) {
            cell.detailTextLabel.text = @"";
        }else {
            cell.detailTextLabel.text = @"未设置";
        }
    }else {
        QuecAutomationActionModel *actionModel = self.dataTwoArray[indexPath.row];
        cell.textLabel.text = actionModel.name;
        cell.detailTextLabel.textColor = UIColor.orangeColor;
        if (actionModel.property) {
            cell.detailTextLabel.text = @"";
        }else {
            cell.detailTextLabel.text = @"未设置";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    @quec_weakify(self);
    if (indexPath.section == 0) {
        QuecDeviceModel *deviceModel = self.dataOneDeviceArray[indexPath.row];
        [self getAutomationTSL:deviceModel withType:1 success:^(BOOL isSuccess) {
            @quec_strongify(self);
            [self pushAutomateAbility:indexPath];
        }];
    }else {
        QuecDeviceModel *deviceModel = self.dataTwoDeviceArray[indexPath.row];
        [self getAutomationTSL:deviceModel withType:2 success:^(BOOL isSuccess) {
            @quec_strongify(self);
            [self pushAutomateAbility:indexPath];
        }];
    }
}

- (void)getAutomationTSL:(QuecDeviceModel *)deviceModel withType:(NSInteger)type success:(void (^)(BOOL isSuccess))success {
    [QuecAutomateService getAutomationTSLWithProductKey:deviceModel.productKey type:type success:^(NSArray<QuecProductTSLPropertyModel *> * _Nonnull conditions, NSArray<QuecProductTSLPropertyModel *> * _Nonnull actions) {
        
        if ((type == 1 && conditions.count !=0) || (type == 2 && conditions.count !=0)) {
            if (success) {
                success(YES);
            }
        }else {
            [self.view makeToast:@"该设备暂不支持联动配置" duration:1 position:CSToastPositionCenter];
            if (success) {
                success(NO);
            }
        }
        
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:1 position:CSToastPositionCenter];
        if (success) {
            success(NO);
        }
    }];
}

- (void)pushAutomateAbility:(NSIndexPath *)indexPath {
    QuecDeviceModel *deviceModel;
    NSInteger type = 1;
    if (indexPath.section == 0) {
        deviceModel = self.dataOneDeviceArray[indexPath.row];
        type = 1;
    }else {
        deviceModel = self.dataTwoDeviceArray[indexPath.row];
        type = 2;
    }
    
    @quec_weakify(self);
    
    AutomateAbilityPublishedVC *vc = [[AutomateAbilityPublishedVC alloc]init];
    vc.deviceModel = deviceModel;
    vc.type = type;
    vc.block = ^(QuecProductTSLPropertyModel * _Nonnull propertyModel) {
        @quec_strongify(self);
        QuecAutomationPropertyModel *model = [[QuecAutomationPropertyModel alloc]init];
        model.dataType = propertyModel.dataType;
        model.identifier = propertyModel.itemId;
        model.code = propertyModel.code;
        model.name = propertyModel.name;
        if ([propertyModel.dataType isEqualToString:@"BOOL"]) {
            NSArray *array = (NSArray *)propertyModel.specs;
            NSDictionary *dict = array[0];
            model.subName = [dict quec_safeObjectForKey:@"name"];
            model.value = [dict quec_safeObjectForKey:@"value"];
            model.compare = @"==";
        }
        
        if (indexPath.section == 0) {
            QuecAutomationConditionModel *conditionModel = self.dataOneArray[indexPath.row];
            conditionModel.property = model;
        }else {
            QuecAutomationActionModel *actionModel = self.dataTwoArray[indexPath.row];
            actionModel.property = model;
        }
        [self.tableView reloadData];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)btn1Action:(UIButton *)sender {
    //示例中固定写死，具体UI交互及数据获取结合自身业务
    if (self.timeConditionModel == nil) {
        QuecAutomationTimeModel *timeModel = [[QuecAutomationTimeModel alloc]init];
        timeModel.type = 0;
        timeModel.timeZone = quec_TimeDifferenceWithGMT(quec_LocalTimeZoneName());
        timeModel.time = @"09:30";
        
        NSInteger sort = self.dataOneArray.count == 0 ? 1 : self.dataOneArray.count + 1;
        QuecAutomationConditionModel *timeConditionModel = [[QuecAutomationConditionModel alloc]initWithType:1 icon:nil name:nil timer:timeModel productKey:nil deviceKey:nil property:nil sort:sort];
        self.timeConditionModel = timeConditionModel;
        [self.view makeToast:@"定时触发事件添加成功" duration:1 position:CSToastPositionCenter];
    }
}

- (void)btn2Action:(UIButton *)sender {
    
    SceneSelectedViewController *vc = [[SceneSelectedViewController alloc]init];
    vc.isScene = YES;
    if (self.dataOneArray.count) {
        vc.upSelectedArr = self.dataOneArray.copy;
    }
    @quec_weakify(self);
    vc.listBlock = ^(NSArray<QuecDeviceModel *> * _Nonnull list) {
        @quec_strongify(self);
        NSMutableArray *arr = @[].mutableCopy;
        NSInteger sort = self.timeConditionModel == nil ? 1 : 2;
        for (QuecDeviceModel *model in list) {
            // 使用 indexOfObject: 方法查找对象的索引
            NSUInteger index = [self.dataOneDeviceArray indexOfObject:model];
            if (index != NSNotFound) {
                QuecAutomationConditionModel *deviceConditionModel = self.dataOneArray[index];
                deviceConditionModel.sort = sort;
                [arr addObject:deviceConditionModel];
            } else {
                QuecAutomationConditionModel *deviceConditionModel = [[QuecAutomationConditionModel alloc]initWithType:0 icon:nil name:model.deviceName timer:nil productKey:model.productKey deviceKey:model.deviceKey property:nil sort:sort];
                [arr addObject:deviceConditionModel];
            }

            sort++;
        }
        
        self.dataOneDeviceArray = [NSArray arrayWithArray:list];
        self.dataOneArray = [NSArray arrayWithArray:arr];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)btn3Action:(UIButton *)sender {
    SceneSelectedViewController *vc = [[SceneSelectedViewController alloc]init];
    vc.isScene = YES;
    if (self.dataTwoArray.count) {
        vc.upSelectedArr = self.dataTwoArray.copy;
    }
    @quec_weakify(self);
    vc.listBlock = ^(NSArray<QuecDeviceModel *> * _Nonnull list) {
        @quec_strongify(self);
        NSMutableArray *arr = @[].mutableCopy;
        NSInteger sort = self.timeActionModel == nil ? 1 : 2;
        for (QuecDeviceModel *model in list) {
            // 使用 indexOfObject: 方法查找对象的索引
            NSUInteger index = [self.dataTwoDeviceArray indexOfObject:model];
            if (index != NSNotFound) {
                QuecAutomationActionModel *deviceActionModel = self.dataTwoArray[index];
                deviceActionModel.sort = sort;
                [arr addObject:deviceActionModel];
            } else {
                QuecAutomationActionModel *deviceActionModel = [[QuecAutomationActionModel alloc]initWithType:2 icon:nil name:model.deviceName productKey:model.productKey deviceKey:model.deviceKey sceneId:nil delayTime:nil property:nil sort:sort];
                [arr addObject:deviceActionModel];
            }
            
            sort++;
        }
        self.dataTwoDeviceArray = [NSArray arrayWithArray:list];
        self.dataTwoArray = [NSArray arrayWithArray:arr];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)btn4Action:(UIButton *)sender {
    
}

- (void)btn5Action:(UIButton *)sender {
    
    if (self.timeActionModel == nil) {
        NSInteger sort = self.dataTwoArray.count == 0 ? 1 : self.dataTwoArray.count + 1;
        QuecAutomationActionModel *model = [[QuecAutomationActionModel alloc]initWithType:1 icon:nil name:nil productKey:nil deviceKey:nil sceneId:nil delayTime:@(120) property:nil sort:sort];
        self.timeActionModel = model;
        [self.view makeToast:@"添加延时执行任务成功" duration:1 position:CSToastPositionCenter];
    }
    
}

@end
