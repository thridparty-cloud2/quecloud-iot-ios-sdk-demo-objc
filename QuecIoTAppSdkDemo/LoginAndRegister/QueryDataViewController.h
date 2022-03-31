//
//  QueryDataViewController.h
//  QuecUserKitExample
//
//  Created by quectel.steven on 2021/9/4.
//

#import <UIKit/UIKit.h>

@protocol QueryDataViewControllerDelegate <NSObject>

- (void)selectId:(NSInteger)itemId value:(NSString *)value type:(NSInteger)type;

@end

NS_ASSUME_NONNULL_BEGIN

@interface QueryDataViewController : UIViewController
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, weak) id<QueryDataViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
