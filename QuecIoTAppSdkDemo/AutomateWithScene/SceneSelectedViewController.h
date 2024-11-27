//
//  SceneSelectedViewController.h
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QuecDeviceModel;

typedef void (^SelectedDeviceListBlock)(NSArray<QuecDeviceModel *> *list);

@interface SceneSelectedViewController : UIViewController

@property(nonatomic, assign) BOOL isScene;
@property(nonatomic, assign) BOOL isAutomate;
@property (nonatomic, strong) NSArray *upSelectedArr;
@property (nonatomic, copy)SelectedDeviceListBlock listBlock;

@end

NS_ASSUME_NONNULL_END
