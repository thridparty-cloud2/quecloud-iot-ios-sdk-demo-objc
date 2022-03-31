//
//  QuecPlaloadDataModel.h
//  QuecBleChannelKit
//
//  Created by quectel.steven on 2021/11/17.
//

#import <Foundation/Foundation.h>

@interface QuecPayloadDataModel : NSObject

typedef enum : UInt8 {
    QuecPlaloadDataTypeBoolFalse,
    QuecPlaloadDataTypeBoolTrue,
    QuecPlaloadDataTypeNumberAndEnum,
    QuecPlaloadDataTypeBinary,
    QuecPlaloadDataTypeStruct,
} QuecPlaloadDataType;

// id
@property (nonatomic, assign) int Id;
// dataType
@property (nonatomic, assign) QuecPlaloadDataType dataType;
// value
@property (nonatomic, strong) id value;

+ (instancetype)getPayloadWithId:(int)Id dataType:(QuecPlaloadDataType)dataType value:(id)value;

@end

