//
//  AdChinaInterstitialViewDelegateProtocol.h
//  AdChinaSDK_NARC
//
//  Created by AdChina on 13-8-23.
//  Copyright (c) 2013年 AdChina. All rights reserved.
//


//
//  AdChinaVideoViewDelegateProtocol.h
//  AdChinaSDK
//
//  AdChina Publisher Code
//

#import "AdChinaUserInfoDelegateProtocol.h"
@class AdChinaInterstitialView;

@protocol AdChinaInterstitialViewDelegate <NSObject, AdChinaUserInfoDelegate>

@optional

- (void)didGetInterstitialAd:(AdChinaInterstitialView *)adView;
- (void)didFailToGetInterstitialAd:(AdChinaInterstitialView *)adView;
- (void)didCloseInterstitialAd:(AdChinaInterstitialView *)adView;

// Called when user opens an in-app web browser
// You may use this method to pause game animation, music, etc.
- (void)didEnterFullScreenMode;
- (void)didExitFullScreenMode;

// You may use these methods to count click number by yourself
- (void)didClickInterstitialView:(AdChinaInterstitialView *)adView;

@end

