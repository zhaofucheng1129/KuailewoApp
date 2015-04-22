/*
 *  AdChinaBannerViewDelegateProtocol.h
 *  AdChinaSDK
 *
 *  AdChina Publisher Code
 *
 */
//public void onReceiveAd(AdView view);
//public void onFailedToReceiveAd(AdView view);
//public void onClickBanner(AdView view);

#import "AdChinaUserInfoDelegateProtocol.h"
@class AdChinaBannerView;

@protocol AdChinaBannerViewDelegate <NSObject, AdChinaUserInfoDelegate>

// You may use this method to count click number by yourself
- (void)didClickBanner:(AdChinaBannerView *)adView;
@optional
//Called after bannerView display success
- (void)didReceiveAd:(AdChinaBannerView *)adView;
//Called after bannerView display fail
- (void)didFailedToReceiveAd:(AdChinaBannerView *)adView;

// Called when user opens a fullscreen view, e.g. in-app web browser, in-app sms view, etc.
// You may use this method to pause game animation, music, etc.
- (void)didEnterFullScreenMode;
- (void)didExitFullScreenMode;
/* The following delegate method is used for Html5 Banner */
// Receives callback when the user shakes an html5 banner (Available for iOS < 4.2).
// UIAccelerometer's delegate will be set back to the original delegate when this is not an html5 ad.

- (void)accelerometer:(UIAccelerometer *)accelerometer detectedAcceleration:(UIAcceleration *)acceleration;
@end