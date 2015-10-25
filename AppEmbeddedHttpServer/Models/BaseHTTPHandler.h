//
//  BaseHTTPHandler.h
//  AppEmbeddedHttpServer
//
//  Created by 王展 on 15/10/25.
//  Copyright © 2015年 wangzhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPResponse.h"

@interface BaseHTTPHandler : NSObject

@property (strong, nonatomic, readonly) NSString *path;
@property (strong, nonatomic, readonly) NSString *method;

- (NSObject<HTTPResponse> *)handlePath:(NSString *)path method:(NSString *)method data:(NSData *)data;

@end
