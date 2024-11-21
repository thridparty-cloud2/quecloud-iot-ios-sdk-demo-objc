//
//  FamilyListViewController.h
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CurrentFidBlock)(NSString *fid);

@interface FamilyListViewController : UIViewController

@property (nonatomic, copy)CurrentFidBlock fidbBlock;


@end

NS_ASSUME_NONNULL_END
