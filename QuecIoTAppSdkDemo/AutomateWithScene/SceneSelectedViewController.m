//
//  SceneSelectedViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/25.
//

#import "SceneSelectedViewController.h"
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <QuecDeviceKit/QuecDeviceListParamsModel.h>
#import <QuecSmartHomeKit/QuecSmartHomeKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>

@interface SceneSelectedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, strong) NSArray *roomListArray;
@property (nonatomic, strong) QuecFamilyItemModel *currentFamilyModel;
@property (nonatomic, strong) QuecFamilyRoomItemModel *currentRoomModel;

@end

@implementation SceneSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.upSelectedArr.count) {
        self.selectedArray = [NSMutableArray arrayWithArray:self.upSelectedArr];
    }else {
        self.selectedArray = @[].mutableCopy;
    }
    
    UIButton *createButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [createButton setTitle:@"确定" forState:UIControlStateNormal];
    createButton.frame = CGRectMake(0, 0, 50, 50);
    [createButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    createButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [createButton addTarget:self action:@selector(createButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:createButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsMultipleSelection = YES;
    [self.view addSubview:self.tableView];
    
    [self getData];
    
}

- (void)createButtonClick {
    if (self.selectedArray.count) {
        if (self.listBlock) {
            self.listBlock(self.selectedArray.copy);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData {
    
    if (QuecSmartHomeService.sharedInstance.enable) {//开启了家具模式
        [self getCurrentFamilyWithFid:[QuecSmartHomeService sharedInstance].currentFamily.fid];
    }else {
        QuecDeviceListParamsModel *paramsModel = [[QuecDeviceListParamsModel alloc]init];
        paramsModel.pageNumber = 1;
        paramsModel.pageSize = 100;
        paramsModel.isAssociation = 0;
        
        @quec_weakify(self);
        [QuecDeviceService.sharedInstance getDeviceListWithParams:paramsModel success:^(NSArray<QuecDeviceModel *> *list, NSInteger total) {
            @quec_strongify(self);
            self.dataArray = [NSArray arrayWithArray:list];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    
}

- (void)getCurrentFamilyWithFid:(NSString *)fid {
    QuecWeakSelf(self);
    [QuecSmartHomeService.sharedInstance getCurrentFamilyWithFid:fid currentCoordinates:@"" success:^(QuecFamilyItemModel *itemModel){
        QuecStrongSelf(self);
        self.currentFamilyModel = itemModel;
        [self getFamilyRoomList:itemModel];
        [self getCommonUsedDeviceList:itemModel];
    } failure:^(NSError *error) {
        
    }];
}

//查询家庭中的房间列表
- (void)getFamilyRoomList:(QuecFamilyItemModel *)model {
    QuecWeakSelf(self);
    [QuecSmartHomeService.sharedInstance getFamilyRoomListWithFid:model.fid pageNumber:1 pageSize:1000 success:^(NSArray<QuecFamilyRoomItemModel *> *list, NSInteger total) {
        QuecStrongSelf(self);
        QuecFamilyRoomItemModel *model = [[QuecFamilyRoomItemModel alloc]init];
        model.roomName = @"常用";
        model.frid = @"常用ID";
        self.currentRoomModel = model;
        NSMutableArray *array = [NSMutableArray arrayWithArray:list];
        [array insertObject:model atIndex:0];
        self.roomListArray = array.copy;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

//查询常用设备列表
- (void)getCommonUsedDeviceList:(QuecFamilyItemModel *)model {
    QuecWeakSelf(self);
    [QuecSmartHomeService.sharedInstance getCommonUsedDeviceListWithFid:model.fid pageNumber:1 pageSize:1000 isGroupDeviceShow:NO success:^(NSArray<QuecDeviceModel *> *list, NSInteger total) {
        QuecStrongSelf(self);
        self.dataArray = list.copy;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
    }];
}

//查询房间中设备列表
- (void)getFamilyRoomDeviceListWithFrid:(NSString *)frid {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    QuecWeakSelf(self);
    [QuecSmartHomeService.sharedInstance getFamilyRoomDeviceListWithFrid:frid pageNumber:1 pageSize:1000 isGroupDeviceShow:NO success:^(NSArray<QuecDeviceModel *> *list, NSInteger total) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        QuecStrongSelf(self);
        self.dataArray = list.copy;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return QuecSmartHomeService.sharedInstance.enable ? 100 : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    
    if (!QuecSmartHomeService.sharedInstance.enable) {
        view.hidden = YES;
        return view;
    }
    
    view.hidden = NO;
    UILabel *familyTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.bounds.size.width - 40, 30)];
    familyTitle.font = [UIFont boldSystemFontOfSize:16];
    familyTitle.textColor = UIColor.darkGrayColor;
    familyTitle.text = [NSString stringWithFormat:@"%@--%@",self.currentFamilyModel.familyName,self.currentRoomModel.roomName];
    familyTitle.userInteractionEnabled = YES;
    [view addSubview:familyTitle];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 40)];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 40);
    [view addSubview:scrollView];
    UIButton *lastBtn = nil;
    NSInteger tag = 0;
    for (QuecFamilyRoomItemModel *model in self.roomListArray) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:model.roomName forState:UIControlStateNormal];
        btn.tag = tag;
        [btn addTarget:self action:@selector(roomAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.backgroundColor = UIColor.systemBlueColor;
        [scrollView addSubview:btn];
        if (lastBtn == nil) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@20);
                make.centerY.equalTo(scrollView);
                make.width.equalTo(@80);
                make.height.equalTo(@30);
            }];
        }else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastBtn.mas_right).offset(20);
                make.centerY.equalTo(scrollView);
                make.width.equalTo(@80);
                make.height.equalTo(@30);
            }];
        }
        tag++;
        lastBtn = btn;
    }
    
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    QuecDeviceModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.deviceName;
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if ([self.selectedArray containsObject:model]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuecDeviceModel *model = self.dataArray[indexPath.row];
    /// 多绑设备和分享设备以及纯蓝牙设备不支持加入场景
    if (self.isScene && (model.isShared || model.bindMode == 1 || model.capabilitiesBitmask == 4)) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.view makeToast:@"多绑设备和分享设备以及纯蓝牙设备不支持加入场景" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    /// 多绑设备和分享设备以及纯蓝牙设备不支持加入场景
    if (self.isAutomate && (model.isShared || model.bindMode == 1 || model.capabilitiesBitmask == 4)) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.view makeToast:@"多绑设备和分享设备以及纯蓝牙设备不支持加入自动化" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    if ([self.selectedArray containsObject:model]) {
        [self.selectedArray removeObject:model];
    }else {
        [self.selectedArray addObject:model];
    }
    
    [self.tableView reloadData];
}

- (void)roomAction:(UIButton *)sender {
    QuecFamilyRoomItemModel *model = self.roomListArray[sender.tag];
    if ([self.currentRoomModel.frid isEqualToString:model.frid]) {
        return;
    }
    
    self.currentRoomModel = model;
    
    if ([self.currentRoomModel.frid isEqualToString:@"常用ID"]) {
        [self getCommonUsedDeviceList:self.currentFamilyModel];
    }else {
        [self getFamilyRoomDeviceListWithFrid:self.currentRoomModel.frid];
    }
    
}

@end
