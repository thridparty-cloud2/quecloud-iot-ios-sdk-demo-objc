//
//  DeviceControlViewController.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/10/28.
//

#import "DeviceControlViewController.h"
#import "DeviceDetailViewController.h"
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "TslNumberUTableViewCell.h"
#import "TslBoolTableViewCell.h"
#import "TslEnumAndDateTableViewCell.h"
#import "TlsTextTableViewCell.h"
#import <YYModel/YYModel.h>
#import "BRPickerView.h"


@interface DeviceControlViewController ()<UITableViewDelegate, UITableViewDataSource, TslNumberUTableViewCellDelegate, TslBoolTableViewCellDelegate, QuecDeviceDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) BRDatePickerView *datePickerView;
@property (nonatomic, assign) NSInteger dateIndex;
@property (nonatomic, assign) NSInteger enumIndex;
@property (nonatomic, strong) QuecDevice *currentDevice;

@end

@implementation DeviceControlViewController

- (void)dealloc
{
    NSLog(@"DeviceControlViewController dealloc");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备控制";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailButton setTitle:@"设置" forState:UIControlStateNormal];
    detailButton.frame = CGRectMake(0, 0, 50, 50);
    [detailButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    detailButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [detailButton addTarget:self action:@selector(detailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
    
    
    //初始化日期选择器
    _datePickerView = [[BRDatePickerView alloc]init];
    // 2.设置属性
    _datePickerView.pickerMode = BRDatePickerModeYMDHMS;
    _datePickerView.title = @"选择时间";
    _datePickerView.selectDate = [NSDate date];
    _datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
    _datePickerView.isAutoSelect = YES;
    @quec_weakify(self);
    _datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        NSLog(@"选择的值：%@", selectValue);
        @quec_strongify(self);
        QuecProductTSLPropertyModel *model = self.dataArray[self.dateIndex];
        QuecIotDataPoint *dataPoint = QuecIotDataPoint.new;
        dataPoint.Id = (int)model.itemId;
        dataPoint.dataType = QuecIotDataPointDataTypeDATE;
        dataPoint.code = model.code;
        dataPoint.value = @([self getTimeStrWithString:selectValue]);
        [self sendDps:@[dataPoint]];
    };
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self getTls];
    [self device];
}

- (long)getTimeStrWithString:(NSString*)str {
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *tempDate = [dateFormatter dateFromString:str];
    return (long)[tempDate timeIntervalSince1970]*1000;
}

/// device init
- (void)device{
    [QuecIotCacheService.sharedInstance addDeviceModelList:@[self.dataModel]];
    self.currentDevice = [QuecDevice deviceWithPk:self.dataModel.productKey dk:self.dataModel.deviceKey];
    self.currentDevice.delegate = self;
    [self.currentDevice updateDeviceCloudOnlineStatus:self.dataModel.onlineStatus];
    [self.currentDevice connect];
}

/// The DP updates.
/// @param device device instance.
/// @param dps  command dictionary.
- (void)device:(QuecDevice *)device dpsUpdate:(QuecIotDataPointsModel *)dps{
    NSLog(@"111222--------%@", [dps yy_modelToJSONObject]);
}

- (void)getTls {
    [[QuecDeviceService sharedInstance] getProductTSLWithProductKey:self.dataModel.productKey success:^(QuecProductTSLModel *tslModel) {
        self.dataArray = tslModel.properties.copy;
        [self getTslValue];
    } failure:^(NSError *error) {
        
    }];
}

- (void)getTslValue {
    [[QuecDeviceService sharedInstance] getDeviceBusinessAttributesWithProductKey:self.dataModel.productKey deviceKey:self.dataModel.deviceKey gatewayPk:@"" gatewayDk:@"" codeList:@"" type:@"" success:^(QuecProductTSLInfoModel *tslInfoModel) {
        [self handleDataWithDataModel:tslInfoModel];
    } failure:^(NSError *error) {
        
    }];
}

- (void)handleDataWithDataModel:(QuecProductTSLInfoModel *)tslInfoModel {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataArray.count; i ++) {
        QuecProductTSLPropertyModel *model = self.dataArray[i];
        if ([model.subType isEqualToString:QuecProductionTslSubTypeR]) {
            continue;
        }
        if (![self isAllowedDataType:model.dataType]) {
            continue;
        }
        for (int j = 0; j < tslInfoModel.customizeTslInfo.count; j ++) {
            QuecProductTSLCustomInfoModel *infoModel = tslInfoModel.customizeTslInfo[j];
            if ([model.code isEqualToString:infoModel.resourceCode]) {
                model.attributeValue = infoModel.resourceValue;
                break;
            }
        }
        [tempArray addObject:model];
    }
    if (tempArray.count) {
        self.dataArray = tempArray.mutableCopy;
    }
    [self.tableView reloadData];
}

