//
//  RootHttpConnection.m
//  AppEmbeddedHttpServer
//
//  Created by wangzhan on 15/10/22.
//  Copyright © 2015年 wangzhan. All rights reserved.
//

#import "RootHttpConnection.h"
#import "HTTPMessage.h"
#import "HTTPDataResponse.h"
#import "DDNumber.h"
#import "HTTPLogging.h"
#import "StaticMethodDescription.h"
#import "RouterManager.h"
#import <objc/runtime.h>

// Log levels : off, error, warn, info, verbose
// Other flags: trace
static const int httpLogLevel = HTTP_LOG_LEVEL_WARN; // | HTTP_LOG_FLAG_TRACE;

@implementation RootHttpConnection

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
    HTTPLogTrace();
   
    // Add support for specified path and method
    if ([[RouterManager sharedInstance] isSupportedPath:path method:method]) {
        return YES;
    }
    
    return [super supportsMethod:method atPath:path];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path {
    NSObject<HTTPResponse> *response = [[RouterManager sharedInstance] handlePath:path method:method data:request.body];
    if (response == nil) {
        response = [super httpResponseForMethod:method URI:path];
    }
    return response;
    
    /*
    if ([method isEqualToString:@"POST"] && [path isEqualToString:@"/staticMethod"]) {
        NSString *json = [[NSString alloc] initWithData:request.body encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request.body options:0 error:nil];
        NSError *error;
        StaticMethodDescription *des = [MTLJSONAdapter modelOfClass:[StaticMethodDescription class] fromJSONDictionary:dict error:&error];
        if (error) {
            NSLog(@"error: %@", error);
        }
        
        if (des) {
            Class cls = NSClassFromString(des.className);
            if (cls) {
                if (class_respondsToSelector(cls, NSSelectorFromString(des.methodName))) {
                    int j = 0;
                }
            }
        }
        
        int i = 1;
    }
    
    return [super httpResponseForMethod:method URI:path];
     */
}

- (void)processBodyData:(NSData *)postDataChunk {
    HTTPLogTrace();
    
    // Remember: In order to support LARGE POST uploads, the data is read in chunks.
    // This prevents a 50 MB upload from being stored in RAM.
    // The size of the chunks are limited by the POST_CHUNKSIZE definition.
    // Therefore, this method may be called multiple times for the same POST request.
    
    BOOL result = [request appendData:postDataChunk];
    if (!result)
    {
        HTTPLogError(@"%@[%p]: %@ - Couldn't append bytes!", THIS_FILE, self, THIS_METHOD);
    }
}

@end
