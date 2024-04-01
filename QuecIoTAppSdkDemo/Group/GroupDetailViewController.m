//
//  GroupDetailViewController.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/11/1.
//

#import "GroupDetailViewController.h"
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYModel/YYModel.h>
#import "DeviceSelectViewController.h"

@interface GroupDetailViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITextView *_textView;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation GroupDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDeviceList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分组详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加设备" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0, 0, 70, 50);
    [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    
    _textView = [[UITextView alloc] init];
    _textView.textColor = [UIColor lightGrayColor];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.frame = CGRectMake(20, 20, self.view.frame.size.width - 40, 200);
    [self.view addSubview:_textView];
    [self getData];
    
    
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    promptLabel.text = @"   设备列表";
    promptLabel.textColor = [UIColor lightGrayColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, self.view.frame.size.height - 220) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = promptLabel;
}

- (void)addButtonClick {
    DeviceSelectViewController *deviceSelectVc = [[DeviceSelectViewController alloc] init];
    deviceSelectVc.dataModel = self.dataModel;
    [self.navigationController pushViewController:deviceSelectVc animated:YES];
}

- (void)getData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecDeviceService sharedInstance] getDeviceGroupInfoWithDeviceGroupId:self.dataModel.dgid success:^(QuecDeviceGroupInfoModel *dataModel) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self->_textView.text = dataModel.yy_modelToJSONString;
        } failure:^(NSError *error) {
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
}

- (void)getDeviceList {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuecDeviceService sharedInstance] getDeviceListWithDeviceGroupId:self.dataModel.dgid deviceGroupName:@"" deviceKeyList:@"" productKey:@"" pageNumber:1 pageSize:10 success:^(NSArray<NSDictionary *> *data, NSInteger total) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.dataArray = data.copy;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
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
    QuecDeviceModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.deviceKey;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UITableViewRowAction *unbindRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deleteDeviceFromGroupWithRow:indexPath.row];
    }];
    unbindRowAction.backgroundColor = [UIColor redColor];
    return @[unbindRowAction];
}

- (void)deleteDeviceFromGroupWithRow:(NSInteger)row {
    [[QuecDeviceService sharedInstance] deleteDeviceFromGroupWithDeviceGroupId:self.dataModel.dgid deviceList:@[@{@"dk":self.dataArray[row][@"dk"], @"pk": self.dataArray[row][@"pk"]}] success:^(NSDictionary *data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:@"删除成功" duration:3 position:CSToastPositionCenter];
        [self getDeviceList];
        } failure:^(NSError *error) {
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
}


@end
