//
//  AudioPlayer.m
//  Share
//
//  Created by Lin Zhang on 11-4-26.
//  Copyright 2011年 www.eoemobile.com. All rights reserved.
//

#import "AudioPlayer.h"
#import "AudioStreamer.h"

@implementation AudioPlayer

@synthesize streamer;
@synthesize button;
@synthesize url;


- (id)init
{
    self = [super init];
    if (self) {
        
    }

    return self;
}

- (void)dealloc
{
    [super dealloc];
    [url release];
    [streamer release];
    [button release];
    [timer invalidate];
}


- (BOOL)isProcessing
{
    return [streamer isPlaying] || [streamer isWaiting] || [streamer isFinishing] ;
}

- (void)play
{        
    if (!streamer) {
        
        self.streamer = [[AudioStreamer alloc] initWithURL:self.url];
        
        // set up display updater
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                    [self methodSignatureForSelector:@selector(updateProgress)]];    
        [invocation setSelector:@selector(updateProgress)];
        [invocation setTarget:self];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             invocation:invocation 
                                                repeats:YES];
        
        // register the streamer on notification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playbackStateChanged:)
                                                     name:ASStatusChangedNotification
                                                   object:streamer];
    }
    
    if ([streamer isPlaying]) {
        [streamer pause];
    } else {
        [streamer start];
    }
}


- (void)stop
{    
//    [button setProgress:0];
//    [button stopSpin];

//    button.image = [UIImage imageNamed:playImage];
    [button setImage:[UIImage imageNamed:@"cell_sound_play_n"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"cell_sound_play_h"] forState:UIControlStateHighlighted];
    button = nil; // 避免播放器的闪烁问题
    [button release];
    
    // release streamer
	if (streamer)
	{        
		[streamer stop];
		[streamer release];
		streamer = nil;
        
        // remove notification observer for streamer
		[[NSNotificationCenter defaultCenter] removeObserver:self 
                                                        name:ASStatusChangedNotification
                                                      object:streamer];		
	}
}

- (void)updateProgress
{
    if (streamer.progress <= streamer.duration ) {
//        [button setProgress:streamer.progress/streamer.duration];
    } else {
//        [button setProgress:0.0f];
    }
}


/*
 *  observe the notification listener when loading an audio
 */
- (void)playbackStateChanged:(NSNotification *)notification
{
	if ([streamer isWaiting])
	{
//        button.image = [UIImage imageNamed:stopImage];
        [button setImage:[UIImage imageNamed:@"cell_sound_pause_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"cell_sound_pause_h"] forState:UIControlStateHighlighted];
//        [button startSpin];
    } else if ([streamer isIdle]) {
        [button setImage:[UIImage imageNamed:@"cell_sound_play_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"cell_sound_play_h"] forState:UIControlStateHighlighted];
		[self stop];		
	} else if ([streamer isPaused]) {
        [button setImage:[UIImage imageNamed:@"cell_sound_play_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"cell_sound_play_h"] forState:UIControlStateHighlighted];
//        [button stopSpin];
//        [button setColourR:0.0 G:0.0 B:0.0 A:0.0];
    } else if ([streamer isPlaying] || [streamer isFinishing]) {
        [button setImage:[UIImage imageNamed:@"cell_sound_pause_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"cell_sound_pause_h"] forState:UIControlStateHighlighted];
//        [button stopSpin];        
	} else {
        
    }
    
//    [button setNeedsLayout];    
//    [button setNeedsDisplay];
}


@end
