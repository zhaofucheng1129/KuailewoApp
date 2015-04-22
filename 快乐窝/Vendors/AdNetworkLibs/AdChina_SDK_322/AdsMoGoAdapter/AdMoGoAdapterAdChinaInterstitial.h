//
//  AdMoGoAdapterAdChinaInterstitial.h
//  wanghaotest
//
//  Created by mogo on 13-12-16.
//
//

#import "AdMoGoAdNetworkInterstitialAdapter.h"
#import "AdMoGoAdNetworkAdapter.h"
#import "AdChinaInterstitialViewDelegateProtocol.h"
#import "AdChinaInterstitialView.h"
@interface AdMoGoAdapterAdChinaInterstitial : AdMoGoAdNetworkInterstitialAdapter<AdChinaInterstitialViewDelegate>{
    AdChinaInterstitialView *_interstitialView;
    BOOL isStop;
    NSTimer *timer;
    BOOL isLoaded;
    CGRect initAdChinaFrame;
}
+ (AdMoGoAdNetworkType)networkType;
- (void)sendAdFullClick;
@property(nonatomic,retain)AdChinaInterstitialView *interstitialView;
@end
