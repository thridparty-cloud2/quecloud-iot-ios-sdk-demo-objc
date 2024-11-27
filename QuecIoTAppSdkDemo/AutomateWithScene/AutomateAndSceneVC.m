//
//  AutomateAndSceneVC.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/25.
//

#import "AutomateAndSceneVC.h"
#import <QuecSmartHomeKit/QuecSmartHomeKit.h>
#import "SceneViewController.h"
#import "AutomateViewController.h"
#import "DeviceGroupViewController.h"

static CGFloat HeaderItemHeight = 100.f;

@interface AutomateAndSceneVC ()

@property (nonatomic, assign) BOOL isFamilyMode;
@property (nonatomic, strong) UIView *headerItem;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SceneViewController *sceneVC;
@property (nonatomic, strong) AutomateViewController *automateVC;
@property (nonatomic, strong) DeviceGroupViewController *deviceGroupVC;

@property (nonatomic, strong) UIButton *deviceGroupBtn;

@end

@implementation AutomateAndSceneVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    [self.sceneVC superViewWillAppear];
    [self.automateVC superViewWillAppear];
    [self checkFamilyModeState];
}

- (void)viewDidDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"分组";
    self.isFamilyMode = QuecSmartHomeService.sharedInstance.enable;
    
    [self createItemBtn:self.isFamilyMode];
}

- (void)createItemBtn:(BOOL)isFamilyMode {
    
    self.headerItem.frame = CGRectMake(0, 0, ScreenWidth, HeaderItemHeight);
    
    self.scrollView.frame = CGRectMake(0, HeaderItemHeight, ScreenWidth, ScreenHeight - HeaderItemHeight - quec_TabBarHeight());
    
    NSArray *array = @[@"场景", @"自动化", @"分组"];
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        if (i==0) {
            btn.selected = YES;
        }
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitle:array[i] forState:UIControlStateSelected];
        btn.backgroundColor = UIColor.systemBlueColor;
        [btn setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerItem addSubview:btn];
        
        self.deviceGroupBtn = btn;
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(65);
            make.width.mas_equalTo(80);
            make.left.mas_equalTo(20 * (i+1) + i * 80);
            make.height.mas_equalTo(30);
        }];
    }
    
    self.sceneVC = [[SceneViewController alloc]init];
    self.automateVC = [[AutomateViewController alloc]init];
    self.deviceGroupVC = [[DeviceGroupViewController alloc]init];
    
    [self addChildViewController:self.sceneVC];
    [self addChildViewController:self.automateVC];
    [self addChildViewController:self.deviceGroupVC];
    
    self.sceneVC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - HeaderItemHeight - quec_TabBarHeight());
    self.automateVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - HeaderItemHeight - quec_TabBarHeight());
    self.deviceGroupVC.view.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, ScreenHeight - HeaderItemHeight - quec_TabBarHeight());
    
    [self.scrollView addSubview: self.sceneVC.view];
    [self.scrollView addSubview: self.automateVC.view];
    [self.scrollView addSubview: self.deviceGroupVC.view];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * 3, ScreenHeight - HeaderItemHeight - quec_TabBarHeight());
    
    [self refreshUI];
    
}

- (void)refreshUI {
    if (self.isFamilyMode) {
        self.deviceGroupBtn.hidden = YES;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else {
        self.deviceGroupBtn.hidden = NO;
    }
}

- (void)itemAction:(UIButton *)sender {
    for (UIButton *button in self.headerItem.subviews) {
        button.selected = NO;
    }
    sender.selected = YES;
    
    [self.scrollView setContentOffset:CGPointMake(sender.tag * ScreenWidth, 0) animated:YES];
}

- (void)checkFamilyModeState {
    QuecWeakSelf(self);
    [QuecSmartHomeService.sharedInstance getFamilyModeConfigWithSuccess:^(NSDictionary *dictionary) {
        
        QuecStrongSelf(self);
        
        BOOL changed = QuecSmartHomeService.sharedInstance.enable != self.isFamilyMode;
        self.isFamilyMode = QuecSmartHomeService.sharedInstance.enable;
        
        if (changed) {//家庭模式发生了改变
            [self refreshUI];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - lazy
- (UIView *)headerItem {
    if (!_headerItem) {
        _headerItem = [[UIView alloc]init];
        [self.view addSubview:_headerItem];
    }
    return _headerItem;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


@end
