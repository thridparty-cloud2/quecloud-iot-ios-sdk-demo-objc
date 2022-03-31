//
//  TlsTextTableViewCell.h
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/11/4.
//

#import <UIKit/UIKit.h>
#import <QuecDeviceKit/QuecDeviceKit.h>

@interface TlsTextTableViewCell : UITableViewCell

- (void)refreshCellWithModel:(QuecProductTSLPropertyModel *)model;

@end

