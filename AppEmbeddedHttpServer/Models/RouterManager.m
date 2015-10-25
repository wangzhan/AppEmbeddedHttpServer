//
//  RouterManager.m
//  AppEmbeddedHttpServer
//
//  Created by wangzhan on 15/10/22.
//  Copyright © 2015年 wangzhan. All rights reserved.
//

#import "RouterManager.h"
#import "DesEncryptHandler.h"
#import "DesDecryptHandler.h"

@interface RouterManager ()

@property (strong, nonatomic) NSDictionary *urlRouter;  /// <path, handler>

@end

@implementation RouterManager

+ (instancetype)sharedInstance {
    static RouterManager *instance = nil;
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // construct the urlRouter
        NSMutableDictionary *urlRouter = [[NSMutableDictionary alloc] init];
        DesEncryptHandler *desEntrypHandler = [[DesEncryptHandler alloc] init];
        urlRouter[desEntrypHandler.path] = desEntrypHandler;
        
        DesDecryptHandler *desDecryptHandler = [[DesDecryptHandler alloc] init];
        urlRouter[desDecryptHandler.path] = desDecryptHandler;
        
        self.urlRouter = urlRouter;
    }
    return self;
}

- (BOOL)isSupportedPath:(NSString *)path method:(NSString *)method {
    BOOL supported = NO;
    BaseHTTPHandler *handler = self.urlRouter[path];
    if (handler) {
        supported = [handler.method isEqualToString:method];
    }
    return supported;
}

- (NSObject<HTTPResponse> *)handlePath:(NSString *)path method:(NSString *)method data:(NSData *)data {
    NSObject<HTTPResponse> *response = nil;
    BaseHTTPHandler *handler = self.urlRouter[path];
    if (handler) {
        response = [handler handlePath:path method:method data:data];
    }
    return response;
}

@end
