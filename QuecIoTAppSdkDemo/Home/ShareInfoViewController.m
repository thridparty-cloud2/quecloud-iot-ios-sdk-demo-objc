//
//  ShareInfoViewController.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/10/30.
//

#import "ShareInfoViewController.h"
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ShareInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *shareCodeLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ShareInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setTitle:@"获取分享码" forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(20, 100, 80, 50);
    [shareButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    
    self.shareCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 75, 200, 100)];
    self.shareCodeLabel.numberOfLines = 0;
    self.shareCodeLabel.textColor = [UIColor lightGrayColor];
    self.shareCodeLabel.font = [UIFont systemFontOfSize:15];
    self.shareCodeLabel.userInteractionEnabled = YES;
    [self.view addSubview:self.shareCodeLabel];
    
    UITapGestureRecognizer *tapShareCode = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShareCode)];
    [self.shareCodeLabel addGestureRecognizer:tapShareCode];
    
    
    UILabel *ptomptLabel = [[UILabel alloc] init];
    ptomptLabel.text = @"管理分享权限";
    ptomptLabel.textColor = [UIColor lightGrayColor];
    ptomptLabel.font = [UIFont systemFontOfSize:15];
    ptomptLabel.frame = CGRectMake(20, 330, 200, 50);
    [self.view addSubview:ptomptLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 380, self.view.frame.size.width - 40, self.view.frame.size.height - 380) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self getData];
}

- (void)tapShareCode {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.shareCodeLabel.text];
    [self.view makeToast:@"已复制" duration:3 position:CSToastPositionCenter];
}

- (void)getData {
    [[QuecDeviceService sharedInstance] getDeviceShareUserListWithDeviceKey:self.dataModel.deviceKey productKey:self.dataModel.productKey success:^(NSArray<QuecShareUserModel *> *list) {
        self.dataArray = list;
        [self.tableView reloadData];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}

- (void)shareButtonClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDate *date = [NSDate date];
    NSTimeInterval time = (long long)[date timeIntervalSince1970] * 1000 + 10 * 60 * 1000;
    [[QuecDeviceService sharedInstance] setShareInfoByOwnerWithDeviceKey:self.dataModel.deviceKey productKey:self.dataModel.productKey acceptingExpireTime:time coverMark:1
                                                    isSharingAlwaysValid:YES
                                                       sharingExpireTime:0 success:^(NSString *shareCode) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.shareCodeLabel.text = shareCode;
    }failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
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
    QuecShareUserModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.userInfo.phone;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = model.userInfo.nikeName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deleteShareUserWithRow:indexPath.row];
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    return @[deleteRowAction];
}

- (void)deleteShareUserWithRow:(NSInteger)row {
    QuecShareUserModel *model = self.dataArray[row];
    [[QuecDeviceService sharedInstance] unShareDeviceByOwnerWithShareCode:model.shareInfo.shareCode success:^{
        [self getData];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
        }];
}

@end
