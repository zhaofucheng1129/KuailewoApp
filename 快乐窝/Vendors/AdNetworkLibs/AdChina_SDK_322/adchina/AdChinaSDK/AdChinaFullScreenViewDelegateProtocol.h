//
//  AdChinaFullScreenViewDelegateProtocol.h
//  AdChinaSDK
//
//  AdChina Publisher Code
//

#import "AdChinaUserInfoDelegateProtocol.h"

@class AdChinaFullScreenView;

@protocol AdChinaFullScreenViewDelegate <NSObject, AdChinaUserInfoDelegate>

@optional

- (void)didGetFullScreenAd:(AdChinaFullScreenView *)adView;
- (void)didFailToGetFullScreenAd:(AdChinaFullScreenView *)adView;

// Called when user opens an in-app web browser
// You may use this method to pause game animation, music, etc.
- (void)didEnterFullScreenMode;
- (void)didExitFullScreenMode;

// You may use these methods to count click/watch number by yourself
- (void)didClickFullScreenAd:(AdChinaFullScreenView *)adView;
- (void)didFinishWatchingFullScreenAd:(AdChinaFullScreenView *)adView;

/* The following delegate methods are used for Html5 Banner */

// Receives callback when the user shakes an html5 banner (Available for iOS < 4.2).
// UIAccelerometer's delegate will be set back to the original delegate when this is not an html5 ad.
- (void)accelerometer:(UIAccelerometer *)accelerometer detectedAcceleration:(UIAcceleration *)acceleration;

@end