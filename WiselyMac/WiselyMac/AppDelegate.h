//
//  AppDelegate.h
//  WiselyMac
//
//  Created by Giorgio Pretto on 7/14/14.
//  Copyright (c) 2014 MCP 2014. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import "HTTPServer.h"
#import <AVKit/AVKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	HTTPServer *httpServer;
}
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet AVPlayerView *playerView;
@property NSURL *path;



-(void) setChannel:(NSInteger)channel;
-(void) play;
-(void) pause;
-(void) goToTime:(NSInteger)seconds;

@end
