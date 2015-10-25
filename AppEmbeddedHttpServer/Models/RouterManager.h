//
//  RouterManager.h
//  AppEmbeddedHttpServer
//
//  Created by wangzhan on 15/10/22.
//  Copyright © 2015年 wangzhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPResponse.h"

@interface RouterManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isSupportedPath:(NSString *)path method:(NSString *)method;
- (NSObject<HTTPResponse> *)handlePath:(NSString *)path method:(NSString *)method data:(NSData *)data;

@end
