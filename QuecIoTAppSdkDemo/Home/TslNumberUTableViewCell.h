//
//  TslUTableViewCell.h
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/11/3.
//

#import <UIKit/UIKit.h>
#import <QuecDeviceKit/QuecDeviceKit.h>


@protocol TslNumberUTableViewCellDelegate <NSObject>

- (void)valueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface TslNumberUTableViewCell : UITableViewCell

@property (nonatomic, weak) id<TslNumberUTableViewCellDelegate> delegate;

- (void)refreshCellWithModel:(QuecProductTSLPropertyModel *)model index:(NSInteger)index;

@end

