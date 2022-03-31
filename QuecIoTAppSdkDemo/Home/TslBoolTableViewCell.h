//
//  TslBoolTableViewCell.h
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/11/4.
//

#import <UIKit/UIKit.h>
#import <QuecDeviceKit/QuecDeviceKit.h>

@protocol TslBoolTableViewCellDelegate <NSObject>

- (void)stateChanged:(NSString *)state index:(NSInteger)index;

@end

@interface TslBoolTableViewCell : UITableViewCell

@property (nonatomic, weak) id<TslBoolTableViewCellDelegate> delegate;

- (void)refreshCellWithModel:(QuecProductTSLPropertyModel *)model index:(NSInteger)index;

@end

