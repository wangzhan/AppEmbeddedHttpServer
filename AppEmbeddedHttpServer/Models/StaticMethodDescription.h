//
//  StaticMethodDescription.h
//  AppEmbeddedHttpServer
//
//  Created by wangzhan on 15/10/22.
//  Copyright © 2015年 wangzhan. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "GenericType.h"

@interface StaticMethodDescription : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *methodName;
@property (strong, nonatomic) NSArray *arguments;
@property (nonatomic) ValueType returnType;

@end
