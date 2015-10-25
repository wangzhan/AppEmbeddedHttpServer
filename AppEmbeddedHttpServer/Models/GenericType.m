//
//  GenericType.m
//  AppEmbeddedHttpServer
//
//  Created by wangzhan on 15/10/22.
//  Copyright © 2015年 wangzhan. All rights reserved.
//

#import "GenericType.h"
#import "MTLValueTransformer.h"

@interface GenericType ()

@property (strong, nonatomic) id innerType;

@end

@implementation GenericType

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"innerType": @"type"
    };
}

- (id)value {
    return self.innerType;
}

@end
