//
//  DeviceControlViewController.h
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/10/28.
//

#import <UIKit/UIKit.h>
#import <QuecDeviceKit/QuecDeviceKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DeviceControlViewController : UIViewController
@property (nonatomic, strong) QuecDeviceModel *dataModel;
@end

NS_ASSUME_NONNULL_END
