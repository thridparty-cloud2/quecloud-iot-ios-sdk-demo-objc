//
//  QuecVCManager.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/25.
//

#import "QuecVCManager.h"
#import <UIKit/UIKit.h>

static CGFloat _KQuecScreenTabBarHeight = CGFLOAT_MIN;

inline UIWindow * quec_MainWindow(void) {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    }
    for (UIWindow *window in windows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            return window;
        }
    }
    return nil;
}

inline UIViewController * quec_TopViewController(void) {
    UIViewController *topViewController = quec_MainWindow().rootViewController;
    UIViewController *temp = nil;
    
    while (YES) {
        temp = nil;
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            temp = ((UINavigationController *)topViewController).visibleViewController;
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            temp = ((UITabBarController *)topViewController).selectedViewController;
        }
        else if (topViewController.presentedViewController != nil) {
            temp = topViewController.presentedViewController;
        }
        
        if (temp != nil) {
            topViewController = temp;
        } else {
            break;
        }
    }
    
    return topViewController;
}

inline CGFloat quec_TabBarHeight(void) {
    return 49 + quec_ScreenSafeBottom();
}

inline CGFloat quec_ScreenSafeBottom(void) {
    return quec_ScreenSafeInsets().bottom;
}

inline UIEdgeInsets quec_ScreenSafeInsets(void) {
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        if (@available(iOS 13.0, *)) {
            safeAreaInsets = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;
        } else {
            safeAreaInsets = [[UIApplication sharedApplication] delegate].window.safeAreaInsets;
        }
    }
    return safeAreaInsets;
}

