//
//  CommandServer.h
//  AppEmbeddedHttpServer
//
//  Created by wangzhan on 15/10/22.
//  Copyright © 2015年 wangzhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandServer : NSObject

+ (instancetype)sharedInstance;
- (BOOL)startServer;
- (void)stopServer;

@end
