//
//  SceneViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/25.
//

#import "SceneViewController.h"
#import <QuecSceneKit/QuecSceneKit.h>
#import <QuecSmartHomeKit/QuecSmartHomeKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "SceneAddViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>

@interface SceneViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SceneViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加场景" forState:UIControlStateNormal];
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
    SceneAddViewController *vc = [[SceneAddViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getData {
    
    NSString *fid = @"";
    if (QuecSmartHomeService.sharedInstance.enable) {
        fid = [QuecSmartHomeService sharedInstance].currentFamily.fid;
    }
    
    @quec_weakify(self);
    [[QuecSceneService sharedInstance] getSceneListWithFid:fid pageNumber:1 pageSize:100 success:^(NSArray<QuecSceneModel *> * _Nonnull list, NSInteger total) {
        @quec_strongify(self);
        
        self.dataArray = [NSArray arrayWithArray:list];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @quec_strongify(self);
        
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
    
    QuecSceneModel *model = self.dataArray[indexPath.row];
    if (model.sceneInfo.icon.length) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.sceneInfo.icon] placeholderImage:[UIImage imageNamed:@"group_tabbar"]];
    }
    cell.textLabel.text = model.sceneInfo.name;
        
    for (id child in cell.contentView.subviews) {
        if ([child isKindOfClass:[UIButton class]]) {
            [child removeFromSuperview];
        }
    }
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setTitle:@"执行场景" forState:UIControlStateNormal];
    actionButton.frame = CGRectMake(ScreenWidth - 100, 10, 80, 40);
    actionButton.backgroundColor = UIColor.systemBlueColor;
    actionButton.tag = indexPath.row;
    [actionButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:actionButton];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuecSceneModel *model = self.dataArray[indexPath.row];
    SceneAddViewController *vc = [[SceneAddViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.upSceneModel = model;
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
    QuecSceneModel *model = self.dataArray[row];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *fid = @"";
    if (QuecSmartHomeService.sharedInstance.enable) {
        fid = [QuecSmartHomeService sharedInstance].currentFamily.fid;
    }
    [[QuecSceneService sharedInstance] deleteSceneWithFid:fid sceneId:model.sceneInfo.sceneId success:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self getData];
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:1 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)actionButtonClick:(UIButton *)sender {
    QuecSceneModel *model = self.dataArray[sender.tag];
    @quec_weakify(self);
    [QuecSceneService.sharedInstance executeSceneWithFid:model.fid sceneId:model.sceneInfo.sceneId success:^(QuecActionExecuteResultModel * _Nonnull executeResultModel) {
        
        if (executeResultModel.executeResult) {
            [self.view makeToast:@"执行成功" duration:1 position:CSToastPositionCenter];
        }else {
            [self.view makeToast:@"执行失败" duration:1 position:CSToastPositionCenter];
        }
        
    } failure:^(NSError *error) {
        [self.view makeToast:error.localizedDescription duration:1 position:CSToastPositionCenter];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

@end
