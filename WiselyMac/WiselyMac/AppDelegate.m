//
//  AppDelegate.m
//  WiselyMac
//
//  Created by Giorgio Pretto on 7/14/14.
//  Copyright (c) 2014 MCP 2014. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    
    // Configure our logging framework.
	// To keep things simple and fast, we're just going to log to the Xcode console.
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	// Initalize our http server
	httpServer = [[HTTPServer alloc] init];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[httpServer setType:@"_http._tcp."];
	
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
    //	[httpServer setPort:12345];
	
	// Serve files from the standard Sites folder
	NSString *docRoot = [@"~/Sites" stringByExpandingTildeInPath];
//	DDLogInfo(@"Setting document root: %@", docRoot);
	
	[httpServer setDocumentRoot:docRoot];
	
	NSError *error = nil;
	if(![httpServer start:&error])
	{
//		DDLogError(@"Error starting HTTP Server: %@", error);
	}

    
    
    // server started, let's load the default video and setup the player
    

    _path =[[NSBundle mainBundle] URLForResource:@"Frozen" withExtension:@"mp4"];

    _playerView.player = [[AVPlayer alloc] initWithURL:_path];
    [_playerView.player play];
    
    
    
    
}




-(void)setChannel:(NSInteger)channel {
    
    switch (channel) {
        case 1:
            _path = [[NSBundle mainBundle] URLForResource:@"Frozen" withExtension:@"mp4"];
            break;
        case 2:
            _path = [[NSBundle mainBundle] URLForResource:@"Edge" withExtension:@"mp4"];
            break;
        case 3:
            _path = [[NSBundle mainBundle] URLForResource:@"Strangelove" withExtension:@"mp4"];
            break;
        case 4:
            _path = [[NSBundle mainBundle] URLForResource:@"GoT" withExtension:@"mp4"];
            break;
        case 5:
            _path = [[NSBundle mainBundle] URLForResource:@"Matrix" withExtension:@"mp4"];
            break;
        case 6:
            _path = [[NSBundle mainBundle] URLForResource:@"Hobbit" withExtension:@"mp4"];
            break;
        case 7:
            _path = [[NSBundle mainBundle] URLForResource:@"X-Men" withExtension:@"mp4"];
            break;
        default:
            break;

    }
    
    _playerView.player = [[AVPlayer alloc] initWithURL:_path];
    [_playerView.player play];
    
    
}









@end
