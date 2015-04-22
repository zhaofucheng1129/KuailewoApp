//
//  AdChinaVideoView.h
//  AdChinaSDK
//
//  AdChina Publisher Code
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "AdChinaVideoViewDelegateProtocol.h"

#define VideoSizeWithAdViewWidth(width)     CGSizeMake(width, width/4*3)

@interface AdChinaVideoView : UIView

// returns newly created video ad, you may start play later
+ (AdChinaVideoView *)requestAdWithAdSpaceId:(NSString *)theAdSpaceId delegate:(id<AdChinaVideoViewDelegate>)theDelegate shouldAutoPlay:(BOOL)shouldAutoPlay;

// Set view controller for browser, default view controller is delegate
- (void)setViewControllerForBrowser:(UIViewController *)controller;

// If autoPlay is set to NO, use this method to start playing
- (void)startPlaying;
//Set debugMode is YES,log the description in console
- (void)setDebugMode:(BOOL)isDebugging;

@end
