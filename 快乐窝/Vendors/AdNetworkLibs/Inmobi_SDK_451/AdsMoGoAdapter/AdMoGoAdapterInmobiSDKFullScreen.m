//
//  AdMoGoAdapterInmobiSDKFullScreen.m
//  TestMOGOSDKAPP
//
//  Created by Daxiong on 12-11-21.
//
//

#import "AdMoGoAdapterInmobiSDKFullScreen.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoConfigDataCenter.h"

@implementation AdMoGoAdapterInmobiSDKFullScreen


+ (AdMoGoAdNetworkType)networkType{
    return AdMoGoAdNetworkTypeInMobi;
}

+ (void)load {
	[[AdMoGoAdSDKInterstitialNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    isStop = NO;
    isReady = NO;
    canRemove = YES;

    AdMoGoConfigDataCenter *configDataCenter = [AdMoGoConfigDataCenter singleton];
    
    AdMoGoConfigData *configData = [configDataCenter.config_dict objectForKey:[self getConfigKey]];
    
    AdViewType type =[configData.ad_type intValue];

	if (type == AdViewTypeFullScreen||
        type == AdViewTypeiPadFullScreen) {
        
//        [InMobi setLogLevel:IMLogLevelNone];
        //[InMobi setLogLevel:IMLogLevelDebug];
        [InMobi initialize:[self.ration objectForKey:@"key"]];
        
        interstitialAd = [[IMInterstitial alloc] initWithAppId:[self.ration objectForKey:@"key"]];
        interstitialAd.delegate = self;
        [interstitialAd loadInterstitial];
        [self adapterDidStartRequestAd:self];
        id _timeInterval = [self.ration objectForKey:@"to"];
        if ([_timeInterval isKindOfClass:[NSNumber class]]) {
            timer = [[NSTimer scheduledTimerWithTimeInterval:[_timeInterval doubleValue] target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
        }
        else{
            timer = [[NSTimer scheduledTimerWithTimeInterval:AdapterTimeOut15 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
        }
    }else{
        [self adapter:self didFailAd:nil];
    }
}

-(void)stopAd{
    [self stopBeingDelegate];
    isStop = YES;
}

-(void)stopBeingDelegate{
    
    if(interstitialAd && canRemove){
        MGLog(MGT,@"%s",__FUNCTION__);
        interstitialAd.delegate = nil;
        [interstitialAd release],interstitialAd = nil;
    }
}

-(void)dealloc{
    
    if(interstitialAd && canRemove){
        interstitialAd.delegate = nil;
        [interstitialAd release],interstitialAd = nil;
    }
    
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
    MGLog(MGD,@"inmobi插屏广告请求超时");
    if (isStop) {
        return;
    }
    
    [self stopTimer];
    [self stopBeingDelegate];
    [self adapter:self didFailAd:nil];
}


- (BOOL)isReadyPresentInterstitial{
    return isReady;
}

- (void)presentInterstitial{
    // 呈现插屏广告
    if (interstitialAd.state == kIMInterstitialStateReady) {
        [interstitialAd presentInterstitialAnimated:YES];
    }else{
        
        MGLog(MGT,@"%s ad is not ready",__FUNCTION__);
        MGLog(MGD,@"inmobi插屏广告还没有准备好");
        
    }
    
}
#pragma mark -
#pragma mark Inmobi delegate

/**
 * Sent when an interstitial ad request succeeded.
 * @param ad The IMInterstitial instance which finished loading.
 */
- (void)interstitialDidReceiveAd:(IMInterstitial *)ad{
    MGLog(MGD,@"inmobi插屏广告数据获取成功");
    if(isStop){
        return;
    }
    [self stopTimer];
    
    isReady = YES;
    [self adapter:self didReceiveInterstitialScreenAd:nil];
}

/**
 * Sent when an interstitial ad request failed
 * @param ad The IMInterstitial instance which failed to load.
 * @param error The IMError associated with the failure.
 */
- (void)interstitial:(IMInterstitial *)ad
didFailToReceiveAdWithError:(IMError *)error{
    MGLog(MGE,@"inMobi error-->%@",error);
    MGLog(MGD,@"inmobi插屏广告数据获取失败");
    if(isStop){
        return;
    }
    [self stopTimer];
    [self stopBeingDelegate];
    [self adapter:self didFailAd:error];

}

/**
 * Sent just before presenting an interstitial.  After this method finishes the
 * interstitial will animate onto the screen.  Use this opportunity to stop
 * animations and save the state of your application in case the user leaves
 * while the interstitial is on screen (e.g. to visit the App Store from a link
 * on the interstitial).
 * @param ad The IMInterstitial instance which will present the screen.
 */
- (void)interstitialWillPresentScreen:(IMInterstitial *)ad{
    if(isStop){
        return;
    }
    canRemove = NO;
    MGLog(MGD,@"inmobi插屏广告将要展示");
    [self adapter:self willPresent:ad];
    MGLog(MGD,@"inmobi插屏广告已经展示");
    [self adapter:self didShowAd:ad];

}

/**
 * Sent before the interstitial is to be animated off the screen.
 * @param ad The IMInterstitial instance which will dismiss the screen.
 */
- (void)interstitialWillDismissScreen:(IMInterstitial *)ad{
    MGLog(MGT,@"%s",__FUNCTION__);
    MGLog(MGD,@"inmobi插屏广告将要消失");
}

/**
 * Sent just after dismissing an interstitial and it has animated off the screen.
 * @param ad The IMInterstitial instance which was responsible for dismissing the screen.
 */
- (void)interstitialDidDismissScreen:(IMInterstitial *)ad{
    if(isStop){
        return;
    }
    canRemove = YES;
    MGLog(MGD,@"inmobi插屏广告已经消失");
    [self adapter:self didDismissScreen:ad];

}
/**
 * Callback sent just before the application goes into the background because
 * the user clicked on a link in the ad that will launch another application
 * (such as the App Store). The normal UIApplicationDelegate methods like
 * applicationDidEnterBackground: will immediately be called after this.
 * @param ad The IMInterstitial instance that is launching another application.
 */
- (void)interstitialWillLeaveApplication:(IMInterstitial *)ad{
    MGLog(MGD,@"inmobi插屏广告将要离开应用");
    MGLog(MGT,@"%s",__FUNCTION__);
}
/**
 * Called when the interstitial is tapped or interacted with by the user
 * Optional data is available to publishers to act on when using
 * monetization platform to render promotional ads.
 * @param ad The IMInterstitial instance which was responsible for this action.
 * @param dictionary The NSDictionary object which was passed from the ad.
 */
-(void)interstitialDidInteract:(IMInterstitial *)ad withParams:(NSDictionary *)dictionary{
    MGLog(MGD,@"inmobi插屏广告被点击");
    MGLog(MGT,@"%s %@",__FUNCTION__,dictionary);
    [self specialSendRecordNum];
}
/**
 * Called when the interstitial failed to display.
 * This should normally occur if the state != kIMInterstitialStateReady.
 * @param ad The IMInterstitial instance responsible for this error.
 * @param error The IMError associated with this failure.
 */
- (void)interstitial:(IMInterstitial *)ad didFailToPresentScreenWithError:(IMError *)error{
    MGLog(MGD,@"inmobi插屏广告展示失败");
    MGLog(MGT,@"%s",__FUNCTION__);
}

@end
