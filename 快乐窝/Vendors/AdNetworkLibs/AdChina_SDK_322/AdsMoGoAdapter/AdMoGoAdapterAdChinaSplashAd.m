//
//  File: AdMoGoAdapterAdChinaFullAd.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.2.1
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterAdChinaSplashAd.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkConfig.h" 
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoConfigData.h"
#import "AdChinaLocationManager.h"
//#import "AdMoGoAdSDKInterstitialNetworkRegistry.h"
@implementation AdMoGoAdapterAdChinaSplashAd
@synthesize fullScreenAd;
+ (AdMoGoAdNetworkType)networkType{
    return AdMoGoAdNetworkTypeAdChina;
}

+ (void)load{
    [[AdMoGoAdSDKSplashNetworkRegistry sharedRegistry] registerClass:self];
}


- (void)getAd {
    isFail = NO;
    isSuccess = NO;
    
    isStop = NO;
    isLoaded = NO;
    
    AdMoGoConfigDataCenter *configDataCenter = [AdMoGoConfigDataCenter singleton];
    
    AdMoGoConfigData *configData = [configDataCenter.config_dict objectForKey:splashAds.config_key];
    
    AdViewType type =[configData.ad_type intValue];
    
	if (type == AdViewTypeSplash) {
        if ([configData islocationOn] == FALSE) {
            [AdChinaLocationManager setLocationServiceEnabled:NO];
        }
        NSString *key = [self.ration objectForKey:@"key"];
        self.fullScreenAd = [AdChinaFullScreenView requestAdWithAdSpaceId:key  delegate:self];

        [self.splashAds adapterDidStartRequestSplashAd:self];
        id _timeInterval = [self.ration objectForKey:@"to"];
        if (_timeInterval && [_timeInterval isKindOfClass:[NSNumber class]]) {
            timer = [[NSTimer scheduledTimerWithTimeInterval:[_timeInterval doubleValue] target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
        }
        else{
            timer = [[NSTimer scheduledTimerWithTimeInterval:AdapterTimeOut12 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
        }
    }
}

- (void)stopBeingDelegate {
    /*2013*/
    if (fullScreenAd) {
        [fullScreenAd removeFromSuperview];
        fullScreenAd = nil;
    }
    
}

- (void)stopAd{
    [self stopBeingDelegate];
    [self stopTimer];
    isStop = YES;
}

- (void)dealloc {
    MGLog(MGT,@"remove ad");
    
    [super dealloc];
    
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}



/*2013*/
- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (isStop) {
        return;
    }
    
    [self stopTimer];
    [self stopBeingDelegate];
    [self adFailWith:nil];
}


- (void)adSuccess:(id) _awSplash{
    if (isSuccess==isFail && isSuccess == NO) {
        isSuccess = YES;
        [self.splashAds adSplashSuccess:self withSplash:_awSplash];
    }
}

- (void)adFailWith:(NSError *)error{
    if (isSuccess==isFail && isFail == NO) {
        isFail = YES;
        [self.splashAds adSplashFail:self withError:error];
    }
}




- (void)didGetFullScreenAd:(AdChinaFullScreenView *)adView{
	if (isStop) {
        return;
    }
    [self stopTimer];
    UIViewController *baseviewController =  [self.adMoGoSplashAdsDelegate adsMoGoSplashAdsViewControllerForPresentingModalView];
    if (baseviewController.navigationController != nil ) {
        baseviewController = baseviewController.navigationController;
        if ([[[UIDevice currentDevice] systemVersion] intValue]<7) {
            fullScreenAd.frame = CGRectMake(0.0, 20.0, fullScreenAd.frame.size.width, fullScreenAd.frame.size.height);
        }
    }
    [fullScreenAd setViewControllerForBrowser:baseviewController];
    [baseviewController.view addSubview:fullScreenAd];
    [self adSuccess:adView];
}

- (void)didFailToGetFullScreenAd:(AdChinaFullScreenView *)adView{
    if (isStop) {
        return;
    }
    [self stopTimer];
    [self adFailWith:nil];
}


- (void)didClickFullScreenAd:(AdChinaFullScreenView *)adView{
    if ([self.splashAds respondsToSelector:@selector(sendClickCountWithAdAdpter:)]) {
        [self.splashAds sendClickCountWithAdAdpter:self];
    }
}

- (void)didFinishWatchingFullScreenAd:(AdChinaFullScreenView *)adView{
    UIViewController *baseviewController =  [self.adMoGoSplashAdsDelegate adsMoGoSplashAdsViewControllerForPresentingModalView];
    if (baseviewController.navigationController != nil) {
        baseviewController = baseviewController.navigationController;
    }
    CGRect rect = baseviewController.view.frame;
    [fullScreenAd removeFromSuperview];
    baseviewController.view.frame = rect;
    fullScreenAd = nil;
    [self.splashAds  adSplash:self didDismiss:adView];
}


- (void)didBeginBrowsingAdWeb:(AdChinaFullScreenView *)fsView {
    
}

- (void)didFinishBrowsingAdWeb:(AdChinaFullScreenView *)fsView {
	
}



@end
