//
//  CommandServer.m
//  AppEmbeddedHttpServer
//
//  Created by wangzhan on 15/10/22.
//  Copyright © 2015年 wangzhan. All rights reserved.
//

#import "CommandServer.h"
#import "RootHttpConnection.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "RootHttpConnection.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface CommandServer ()

@property (strong, nonatomic) HTTPServer *httpServer;

@end

@implementation CommandServer

+ (instancetype)sharedInstance {
    static CommandServer *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // Configure our logging framework.
        // To keep things simple and fast, we're just going to log to the Xcode console.
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        
        // Create server using our custom MyHTTPServer class
        self.httpServer = [[HTTPServer alloc] init];
        
        // Tell the server to broadcast its presence via Bonjour.
        // This allows browsers such as Safari to automatically discover our service.
        [self.httpServer setType:@"_http._tcp."];
        
        [self.httpServer setConnectionClass:[RootHttpConnection class]];
        
        // Normally there's no need to run our server on any specific port.
        // Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
        // However, for easy testing you may want force a certain port so you can just hit the refresh button.
        [self.httpServer setPort:12345];
        
        // Serve files from our embedded Web folder
        NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
        DDLogInfo(@"Setting document root: %@", webPath);
        
        [self.httpServer setDocumentRoot:webPath];
    }
    return self;
}

- (BOOL)startServer {
    // Start the server (and check for problems)
    BOOL success = NO;
    NSError *error;
    if([self.httpServer start:&error])
    {
        success = YES;
        DDLogInfo(@"Started HTTP Server on port %hu", [self.httpServer listeningPort]);
    }
    else
    {
        DDLogError(@"Error starting HTTP Server: %@", error);
    }
    return success;
}

- (void)stopServer {
    // There is no public(allowed in AppStore) method for iOS to run continiously in the background for our purposes (serving HTTP).
    // So, we stop the server when the app is paused (if a users exits from the app or locks a device) and
    // restart the server when the app is resumed (based on this document: http://developer.apple.com/library/ios/#technotes/tn2277/_index.html )
    
    [self.httpServer stop];
}

@end
