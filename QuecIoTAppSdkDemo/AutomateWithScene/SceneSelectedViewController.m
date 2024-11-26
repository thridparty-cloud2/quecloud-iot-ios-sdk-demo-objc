//
//  SceneSelectedViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/25.
//

#import "SceneSelectedViewController.h"
#import <QuecDeviceKit/QuecDeviceKit.h>
#import <QuecDeviceKit/QuecDeviceListParamsModel.h>

@interface SceneSelectedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectedArray;

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
        return;
    }
    
    if ([self.selectedArray containsObject:model]) {
        [self.selectedArray removeObject:model];
    }else {
        [self.selectedArray addObject:model];
    }
    
    [self.tableView reloadData];
}

@end
