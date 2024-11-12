//
//  QuecOTAPlanInfoModel.h
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/11.
//

#import <Foundation/Foundation.h>


@class QuecComOTAPlanModel;
@interface QuecOTAPlanInfoModel : NSObject

@property(nonatomic , copy) NSString    *pk;
@property(nonatomic , copy) NSString    *dk;
@property(nonatomic , copy) NSString    *deviceName;
@property(nonatomic , copy) NSString    *planName;
@property(nonatomic , copy) NSString    *des;
@property(nonatomic,assign) int         otaStatus;
@property(nonatomic , copy) NSString    *productIcon;
@property(nonatomic,assign) BOOL        isAuto;
@property(nonatomic , copy) NSString    *planId;
@property(nonatomic , copy) NSString    *versionInfo;
@property(nonatomic,strong) NSArray<QuecComOTAPlanModel *>  *comArray;
@property(nonatomic,assign) float       upgradeProgress;
@property(nonatomic,assign) BOOL        isReloadByDetail;
@property(nonatomic,assign) int         userConfirmStatus;
@property(nonatomic,assign) BOOL        isPureBLEDevice;

@end

@interface QuecComOTAPlanModel : NSObject

@property(nonatomic , copy) NSString    *comName;
@property(nonatomic , copy) NSString    *comTargetVerion;

@end

