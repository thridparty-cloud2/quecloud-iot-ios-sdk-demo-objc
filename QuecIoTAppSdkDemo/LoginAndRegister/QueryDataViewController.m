//
//  QueryDataViewController.m
//  QuecUserKitExample
//
//  Created by quectel.steven on 2021/9/4.
//

#import "QueryDataViewController.h"
#import <QuecUserKit/QuecUserKit.h>
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface QueryDataViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation QueryDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.type) {
        case 1: {
            self.title = @"国家码";
        }
            break;
        case 2: {
            self.title = @"语言";
        }
            break;
        case 3: {
            self.title = @"时区";
        }
            break;
            
        default:
            break;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.view addSubview:self.dataTableView];
    [self getData];
}

- (void)getData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    switch (self.type) {
        case 1: {
            [[QuecUserService sharedInstance] getNationalityListWithSuccess:^(NSArray *list) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.dataArray = list.copy;
                [self.dataTableView reloadData];
                        } failure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
                        }];
        }
            break;
        case 2: {
            [[QuecUserService sharedInstance] getLanguageListWithSuccess:^(NSArray *list) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.dataArray = list.copy;
                [self.dataTableView reloadData];
                        } failure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
                        }];
        }
            break;
        case 3: {
            [[QuecUserService sharedInstance] getTimezoneListWithSuccess:^(NSArray *list) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.dataArray = list.copy;
                [self.dataTableView reloadData];
                        } failure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self.view makeToast:error.localizedDescription duration:3 position:CSToastPositionCenter];
                        }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"id"]];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = self.dataArray[indexPath.row][@"val"];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectId:value:type:)]) {
        [self.delegate selectId:[self.dataArray[indexPath.row][@"id"] integerValue] value:self.dataArray[indexPath.row][@"val"] type:self.type];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
