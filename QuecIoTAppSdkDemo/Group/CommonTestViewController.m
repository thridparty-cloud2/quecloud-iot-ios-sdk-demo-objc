//
//  CommonTestViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by quectel.tank on 4/29/25.
//

#import "CommonTestViewController.h"
#import <QuecFoundationKit/QuecFoundationKit.h>
#import "SceneViewController.h"
#import "AutomateViewController.h"
#import "DeviceGroupViewController.h"
#import "QuecOTAViewController.h"
#import <QuecSmartHomeKit/QuecSmartHomeKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>

@interface CommonTestViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSString *> *items;
@property (nonatomic, assign) BOOL isFamilyMode;
@property (nonatomic, strong) UISwitch *toggleSwitch;
@end

@implementation CommonTestViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkFamilyModeState];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通用模块";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isFamilyMode = QuecSmartHomeService.sharedInstance.enable;
    [self setupTableView];
}

- (NSMutableArray<NSString *> *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)refreshItems{
    [self.items removeAllObjects];
    [self.items quec_safeAddObject:@"场景"];
    [self.items quec_safeAddObject:@"自动化"];
    if (!self.isFamilyMode) {
        [self.items quec_safeAddObject:@"分组"];
    }
    [self.items quec_safeAddObject:@"OTA"];
    [self.tableView reloadData];
}

- (void)checkFamilyModeState {
    QuecWeakSelf(self);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [QuecSmartHomeService.sharedInstance getFamilyModeConfigWithSuccess:^(QuecFamilyModeConfigModel *model) {
        QuecStrongSelf(self);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.isFamilyMode = QuecSmartHomeService.sharedInstance.enable;
        [self refreshItems];
        [self.toggleSwitch setOn:self.isFamilyMode];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 65)];
    header.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.05];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    label.textColor = [UIColor darkTextColor];
    label.text = @"家居模式:";
    [label sizeToFit];
    label.frame = CGRectMake(20, (65 - label.frame.size.height) / 2.0, label.frame.size.width, label.frame.size.height);
    [header addSubview:label];

    self.toggleSwitch = [[UISwitch alloc] init];
    CGSize switchSize = self.toggleSwitch.frame.size;
    CGFloat switchX = ScreenWidth - switchSize.width - 20;
    CGFloat switchY = (65 - switchSize.height) / 2.0;
    self.toggleSwitch.frame = CGRectMake(switchX, switchY, switchSize.width, switchSize.height);
    self.toggleSwitch.onTintColor = [UIColor systemGreenColor];
    self.toggleSwitch.thumbTintColor = [UIColor whiteColor];
    [self.toggleSwitch addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    [header addSubview:self.toggleSwitch];
    
    self.tableView.tableHeaderView = header;
    [self.view addSubview:self.tableView];
}

- (void)switchToggled:(UISwitch *)sender {
    @quec_weakify(self);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [QuecSmartHomeService.sharedInstance enabledFamilyMode:!QuecSmartHomeService.sharedInstance.enable success:^{
        @quec_strongify(self);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self checkFamilyModeState];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"SimpleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        cell.textLabel.textColor = [UIColor darkTextColor];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *item = [self.items quec_safeObjectAtIndex:indexPath.row];
    UIViewController *vc;
    if ([item isEqualToString:@"场景"]) {
        vc = [[SceneViewController alloc]init];
    } else if ([item isEqualToString:@"自动化"]) {
        vc = [[AutomateViewController alloc]init];
    } else if ([item isEqualToString:@"分组"]) {
        vc = [[DeviceGroupViewController alloc]init];
    } else if ([item isEqualToString:@"OTA"]) {
        vc = [[QuecOTAViewController alloc]init];
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
