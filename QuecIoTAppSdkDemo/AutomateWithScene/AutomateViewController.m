//
//  AutomateViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/25.
//

#import "AutomateViewController.h"
#import <QuecAutomateKit/QuecAutomateKit.h>
#import <QuecSmartHomeKit/QuecSmartHomeKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>
#import "AutomateAddViewController.h"
#import "AutomateDetailViewController.h"

@interface AutomateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation AutomateViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
   
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"自动化";
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加自动化" forState:UIControlStateNormal];
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

- (void)superViewWillAppear {
    [self getData];
}

- (void)addButtonClick {
    AutomateAddViewController *vc = [[AutomateAddViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getData {
    
    NSString *fid = @"";
    if (QuecSmartHomeService.sharedInstance.enable) {
        fid = [QuecSmartHomeService sharedInstance].currentFamily.fid;
    }
    
    @quec_weakify(self);
    [QuecAutomateService.sharedInstance getAutomationListWithPageNumber:1 pageSize:100 success:^(NSArray<QuecAutomateModel *> * _Nonnull models, NSUInteger total) {
        @quec_strongify(self);
        self.dataArray = [NSArray arrayWithArray:models];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
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
    
    QuecAutomateModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    
    for (id child in cell.contentView.subviews) {
        if ([child isKindOfClass:[UISwitch class]]) {
            [child removeFromSuperview];
        }
    }
    
    UISwitch *actionSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth - 60, 20, 50, 40)];
    actionSwitch.tag = indexPath.row;
    [actionSwitch addTarget:self action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:actionSwitch];
    actionSwitch.on = model.status;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuecAutomateModel *model = self.dataArray[indexPath.row];
    AutomateDetailViewController *vc = [[AutomateDetailViewController alloc]init];
    vc.automateModel = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES; // Allow editing of rows
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *unbindRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deleteGroupWithRow:indexPath.row];
    }];
    unbindRowAction.backgroundColor = [UIColor redColor];
    
    return @[unbindRowAction];
}

- (void)deleteGroupWithRow:(NSInteger)row {
    QuecAutomateModel *model = self.dataArray[row];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *fid = @"";
    if (QuecSmartHomeService.sharedInstance.enable) {
        fid = [QuecSmartHomeService sharedInstance].currentFamily.fid;
    }
    [QuecAutomateService.sharedInstance deleteAutomationWithAutomationId:model.automationId success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self getData];
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:1 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)stateChanged:(UISwitch *)state {
    NSLog(@"stateChanged: %d",state.on);
    NSString *fid = @"";
    if (QuecSmartHomeService.sharedInstance.enable) {
        fid = [QuecSmartHomeService sharedInstance].currentFamily.fid;
    }
    QuecAutomateModel *model = self.dataArray[state.tag];
    @quec_weakify(self);
    [QuecAutomateService.sharedInstance updateAutomationSwitchStatusWithAutomationId:model.automationId status:state.on success:^{
        @quec_strongify(self);
        model.status = state.on;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        @quec_strongify(self);
        [self.tableView reloadData];
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
    }];
}

@end