- (BOOL)isAllowedDataType:(NSString *)dataType {
    if ([QuecProductionTslDataTypeBOOL isEqualToString:dataType]
        || [QuecProductionTslDataTypeTEXT isEqualToString:dataType]
        || [QuecProductionTslDataTypeINT isEqualToString:dataType]
        || [QuecProductionTslDataTypeFLOAT isEqualToString:dataType]
        || [QuecProductionTslDataTypeDOUBLE isEqualToString:dataType]
        || [QuecProductionTslDataTypeENUM isEqualToString:dataType]
        || [QuecProductionTslDataTypeDATE isEqualToString:dataType]) {
        return YES;
    }
    return NO;
}

- (void)detailButtonClick {
    DeviceDetailViewController *detailVc = [[DeviceDetailViewController alloc] init];
    detailVc.dataModel = self.dataModel;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)handleWebSocketDataWithModel:(QuecWebSocketDataModel *)dataModel {
    NSDictionary *dictionary = dataModel.data;
    if ([dictionary[@"type"] isEqualToString:@"MATTR"]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *kvDictionary = dictionary[@"data"][@"kv"];
        NSString *code = [[kvDictionary allKeys] firstObject];
        NSString *value = [NSString stringWithFormat:@"%@",[kvDictionary allValues].firstObject];
        QuecProductTSLPropertyModel *indexModel;
        NSInteger index = 0;
        for (int i = 0; i < self.dataArray.count; i ++) {
            QuecProductTSLPropertyModel *model = self.dataArray[i];
            if ([model.code isEqualToString:code]) {
                model.attributeValue = value;
                indexModel = model;
                index = i;
                break;
            }
        }
        NSMutableArray *copyArray = self.dataArray.mutableCopy;
        if (indexModel) {
            [copyArray replaceObjectAtIndex:index withObject:indexModel];
        }
        self.dataArray = copyArray.copy;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
    else if ([dictionary[@"type"] isEqualToString:QuecWebSocketMessageTypeONLINE]) {
        
    }
}

//- (void)quecWebSocketDidReceiveMessageWithDataModel:(QuecWebSocketDataModel *)dataModel {
//    if ([dataModel.cmd isEqualToString:QuecWebSocketCmdTypeSend_ack]) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        NSString *toast = [(NSDictionary *)dataModel.data objectForKey:@"status"];
//        if ([toast isEqualToString:@"succ"]) {
//            [self.view makeToast:@"下发成功" duration:3 position:CSToastPositionCenter];
//        }
//        else {
//            [self.view makeToast:@"下发失败" duration:3 position:CSToastPositionCenter];
//        }
//    }
//    else if([dataModel.cmd isEqualToString:QuecWebSocketCmdTypeError]) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        NSString *toast = [(NSDictionary *)dataModel.data objectForKey:@"msg"];
//        [self.view makeToast:toast duration:3 position:CSToastPositionCenter];
//        [self.tableView reloadData];
//    }
//    else if([dataModel.cmd isEqualToString:QuecWebSocketCmdTypeMessage]) {
//        [self handleWebSocketDataWithModel:dataModel];
//    }
//}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuecProductTSLPropertyModel *model = self.dataArray[indexPath.row];
    if ([QuecProductionTslDataTypeBOOL isEqualToString:model.dataType] ) {
        return 140.0;
    }
    else if ([QuecProductionTslDataTypeTEXT isEqualToString:model.dataType] ) {
        return 130.0;
    }
    else if ([QuecProductionTslDataTypeINT isEqualToString:model.dataType]
             || [QuecProductionTslDataTypeFLOAT isEqualToString:model.dataType]
             || [QuecProductionTslDataTypeDOUBLE isEqualToString:model.dataType]) {
        return 120.0;
    }
    else if ([QuecProductionTslDataTypeENUM isEqualToString:model.dataType]
             || [QuecProductionTslDataTypeDATE isEqualToString:model.dataType]) {
        return 80.0;
    }
    else {
        return 0.01;
    }
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuecProductTSLPropertyModel *model = self.dataArray[indexPath.row];
    if ([QuecProductionTslDataTypeBOOL isEqualToString:model.dataType] ) {
        TslBoolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BoolCellID"];
        if (!cell) {
            cell = [[TslBoolTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BoolCellID"];
        }
        [cell refreshCellWithModel:self.dataArray[indexPath.row] index:indexPath.row];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if ([QuecProductionTslDataTypeTEXT isEqualToString:model.dataType] ) {
        TlsTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCellID"];
        if (!cell) {
            cell = [[TlsTextTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TextCellID"];
        }
        [cell refreshCellWithModel:self.dataArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if ([QuecProductionTslDataTypeINT isEqualToString:model.dataType]
             || [QuecProductionTslDataTypeFLOAT isEqualToString:model.dataType]
             || [QuecProductionTslDataTypeDOUBLE isEqualToString:model.dataType]) {
        TslNumberUTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumberCellID"];
        if (!cell) {
            cell = [[TslNumberUTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"NumberCellID"];
        }
        [cell refreshCellWithModel:self.dataArray[indexPath.row] index:indexPath.row];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if ([QuecProductionTslDataTypeENUM isEqualToString:model.dataType]
             || [QuecProductionTslDataTypeDATE isEqualToString:model.dataType]) {
        TslEnumAndDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnumAndDateCellID"];
        if (!cell) {
            cell = [[TslEnumAndDateTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"EnumAndDateCellID"];
        }
        [cell refreshCellWithModel:self.dataArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuecProductTSLPropertyModel *model = self.dataArray[indexPath.row];
    if ([model.dataType isEqualToString:QuecProductionTslDataTypeTEXT]) {
        [self showTextInputWithText:model.attributeValue row:indexPath.row];
    }
    else if ([model.dataType isEqualToString:QuecProductionTslDataTypeDATE]) {
        self.dateIndex = indexPath.row;
        [_datePickerView show];
    }
    else if ([model.dataType isEqualToString:QuecProductionTslDataTypeENUM]) {
        self.enumIndex = indexPath.row;
        [self showActionSheet];
    }
}

#pragma -TslNumberUTableViewCellDelegate
- (void)valueChanged:(NSString *)value index:(NSInteger)index {
    QuecProductTSLPropertyModel *model = self.dataArray[index];
    QuecIotDataPoint *dataPoint = QuecIotDataPoint.new;
    dataPoint.Id = (int)model.itemId;
    if ([model.dataType isEqualToString:QuecProductionTslDataTypeINT]){
        dataPoint.dataType = QuecIotDataPointDataTypeINT;
    }else if ([model.dataType isEqualToString:QuecProductionTslDataTypeFLOAT]){
        dataPoint.dataType = QuecIotDataPointDataTypeFLOAT;
    }else if ([model.dataType isEqualToString:QuecProductionTslDataTypeDOUBLE]){
        dataPoint.dataType = QuecIotDataPointDataTypeDOUBLE;
    }
    dataPoint.code = model.code;
    dataPoint.value = value;
    [self sendDps:@[dataPoint]];
}

#pragma mark - TslBoolTableViewCellDelegate
- (void)stateChanged:(NSString *)state index:(NSInteger)index {
    QuecProductTSLPropertyModel *model = self.dataArray[index];
    QuecIotDataPoint *dataPoint = QuecIotDataPoint.new;
    dataPoint.Id = (int)model.itemId;
    dataPoint.dataType = QuecIotDataPointDataTypeBOOL;
    dataPoint.code = model.code;
    dataPoint.value = state;
    [self sendDps:@[dataPoint]];
}

- (void)sendDps:(NSArray<QuecIotDataPoint*> *)dps{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.currentDevice writeDps:dps success:^{
        quec_async_on_main(^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"下发成功" duration:3 position:CSToastPositionCenter];
        });
    } failure:^(NSError * _Nonnull error) {
        quec_async_on_main(^{
            NSLog(@"111222===========%@", error.localizedDescription);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"下发失败" duration:3 position:CSToastPositionCenter];
        });
    }];
}

- (void)sendDataToDeviceWithData:(NSDictionary *)data row:(NSInteger)row {
    if ([self.dataModel.deviceStatus isEqualToString:@"离线"]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[QuecDeviceService sharedInstance] sendDataToDevicesByHttpWithData:@[data].yy_modelToJSONString deviceList:@[@{@"deviceKey":self.dataModel.deviceKey, @"productKey":self.dataModel.productKey}] type:2 dataFormat:2 success:^(NSDictionary *dictionary) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"下发成功" duration:3 position:CSToastPositionCenter];
        } failure:^(NSError *error) {
            [self.tableView reloadData];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        QuecWebSocketDataModel *dataModel = [[QuecWebSocketDataModel alloc] init];
        dataModel.cmd = QuecWebSocketCmdTypeSend;
        NSMutableDictionary *dataDictionary = @{}.mutableCopy;
        [dataDictionary setValue:self.dataModel.deviceKey forKey:@"deviceKey"];
        [dataDictionary setValue:self.dataModel.productKey forKey:@"productKey"];
        [dataDictionary setValue:@"WRITE-ATTR" forKey:@"type"];
        
        NSMutableDictionary *contentDictionary = data.mutableCopy;
        [dataDictionary setValue:@[contentDictionary].yy_modelToJSONString forKey:@"kv"];
        
        dataModel.data = dataDictionary;
//        [[QuecDeviceService sharedInstance] sendDataToDeviceByWebSocketWithDataModel:dataModel];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }
    
}

- (void)showTextInputWithText:(NSString *)text row:(NSInteger)row  {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请输入文本" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateTextWithText:alertVc.textFields.firstObject.text row:row];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入名称";
        textField.text = text;
    }];
    [alertVc addAction:sureAction];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:true completion:nil];
}

- (void)updateTextWithText:(NSString *)text row:(NSInteger)row {
    QuecProductTSLPropertyModel *model = self.dataArray[row];
    QuecIotDataPoint *dataPoint = QuecIotDataPoint.new;
    dataPoint.Id = (int)model.itemId;
    dataPoint.dataType = QuecIotDataPointDataTypeTEXT;
    dataPoint.code = model.code;
    dataPoint.value = text;
    [self sendDps:@[dataPoint]];
}

- (void)showActionSheet {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请选择枚举" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    QuecProductTSLPropertyModel *model = self.dataArray[self.enumIndex];
    for (int i = 0; i < model.formatSpecs.count; i ++) {
        QuecProductTSLSpecModel *specModel = model.formatSpecs[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:specModel.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self updateEnumValueWithValue:specModel.value];
        }];
        [alertVc addAction:action];
    }
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:true completion:nil];
}

- (void)updateEnumValueWithValue:(NSString *)value {
    QuecProductTSLPropertyModel *model = self.dataArray[self.enumIndex];
    QuecIotDataPoint *dataPoint = QuecIotDataPoint.new;
    dataPoint.Id = (int)model.itemId;
    dataPoint.dataType = QuecIotDataPointDataTypeENUM;
    dataPoint.code = model.code;
    dataPoint.value = value;
    [self sendDps:@[dataPoint]];
}

@end
