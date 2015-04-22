//
//  AdChinaVideoViewDelegateProtocol.h
//  AdChinaSDK
//
//  AdChina Publisher Code
//

#import "AdChinaUserInfoDelegateProtocol.h"

@class AdChinaVideoView;

@protocol AdChinaVideoViewDelegate <NSObject, AdChinaUserInfoDelegate>

@optional

- (void)didGetVideoAd:(AdChinaVideoView *)adView;
- (void)didFailToGetVideoAd:(AdChinaVideoView *)adView;
- (void)didCloseVideoAd:(AdChinaVideoView *)adView;

// Called when user opens an in-app web browser
// You may use this method to pause game animation, music, etc.
- (void)didEnterFullScreenMode;
- (void)didExitFullScreenMode;

// You may use these methods to count click/watch number by yourself
- (void)didClickVideoAd:(AdChinaVideoView *)adView;
- (void)didFinishWatchingVideoAd:(AdChinaVideoView *)adView;

@end
