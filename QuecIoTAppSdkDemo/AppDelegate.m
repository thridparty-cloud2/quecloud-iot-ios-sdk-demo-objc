//
//  AppDelegate.m
//  Demo
//
//  Created by Tank Tu() on 2022/3/5.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "MyCenterViewController.h"
#import "DeviceGroupViewController.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[QuecIoTAppSDK sharedInstance] setDebugMode:true];
    NSString *countryCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"QuecCountryCode"];
    NSString *userDomain = [[NSUserDefaults standardUserDefaults] objectForKey:@"QuecUserDomain"];
    NSString *userDomainSecret = [[NSUserDefaults standardUserDefaults] objectForKey:@"QuecUserDomainSecret"];
    NSNumber *cloudServiceType = [[NSUserDefaults standardUserDefaults] objectForKey:@"QuecCloudServiceType"];
    if (userDomain && userDomainSecret){
        [[QuecIoTAppSDK sharedInstance] startWithUserDomain:userDomain userDomainSecret:userDomainSecret cloudServiceType:[cloudServiceType quec_uInt]];
    }
    if (countryCode && countryCode.length > 0){
        [[QuecIoTAppSDK sharedInstance] setCountryCode:countryCode];
    }
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    self.window.backgroundColor = [UIColor whiteColor];
    // 同步检查登录状态
    if ([QuecUserService sharedInstance].isLogin) {
        self.window.rootViewController = [self getMainController];
    }
    else {
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    }
    // 异步检查是否登录状态
    [[QuecUserService sharedInstance] checkUserLoginState:^(BOOL isLogin) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isLogin) {
                self.window.rootViewController = [self getMainController];
            }
            else  {
                self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
            }
        });
    }];
    [self.window makeKeyAndVisible];
    // 设置token失效监听
    @quec_weakify(self);
    [[QuecUserService sharedInstance] setTokenInvalidCallBack:^{
        @quec_strongify(self);
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    }];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    return YES;
}

- (UIViewController *)getMainController {
    UITabBarController *tabbarVc = [[UITabBarController alloc] init];
    HomeViewController *homeVc=[[HomeViewController alloc]init];
    homeVc.tabBarItem.title=@"首页";
    homeVc.tabBarItem.image = [UIImage imageNamed:@"home_tarbar"];
    homeVc.tabBarItem.selectedImage = [UIImage imageNamed:@"home_tarbar_select"];
    homeVc.view.backgroundColor = [UIColor whiteColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateSelected];
    
    DeviceGroupViewController *groupVc=[[DeviceGroupViewController alloc]init];
    groupVc.tabBarItem.title=@"分组";
    groupVc.tabBarItem.image = [UIImage imageNamed:@"group_tabbar"];
    groupVc.tabBarItem.selectedImage = [UIImage imageNamed:@"group_tabbar_select"];
    groupVc.view.backgroundColor = [UIColor whiteColor];
    
    MyCenterViewController *myVc=[[MyCenterViewController alloc]init];
    myVc.tabBarItem.title=@"我的";
    myVc.tabBarItem.image = [UIImage imageNamed:@"user_tabbar"];
    myVc.tabBarItem.selectedImage = [UIImage imageNamed:@"user_tabbar_select"];
    myVc.view.backgroundColor = [UIColor whiteColor];
  
    tabbarVc.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:homeVc],
                                 [[UINavigationController alloc] initWithRootViewController:groupVc],
                                 [[UINavigationController alloc] initWithRootViewController:myVc]];
    
    return tabbarVc;
}


#pragma mark - UISceneSession lifecycle



@end
