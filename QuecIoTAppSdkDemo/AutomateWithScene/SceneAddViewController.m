//
//  SceneAddViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/25.
//

#import "SceneAddViewController.h"
#import "SceneSelectedViewController.h"

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
    
}

- (void)createUI {
    
    UIButton *createButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [createButton setTitle:@"创建" forState:UIControlStateNormal];
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
    
}

- (void)onPushNext {
    SceneSelectedViewController *vc = [[SceneSelectedViewController alloc]init];
    vc.isScene = YES;
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
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

@end
