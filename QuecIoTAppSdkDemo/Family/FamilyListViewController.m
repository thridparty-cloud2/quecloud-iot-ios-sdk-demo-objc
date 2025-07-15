//
//  FamilyListViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/20.
//

#import "FamilyListViewController.h"
#import <QuecSmartHomeKit/QuecSmartHomeKit.h>
#import "FamilyDetailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface FamilyListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation FamilyListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家庭列表";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0, 0, 50, 50);
    [addButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
}

- (void)addButtonClick {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"创建家庭" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addFamily:alertVc];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入家庭名";
    }];
    [alertVc addAction:sureAction];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:true completion:nil];
}

- (void)addFamily:(UIAlertController *)alert {
    NSString *familyName = @"";
    for(int i = 0; i < alert.textFields.count; i ++) {
        NSString *value = alert.textFields[i].text ? (alert.textFields[i].text) : (@"");
        switch (i) {
            case 0:
                familyName = value;
                break;
        }
    }
    if (familyName.length == 0) {
        NSLog(@"请输入家庭名");
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    QuecFamilyParamModel *paramModel = [[QuecFamilyParamModel alloc]init];
    paramModel.familyName = familyName;
    @quec_weakify(self);
    [QuecSmartHomeService.sharedInstance addFamilyWithFamilyParamModel:paramModel success:^{
        @quec_strongify(self);
        [self getData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


- (void)getData {
    @quec_weakify(self);
    [QuecSmartHomeService.sharedInstance getFamilyListWithRole:@"" pageNumber:1 pageSize:10000 success:^(NSArray<QuecFamilyItemModel *> *list, NSInteger total) {
        @quec_strongify(self);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.dataArray = [NSArray arrayWithArray:list];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
    }
    QuecFamilyItemModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.familyName;
    cell.textLabel.textColor = [UIColor blackColor];
    
    for (id child in cell.contentView.subviews) {
        if ([child isKindOfClass:[UIButton class]]) {
            [child removeFromSuperview];
        }
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.bounds.size.width - 120 , 10, 100, 40);
    [btn setTitle:@"家庭详情" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.systemBlueColor;
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(pushNextPage:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [cell.contentView addSubview:btn];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuecFamilyItemModel *model = self.dataArray[indexPath.row];
    if (self.fidbBlock) {
        self.fidbBlock(model.fid);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - action
- (void)pushNextPage:(UIButton *)sender  {
    QuecFamilyItemModel *model = self.dataArray[sender.tag];
    FamilyDetailViewController *vc = [[FamilyDetailViewController alloc]init];
    vc.upModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
