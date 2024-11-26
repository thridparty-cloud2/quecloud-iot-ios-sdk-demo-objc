//
//  SceneAddViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/25.
//

#import "SceneAddViewController.h"
#import "SceneSelectedViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>
#import <QuecSceneKit/QuecSceneKit.h>
#import <QuecSmartHomeKit/QuecSmartHomeKit.h>
#import <QuecDeviceKit/QuecDeviceKit.h>
#import "SceneSetDeviceActionVC.h"
#import <QuecCommonUtil/QuecCommonUtil.h>

static int const kSceneNoExistErrorCode = 6046;

@interface SceneAddViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SceneAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"创建场景";
    
    [self createUI];
    
    if (self.upSceneModel) {
        [self getDetailData];
    }
    
}

- (void)getDetailData {
    [QuecSceneService.sharedInstance getSceneInfoWithFid:self.upSceneModel.fid sceneId:self.upSceneModel.sceneInfo.sceneId success:^(QuecSceneModel * _Nonnull scene) {
        
        self.nameTextField.text = scene.sceneInfo.name;
        NSMutableArray *array = @[].mutableCopy;
        for (QuecSceneMetaDataModel *metaModel in scene.sceneInfo.metaDataList) {
            QuecDevice *device = [QuecDevice deviceWithId:quec_deviceId(metaModel.productKey, metaModel.deviceKey)];
            if (device) {
                [array addObject:device.model];
            }
        }
        self.dataArray = [NSArray arrayWithArray:array.copy];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)createUI {
    
    UIButton *createButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [createButton setTitle:@"保存" forState:UIControlStateNormal];
    createButton.frame = CGRectMake(0, 0, 50, 50);
    [createButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    createButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [createButton addTarget:self action:@selector(createButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:createButton];
        
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, ScreenWidth, 60);
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth - 40, 40)];
    self.nameTextField.placeholder = @"请填写场景名称";
    [headerView addSubview:self.nameTextField];
    self.tableView.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, ScreenWidth, 80);
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(20, 20, ScreenWidth - 40, 40);
    addBtn.backgroundColor = UIColor.systemBlueColor;
    [addBtn setTitle:@"添加设备" forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(onPushNext) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addBtn];
    self.tableView.tableFooterView = footerView;
    
}

- (void)createButtonClick {
    if (self.nameTextField.text.length == 0) {
        [self.view makeToast:@"请填写场景名称" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    if (self.dataArray.count == 0) {
        [self.view makeToast:@"请选择设备" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    NSString *fid = @"";
    if (QuecSmartHomeService.sharedInstance.enable) {
        fid = [QuecSmartHomeService sharedInstance].currentFamily.fid;
    }
    
    NSMutableArray *metaDataList = @[].mutableCopy;
    for (QuecDeviceModel *deviceModel in self.dataArray) {
        //写死的一个物模型动作，仅做接口请求示例。具体请根据业务需求自行通过 获取设备物模型 接口获取设备物模型类型，自行筛选
        QuecSceneActionModel *action = [[QuecSceneActionModel alloc]init];
        action.subType = @"RW";
        action.dataType = @"BOOL";
        action.itemId = 1;
        action.code = @"bool";
        action.subName = @"1";
        action.value = @"true";
        action.type = @"PROPERTY";
        action.name = @"bool";
        
        QuecSceneMetaDataModel *sceneMetaDataModel = [[QuecSceneMetaDataModel alloc]init];
        sceneMetaDataModel.deviceKey = deviceModel.deviceKey;
        sceneMetaDataModel.productKey = deviceModel.productKey;
        sceneMetaDataModel.deviceName = deviceModel.deviceName;
        sceneMetaDataModel.deviceType = deviceModel.deviceType;
        sceneMetaDataModel.actionList = @[action];
        [metaDataList addObject:sceneMetaDataModel];
    }
    
    QuecSceneInfoModel *sceneInfoModel = [[QuecSceneInfoModel alloc]init];
    sceneInfoModel.name = self.nameTextField.text;
    sceneInfoModel.icon = @"https://iot-oss.quectelcn.com/quec_scene_1.png";
    sceneInfoModel.metaDataList = metaDataList.copy;
    if (self.upSceneModel) {//编辑
        sceneInfoModel.sceneId = self.upSceneModel.sceneInfo.sceneId;
        fid = self.upSceneModel.fid;
    }
    
    QuecSceneModel *sceneModel = [[QuecSceneModel alloc]init];
    sceneModel.fid = fid;
    sceneModel.isCommon = NO;
    sceneModel.sceneInfo = sceneInfoModel;
     
    @quec_weakify(self);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (self.upSceneModel) {//编辑
        [QuecSceneService.sharedInstance editSceneWithSceneModel:sceneModel success:^{
            @quec_strongify(self);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [quec_TopViewController().navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            @quec_strongify(self);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [quec_MainWindow() makeToast:error.localizedDescription duration:1 position:CSToastPositionCenter];
            if (error && error.code == kSceneNoExistErrorCode) {
                [quec_TopViewController().navigationController popViewControllerAnimated:YES];
            }
        }];
    }else {
        [[QuecSceneService sharedInstance] addSceneWithSceneModel:sceneModel success:^{
            @quec_strongify(self);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [quec_TopViewController().navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            @quec_strongify(self);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [quec_MainWindow() makeToast:error.localizedDescription duration:1 position:CSToastPositionCenter];
            if (error && error.code == kSceneNoExistErrorCode) {
                [quec_TopViewController().navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    
}

- (void)onPushNext {
    SceneSelectedViewController *vc = [[SceneSelectedViewController alloc]init];
    vc.isScene = YES;
    if (self.dataArray.count) {
        vc.upSelectedArr = self.dataArray.copy;
    }
    @quec_weakify(self);
    vc.listBlock = ^(NSArray<QuecDeviceModel *> * _Nonnull list) {
        @quec_strongify(self);
        self.dataArray = [NSArray arrayWithArray:list];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    QuecDeviceModel *deviceModel = self.dataArray[indexPath.row];
    cell.textLabel.text = deviceModel.deviceName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuecDeviceModel *deviceModel = self.dataArray[indexPath.row];
    SceneSetDeviceActionVC *vc = [[SceneSetDeviceActionVC alloc]init];
    vc.deviceModel = deviceModel;
    [self.navigationController pushViewController:vc animated:YES];
   
}

@end
