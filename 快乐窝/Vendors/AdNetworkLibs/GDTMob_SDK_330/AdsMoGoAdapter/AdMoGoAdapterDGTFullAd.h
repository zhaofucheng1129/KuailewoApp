//
//  AdMoGoAdapterDGTFullAd.h
//  wanghaotest
//
//  Created by  Darren 2014-8-26
//
//
#import "AdMoGoAdNetworkInterstitialAdapter.h"
#import <Foundation/Foundation.h>
#import "AdMoGoAdNetworkAdapter.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "GDTMobInterstitial.h"
#import "GDTSDKConfig.h"

@interface AdMoGoAdapterDGTFullAd : AdMoGoAdNetworkInterstitialAdapter<GDTMobInterstitialDelegate>{
    NSTimer *timer;
    BOOL isStop;
    GDTMobInterstitial *_interstitialObj;
    BOOL isReady;
    BOOL canRemove;
}

@end
