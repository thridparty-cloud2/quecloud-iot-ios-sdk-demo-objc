//
//  FamilyRoomListViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/21.
//

#import "FamilyRoomListViewController.h"
#import <QuecSmartHomeKit/QuecSmartHomeKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>
@interface FamilyRoomListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation FamilyRoomListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"房间管理";
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0, 0, 50, 50);
    [addButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self getData];
    
}

- (void)getData {
    @quec_weakify(self);
    [QuecSmartHomeService.sharedInstance getFamilyRoomListWithFid:self.upModel.fid pageNumber:1 pageSize:10000 success:^(NSArray<QuecFamilyRoomItemModel *> *list, NSInteger total) {
        @quec_strongify(self);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.dataArray = [NSArray arrayWithArray:list];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)addButtonClick {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"添加房间" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addRoom:alertVc];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入房间名";
    }];
    [alertVc addAction:sureAction];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:true completion:nil];
}

- (void)addRoom:(UIAlertController *)alert {
    NSString *roomName = @"";
    for(int i = 0; i < alert.textFields.count; i ++) {
        NSString *value = alert.textFields[i].text ? (alert.textFields[i].text) : (@"");
        switch (i) {
            case 0:
                roomName = value;
                break;
        }
    }
    if (roomName.length == 0) {
        NSLog(@"请输入房间名");
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    @quec_weakify(self);
    [QuecSmartHomeService.sharedInstance addFamilyRoomWithFid:self.upModel.fid roomName:roomName success:^{
        @quec_strongify(self);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Home_List_Refresh_Notification" object:nil];
        [self getData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
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
    QuecFamilyRoomItemModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.roomName;
    
    for (id child in cell.contentView.subviews) {
        if ([child isKindOfClass:[UIButton class]]) {
            [child removeFromSuperview];
        }
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.bounds.size.width - 120 , 10, 100, 40);
    [btn setTitle:@"删除房间" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.redColor;
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [cell.contentView addSubview:btn];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - action
- (void)deleteAction:(UIButton *)sender  {
    QuecFamilyRoomItemModel *model = self.dataArray[sender.tag];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    @quec_weakify(self);
    [QuecSmartHomeService.sharedInstance deleteFamilyRoomsWithIds:@[model.frid] success:^{
        @quec_strongify(self);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Home_List_Refresh_Notification" object:nil];
        [self getData];
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
    }];
}

@end
