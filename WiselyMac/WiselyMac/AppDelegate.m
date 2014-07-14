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
#import <CoreMedia/CoreMEdia.h>

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
    

    _path =[[NSBundle mainBundle] pathForResource:@"Frozen"ofType:@"mp4"];

    
    
    _player =[AVPlayer playerWithURL:[NSURL fileURLWithPath:_path]];
    [_player addObserver:self forKeyPath:@"status" options:0 context:nil];
    
    _playerView.player = _player;
    
    

    
    
    
    
    
//    NSURL *url = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
////    // You may find a test stream at <http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8>.
//    self.playerItem = [AVPlayerItem playerItemWithURL:url];
//    [_playerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];
//    self.player = [AVPlayer playerWithPlayerItem:playerItem];
//    
//    self.playerView.player = self.player;
    
    
}


-(void)goToTime:(NSInteger)seconds{
    [_playerView.player seekToTime:CMTimeMakeWithSeconds(seconds, 1)];
}
-(void)play{
    if (_player.status == AVPlayerStatusReadyToPlay) {
        [_player play];
    } else if (_player.status == AVPlayerStatusFailed) {
        NSLog(@"NOT READY TO PLAY");
    }
}
-(void)pause{
    [_playerView.player pause];
}

-(void)setChannel:(NSInteger)channel {
    
    switch (channel) {
        case 1:
            _path =[[NSBundle mainBundle] pathForResource:@"Frozen" ofType:@"mp4"];
            break;
        case 2:
            _path =[[NSBundle mainBundle] pathForResource:@"Edge" ofType:@"mp4"];
            break;
        case 3:
            _path =[[NSBundle mainBundle] pathForResource:@"Strangelove" ofType:@"mp4"];
            break;
        case 4:
            _path =[[NSBundle mainBundle] pathForResource:@"GoT" ofType:@"mp4"];
            break;
        case 5:
            _path =[[NSBundle mainBundle] pathForResource:@"Matrix" ofType:@"mp4"];
            break;
        case 6:
            _path =[[NSBundle mainBundle] pathForResource:@"Hobbit" ofType:@"mp4"];
            break;
        case 7:
            _path =[[NSBundle mainBundle] pathForResource:@"X-Men" ofType:@"mp4"];
            break;
        case 8:
            _path =[[NSBundle mainBundle] pathForResource:@"FullMatch" ofType:@"mp4"];
            break;
        default:
            _path =[[NSBundle mainBundle] pathForResource:@"X-Men" ofType:@"mp4"];
            break;

    }
//    BOOL playing = (_playerView.player.rate != 0.0f);
//    [_playerView.player pause];
//    _playerView.player = nil;
    [_player removeObserver:self forKeyPath:@"status" context:nil];
    _playerView.player = NULL;
    _player = NULL;
    _player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:_path]];
    [_player addObserver:self forKeyPath:@"status" options:0 context:nil];
    _playerView.player = _player;
    
    //if (playing)
//    [_playerView.player play];
    
    
}





- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (object == _player && [keyPath isEqualToString:@"status"]) {
        if (_player.status == AVPlayerStatusReadyToPlay) {
            [_player play];
        } else if (_player.status == AVPlayerStatusFailed) {
            NSLog(@"NOT READY TO PLAY");// something went wrong. player.error should contain some information
        }
    }
}



@end
