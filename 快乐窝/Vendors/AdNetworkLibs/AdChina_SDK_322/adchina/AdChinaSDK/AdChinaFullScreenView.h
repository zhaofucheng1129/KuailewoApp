//
//  AdChinaFullScreenView.h
//  AdChinaSDK
//
//  AdChina Publisher Code
//

#import <UIKit/UIKit.h>
#import "AdChinaFullScreenViewDelegateProtocol.h"

@interface AdChinaFullScreenView : UIView

// returns newly created fullscreen ad
+ (AdChinaFullScreenView *)requestAdWithAdSpaceId:(NSString *)theAdSpaceId delegate:(id<AdChinaFullScreenViewDelegate>)theDelegate;

// Set view controller for browser, default view controller is delegate
- (void)setViewControllerForBrowser:(UIViewController *)controller;
//Set debugMode is YES,log the description in console
- (void)setDebugMode:(BOOL)isDebugging;

@end
