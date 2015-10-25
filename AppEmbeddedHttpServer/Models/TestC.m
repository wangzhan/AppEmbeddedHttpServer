//
//  TestC.m
//  AppEmbeddedHttpServer
//
//  Created by 王展 on 15/10/22.
//  Copyright © 2015年 wangzhan. All rights reserved.
//

#import "TestC.h"

@implementation TestC

+ (NSString *)staticWithA:(NSString *)a withB:(NSString *)b {
    return [NSString stringWithFormat:@"%@ + %@", a, b];
}

@end
