//
//  AdMoGoAdNetworkInterstitialAdapter.h
//  TestMOGOSDKAPI
//
//  Created by Daxiong on 14-5-5.
//  Copyright (c) 2014年 Daxiong. All rights reserved.
//

#import "AdMoGoAdNetworkAdapter.h"

@interface AdMoGoAdNetworkInterstitialAdapter : AdMoGoAdNetworkAdapter
- (void)adapterDidStartRequestAd:(AdMoGoAdNetworkInterstitialAdapter *)adapter;
- (void)adapterS2SDidStartRequestAd:(AdMoGoAdNetworkInterstitialAdapter *)adapter withAdPlatformId:(id)pid;
- (void)adapter:(AdMoGoAdNetworkInterstitialAdapter *)adapter didReceiveInterstitialScreenAd:(id)ad;
- (void)adapter:(AdMoGoAdNetworkInterstitialAdapter *)_adapter didReceiveInterstitialScreenAd:(id)fullScreenAd viewTag:(int)viewTag;
- (void)adapter:(AdMoGoAdNetworkInterstitialAdapter *)adapter didShowAd:(id)ad;
- (void)adapter:(AdMoGoAdNetworkInterstitialAdapter *)adapter didFailAd:(id)ad;
- (void)adapter:(AdMoGoAdNetworkInterstitialAdapter *)adapter didDismissScreen:(id)ad;
- (void)adapter:(AdMoGoAdNetworkInterstitialAdapter *)adapter willPresent:(id)ad;

- (void)adapterAdModal:(AdMoGoAdNetworkAdapter *)_adapter willPresent:(id)InterstitialAd;
- (void)adapterAdModal:(AdMoGoAdNetworkAdapter *)_adapter didDismissScreen:(id)InterstitialAd;

- (void)premiumADClickDict:(id)dict;

- (BOOL)shouldAlertQAView:(id)view;

- (NSString *)getConfigKey;
- (void)sendExposureRecordNum;
- (void)sendClickRecordNum;
- (void)specialSendRecordNum;


- (UIViewController *)rootViewControllerForPresent;
@end
