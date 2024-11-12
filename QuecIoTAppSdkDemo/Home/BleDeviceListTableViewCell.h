//
//  BleDeviceListTableViewCell.h
//  QuecIoTAppSdkDemo
//
//  Created by quectel.tank on 2023/6/14.
//

#import <UIKit/UIKit.h>
#import <QuecSmartConfigKit/QuecSmartConfigKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    QuecWaitingBind,
    QuecBinding,
    QuecBindingSucc,
    QuecBindingFail,
} QuecBindState;

@interface BleDeviceBindModel : NSObject
@property (nonatomic, strong) QuecPairingPeripheral *peripheral;
@property (nonatomic, assign) QuecBindState bindState;
@property (nonatomic, copy) NSString *errorMsg;
@end

@interface BleDeviceListTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^bindAction)(NSIndexPath *indexPath);

- (void)configureModel:(BleDeviceBindModel *)model indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
