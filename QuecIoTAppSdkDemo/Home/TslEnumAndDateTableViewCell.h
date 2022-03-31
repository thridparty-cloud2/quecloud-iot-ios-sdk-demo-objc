//
//  TslEnumAndDateTableViewCell.h
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/11/4.
//

#import <UIKit/UIKit.h>
#import <QuecDeviceKit/QuecDeviceKit.h>

@interface TslEnumAndDateTableViewCell : UITableViewCell

- (void)refreshCellWithModel:(QuecProductTSLPropertyModel *)model;

@end

