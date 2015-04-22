//
//  File: AdMoGoAdapterAdChinaFullAd.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.2.1
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//  AdChina v2.5.2

#import "AdMoGoAdNetworkAdapter.h"
#import "AdChinaFullScreenView.h"


@interface AdMoGoAdapterAdChinaSplashAd : AdMoGoAdNetworkAdapter<AdChinaFullScreenViewDelegate> {
    
    BOOL isStop;
    NSTimer *timer;
    BOOL isLoaded;
    BOOL isFail;
    BOOL isSuccess;
    UIViewController *baseViewController;
}
@property(nonatomic,retain)AdChinaFullScreenView *fullScreenAd;
+ (AdMoGoAdNetworkType)networkType;
//+ (NSDictionary *)networkType;
- (void)sendAdFullClick;
@end
