//
//  GenericType.h
//  AppEmbeddedHttpServer
//
//  Created by wangzhan on 15/10/22.
//  Copyright © 2015年 wangzhan. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

typedef enum : NSUInteger {
    ValueTypeBool = 0,
    ValueTypeInt,
    ValueTypeLong,
    ValueTypeDouble,
    ValueTypeString
} ValueType;

@interface GenericType : MTLModel<MTLJSONSerializing>

@property (nonatomic) ValueType type;
@property (strong, nonatomic, readonly) id value;

@end
