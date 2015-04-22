//
//  AdMoGoAdapterInmobiSDKFullScreen.h
//  TestMOGOSDKAPP
//
//  Created by Daxiong on 12-11-21.
//
//

#import "AdMoGoAdNetworkInterstitialAdapter.h"
#import "AdMoGoAdNetworkAdapter.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "IMInterstitial.h"
#import "IMInterstitialDelegate.h"

@interface AdMoGoAdapterInmobiSDKFullScreen : AdMoGoAdNetworkInterstitialAdapter<IMInterstitialDelegate>{
    NSTimer *timer;
    BOOL isStop;
    IMInterstitial *interstitialAd;
    BOOL isReady;
    BOOL canRemove;
}

@end
