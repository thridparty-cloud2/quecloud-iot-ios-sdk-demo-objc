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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}


@end
