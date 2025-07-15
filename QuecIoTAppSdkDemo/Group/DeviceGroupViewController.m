//
//  DeviceGroupViewController.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/10/30.
//

#import "DeviceGroupViewController.h"
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "GroupDetailViewController.h"
@interface DeviceGroupViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DeviceGroupViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分组";
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加分组" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [addButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor = UIColor.lightGrayColor;
    [headerView addSubview:addButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self getData];
    
}

- (void)refreshUI {
    [self.tableView reloadData];
}

- (void)addButtonClick {
    [self showGroupNameInput:NO row:0];
}

- (void)showGroupNameInput:(BOOL)isUpdate row:(NSInteger)row {
    NSString *title = @"新建分组";
    NSString *text = @"";
    NSString *dgid = @"";
    if (isUpdate) {
        title = @"更改分组名称";
        QuecDeviceGroupInfoModel *model = self.dataArray[row];
        text = model.name;
        dgid = model.dgid;
    }
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateGroupWithName:alertVc.textFields.firstObject.text isUpdate:isUpdate dgid:dgid];
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

- (void)updateGroupWithName:(NSString *)groupName isUpdate:(BOOL)isUpdate dgid:(NSString *)dgid {
    if (!groupName.length) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    QuecDeviceGroupParamModel *model = [[QuecDeviceGroupParamModel alloc] init];
    model.name = groupName;
    if (isUpdate) {
        [QuecDeviceGroupService.sharedInstance updateDeviceGroupInfoWithDeviceGroupId:dgid infoModel:model success:^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self getData];
        } failure:^(NSError *error) {
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    else {
        
        [[QuecDeviceGroupService sharedInstance] addDeviceGroupWithInfo:model success:^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self getData];
        } failure:^(NSError *error) {
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    
}

- (void)getData {
    @quec_weakify(self);
    [[QuecDeviceGroupService sharedInstance] getDeviceGroupListWithPageNumber:1 pageSize:100 extra:nil success:^(NSArray<QuecDeviceGroupInfoModel *> *list, NSInteger total) {
        @quec_strongify(self);
        self.dataArray = list.copy;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
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
    QuecDeviceGroupInfoModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = model.addTime;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GroupDetailViewController *detailVc = [[GroupDetailViewController alloc] init];
    detailVc.hidesBottomBarWhenPushed = YES;
    detailVc.dataModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES; // Allow editing of rows
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //重命名
    UITableViewRowAction *renameRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"重命名" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self showGroupNameInput:YES row:indexPath.row];
    }];
    renameRowAction.backgroundColor = [UIColor lightGrayColor];
    //解绑
    UITableViewRowAction *unbindRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deleteGroupWithRow:indexPath.row];
    }];
    unbindRowAction.backgroundColor = [UIColor redColor];
    
    return @[unbindRowAction, renameRowAction];
}

- (void)deleteGroupWithRow:(NSInteger)row {
    QuecDeviceGroupInfoModel *model = self.dataArray[row];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecDeviceGroupService sharedInstance] deleteDeviceGroupWithDeviceGroupId:model.dgid success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self getData];
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

@end
