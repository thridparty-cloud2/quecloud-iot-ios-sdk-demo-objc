//
//  QuecPeripheralModel.h
//  QuecBleChannelKit
//
//  Created by quectel.steven on 2021/11/16.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface QuecPeripheralModel : NSObject

// name
@property (nonatomic, copy) NSString *name;
// mac
@property (nonatomic, copy) NSString *mac;
// uuid
@property (nonatomic, copy) NSString *uuid;
// peripheral
@property (nonatomic, strong) CBPeripheral *peripheral;

@end

